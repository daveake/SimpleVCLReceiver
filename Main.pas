unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Registry, StdCtrls, ExtCtrls, VaClasses, VaComm, Mask, AdvSpin,
  SyncObjs, ComCtrls, VCL.TMSFNCTypes,
  VCL.TMSFNCUtils, VCL.TMSFNCGraphics, VCL.TMSFNCGraphicsTypes,
  VCL.TMSFNCMapsCommonTypes, VCL.TMSFNCCustomControl, VCL.TMSFNCWebBrowser,
  VCL.TMSFNCMaps, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    ComboBox1: TComboBox;
    pnlCommStatus: TPanel;
    VaComm1: TVaComm;
    Label6: TLabel;
    pnlRSSI: TPanel;
    btnSet: TButton;
    Label14: TLabel;
    edtFrequency: TEdit;
    Label15: TLabel;
    Panel1: TPanel;
    lstCommands: TListBox;
    tmrCommands: TTimer;
    Label2: TLabel;
    cmbMode: TComboBox;
    Panel2: TPanel;
    pnlFrequencyError: TPanel;
    Label9: TLabel;
    pnlPacketRSSI: TPanel;
    Label10: TLabel;
    Label11: TLabel;
    pnlPacketSNR: TPanel;
    IdHTTP1: TIdHTTP;
    Panel3: TPanel;
    IdHTTP2: TIdHTTP;
    Panel4: TPanel;
    chkAFC: TCheckBox;
    lstPackets: TListBox;
    Label3: TLabel;
    Panel5: TPanel;
    Label4: TLabel;
    Panel6: TPanel;
    Label5: TLabel;
    Panel7: TPanel;
    Label7: TLabel;
    Panel8: TPanel;
    Label8: TLabel;
    Label13: TLabel;
    Panel9: TPanel;
    Panel10: TPanel;
    FNCMap: TTMSFNCMaps;
    procedure FormCreate(Sender: TObject);
    procedure ComboBox1CloseUp(Sender: TObject);
    procedure VaComm1RxChar(Sender: TObject; Count: Integer);
    procedure btnSetClick(Sender: TObject);
    procedure tmrCommandsTimer(Sender: TObject);
  private
    { Private declarations }
    FrequencyError: Double;
    procedure ParseSentence(Line: AnsiString);
    procedure ProcessLine(Line: AnsiString);
    procedure ApplyAFC;
    procedure ShowOnMap(Callsign: String; Latitude, Longitude: Double);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;

implementation

{$R *.dfm}


procedure TForm1.btnSetClick(Sender: TObject);
begin
    lstCommands.Items.Clear;
    lstCommands.Items.Add('~F' + edtFrequency.Text);
    lstCommands.Items.Add('~M' + IntToStr(cmbMode.ItemIndex));
//    if cmbCoding.ItemIndex > 0 then begin
//        lstCommands.Items.Add('~E' + IntToStr(cmbCoding.ItemIndex+4));
//    end;
//    if cmbSpreading.ItemIndex > 0 then begin
//        lstCommands.Items.Add('~S' + IntToStr(cmbSpreading.ItemIndex+5));
//    end;
//    if cmbBandwidth.ItemIndex > 0 then begin
//        lstCommands.Items.Add('~B' + cmbBandwidth.Text);
//    end;
//    if cmbImplicit.ItemIndex > 0 then begin
//        lstCommands.Items.Add('~I' + IntToStr(cmbImplicit.ItemIndex-1));
//    end;
end;

procedure TForm1.ComboBox1CloseUp(Sender: TObject);
begin
    VaComm1.Close;
    if ComboBox1.ItemIndex >= 0 then begin
        try
            VaComm1.DeviceName := ComboBox1.Text;
            VaComm1.Open;
            pnlCommStatus.Caption := VaComm1.DeviceName + ' open';
        except
            pnlCommStatus.Caption := VaComm1.DeviceName + ' failed to open';
        end;
    end;
end;

procedure TForm1.FormCreate(Sender: TObject);
var
  reg: TRegistry;
  st: Tstrings;
  i: Integer;
begin
    ComboBox1.Items.Clear;

    reg := TRegistry.Create;
    try
        reg.RootKey := HKEY_LOCAL_MACHINE;
        reg.OpenKeyReadOnly('hardware\devicemap\serialcomm');
        st := TstringList.Create;
        try
            reg.GetValueNames(st);
            for i := 0 to st.Count - 1 do begin
                ComboBox1.Items.Add(reg.Readstring(st.strings[i]));
            end;
        finally
            st.Free;
        end;
        reg.CloseKey;
    finally
        reg.Free;
    end;
end;

function GetString(var Line: AnsiString; Delimiter: String=','): AnsiString;
var
    Position: Integer;
begin
    Position := Pos(Delimiter, string(Line));
    if Position > 0 then begin
        Result := Copy(Line, 1, Position-1);
        Line := Copy(Line, Position+Length(Delimiter), Length(Line));
    end else begin
        Result := Line;
        Line := '';
    end;
end;

procedure TForm1.ShowOnMap(Callsign: String; Latitude, Longitude: Double);
const
    Marker: TTMSFNCMapsMarker = nil;
begin
    FNCMap.BeginUpdate;

    if Marker = nil then begin
        Marker := FNCMap.Markers.Add;
        Marker.Title := Callsign;
        Marker.IconURL := StringReplace('File://' + ExtractFilePath(Application.ExeName) + '\balloon-blue.png', '\', '/', [rfReplaceAll, rfIgnoreCase]);
    end;

    Marker.Latitude := Latitude;
    Marker.Longitude := Longitude;

    FNCMap.EndUpdate;
end;


procedure TForm1.ParseSentence(Line: AnsiString);
var
    Fields: TStringList;
    Temp, HostName, IPAddress, MessageType: String;
    Start, Offset: Integer;
begin
    Start := Pos('$$', Line);
    if Start > 0 then begin
        Fields := TStringList.Create;

        Fields.Delimiter       := ',';
        Fields.StrictDelimiter := True;
        Fields.DelimitedText   := Copy(Line, Start+2, Length(Line));

        if Fields.Count > 5 then begin
            Panel5.Caption := Fields[0];        // Callsign
            Panel6.Caption := Fields[1];        // Counter
            Panel7.Caption := Fields[2];        // Time (UTC)
            Panel9.Caption := Fields[3];        // Latitude
            Panel10.Caption := Fields[4];       // Longitude
            Panel8.Caption := Fields[5];        // Altitude

            ShowOnMap(Fields[0], StrToFloat(Fields[3]), StrToFloat(Fields[4]));
        end;

        Fields.Free;
    end;
end;

procedure TForm1.ProcessLine(Line: AnsiString);
var
    Command: AnsiString;
begin
    Command := UpperCase(GetString(Line, '='));

    if Command = 'CURRENTRSSI' then begin
        pnlRSSI.Caption := string(Line + 'dBm');
    end else if Command = 'MESSAGE' then begin
        ApplyAFC;
        ParseSentence(Line);
    end else if Command = 'HEX' then begin
    end else if Command = 'FREQERR' then begin
        pnlFrequencyError.Caption := Line + ' kHz';
        FrequencyError := StrToFloat(Line);
    end else if Command = 'PACKETRSSI' then begin
        pnlPacketRSSI.Caption := Line;
    end else if Command = 'PACKETSNR' then begin
        pnlPacketSNR.Caption := Line;
    end;
end;

procedure TForm1.ApplyAFC;
begin
    if chkAFC.Checked then begin
        if Abs(FrequencyError) > 1 then begin
            edtFrequency.Text := FormatFloat('0.000', StrToFloat(edtFrequency.Text) + FrequencyError / 1000);
            lstCommands.Items.Add('~F' + edtFrequency.Text);
        end;
    end;
end;

procedure TForm1.tmrCommandsTimer(Sender: TObject);
begin
    if lstCommands.Items.Count > 0 then begin
        VaComm1.WriteText(lstCommands.Items[0] + #13);
        lstCommands.Items.Delete(0);
    end;
end;

procedure TForm1.VaComm1RxChar(Sender: TObject; Count: Integer);
const
    Buffer: AnsiString = '';
var
    i: Integer;
    Character: AnsiChar;
begin
    for i := 1 to Count do begin
        VaComm1.ReadChar(Character);

        try
            if (Character = Chr(10)) or (Character = Chr(13)) then begin
                if Length(Buffer) > 0 then begin
                    lstPackets.Items.Add(Buffer);
                    lstPackets.ItemIndex := lstPackets.Items.Count-1;
                    ProcessLine(Buffer);
                    Buffer := '';
                end;
            end else begin
                if Length(Buffer) < 1000 then begin
                    Buffer := Buffer + Character;
                end;
            end;
        except
        end;
    end;
end;

end.
