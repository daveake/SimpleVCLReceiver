object Form1: TForm1
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Simple LoRa HAB Receiver'
  ClientHeight = 691
  ClientWidth = 1242
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -16
  Font.Name = 'Tahoma'
  Font.Style = []
  OnCreate = FormCreate
  TextHeight = 19
  object Label1: TLabel
    Left = 24
    Top = 24
    Width = 79
    Height = 19
    Alignment = taRightJustify
    Caption = 'Serial Port:'
  end
  object Label6: TLabel
    Left = 7
    Top = 76
    Width = 98
    Height = 19
    Alignment = taRightJustify
    Caption = 'Current RSSI:'
  end
  object Label14: TLabel
    Left = 24
    Top = 132
    Width = 78
    Height = 19
    Alignment = taRightJustify
    Caption = 'Frequency:'
  end
  object Label15: TLabel
    Left = 210
    Top = 132
    Width = 30
    Height = 19
    Caption = 'MHz'
  end
  object Label2: TLabel
    Left = 69
    Top = 180
    Width = 44
    Height = 19
    Alignment = taRightJustify
    Caption = 'Mode:'
  end
  object Label9: TLabel
    Left = 19
    Top = 260
    Width = 83
    Height = 19
    Alignment = taRightJustify
    Caption = 'Freq. Error:'
  end
  object Label10: TLabel
    Left = 220
    Top = 260
    Width = 90
    Height = 19
    Alignment = taRightJustify
    Caption = 'Packet RSSI:'
  end
  object Label11: TLabel
    Left = 450
    Top = 260
    Width = 36
    Height = 19
    Alignment = taRightJustify
    Caption = 'SNR:'
  end
  object Label3: TLabel
    Left = 41
    Top = 312
    Width = 61
    Height = 19
    Alignment = taRightJustify
    Caption = 'Callsign:'
  end
  object Label4: TLabel
    Left = 40
    Top = 352
    Width = 62
    Height = 19
    Alignment = taRightJustify
    Caption = 'Counter:'
  end
  object Label5: TLabel
    Left = 256
    Top = 312
    Width = 42
    Height = 19
    Alignment = taRightJustify
    Caption = 'Time:'
  end
  object Label7: TLabel
    Left = 237
    Top = 352
    Width = 61
    Height = 19
    Alignment = taRightJustify
    Caption = 'Altitude:'
  end
  object Label8: TLabel
    Left = 424
    Top = 352
    Width = 76
    Height = 19
    Alignment = taRightJustify
    Caption = 'Longitude:'
  end
  object Label13: TLabel
    Left = 438
    Top = 312
    Width = 62
    Height = 19
    Alignment = taRightJustify
    Caption = 'Latitude:'
  end
  object lstCommands: TListBox
    Left = 475
    Top = 165
    Width = 121
    Height = 57
    ItemHeight = 19
    TabOrder = 6
    Visible = False
  end
  object ComboBox1: TComboBox
    Left = 120
    Top = 21
    Width = 181
    Height = 27
    Style = csDropDownList
    Sorted = True
    TabOrder = 0
    OnCloseUp = ComboBox1CloseUp
  end
  object pnlCommStatus: TPanel
    Left = 332
    Top = 20
    Width = 265
    Height = 27
    BevelOuter = bvLowered
    Caption = 'Please choose serial port'
    TabOrder = 1
  end
  object pnlRSSI: TPanel
    Left = 119
    Top = 72
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 2
  end
  object btnSet: TButton
    Left = 467
    Top = 130
    Width = 130
    Height = 92
    Caption = 'Set'
    TabOrder = 3
    OnClick = btnSetClick
  end
  object edtFrequency: TEdit
    Left = 119
    Top = 129
    Width = 85
    Height = 27
    TabOrder = 4
    Text = '434.425'
  end
  object Panel1: TPanel
    Left = 12
    Top = 111
    Width = 585
    Height = 5
    BevelOuter = bvLowered
    TabOrder = 5
  end
  object cmbMode: TComboBox
    Left = 119
    Top = 177
    Width = 112
    Height = 27
    ItemIndex = 1
    TabOrder = 7
    Text = '1 - Fast'
    Items.Strings = (
      '0 - Slow'
      '1 - Fast'
      '2 - Repeater'
      '3 - Turbo'
      '4 - TurboX'
      '5 - Calling'
      '6 - Uplink'
      '7 - Telnet')
  end
  object Panel2: TPanel
    Left = 7
    Top = 236
    Width = 585
    Height = 5
    BevelOuter = bvLowered
    TabOrder = 8
  end
  object pnlFrequencyError: TPanel
    Left = 119
    Top = 256
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 9
  end
  object pnlPacketRSSI: TPanel
    Left = 327
    Top = 256
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 10
  end
  object pnlPacketSNR: TPanel
    Left = 503
    Top = 256
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 11
  end
  object Panel3: TPanel
    Left = 12
    Top = 61
    Width = 585
    Height = 5
    BevelOuter = bvLowered
    TabOrder = 12
  end
  object Panel4: TPanel
    Left = 12
    Top = 289
    Width = 585
    Height = 5
    BevelOuter = bvLowered
    TabOrder = 13
  end
  object chkAFC: TCheckBox
    Left = 331
    Top = 76
    Width = 97
    Height = 21
    Caption = 'AFC'
    TabOrder = 14
  end
  object lstPackets: TListBox
    Left = 0
    Top = 388
    Width = 606
    Height = 303
    Font.Charset = ANSI_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Courier New'
    Font.Style = []
    ItemHeight = 18
    ParentFont = False
    TabOrder = 15
  end
  object Panel5: TPanel
    Left = 119
    Top = 308
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 16
  end
  object Panel6: TPanel
    Left = 119
    Top = 348
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 17
  end
  object Panel7: TPanel
    Left = 304
    Top = 308
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 18
  end
  object Panel8: TPanel
    Left = 304
    Top = 348
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 19
  end
  object Panel9: TPanel
    Left = 508
    Top = 308
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 20
  end
  object Panel10: TPanel
    Left = 508
    Top = 348
    Width = 89
    Height = 27
    BevelOuter = bvLowered
    TabOrder = 21
  end
  object FNCMap: TTMSFNCMaps
    Left = 612
    Top = 0
    Width = 630
    Height = 691
    Align = alRight
    ParentDoubleBuffered = False
    DoubleBuffered = True
    TabOrder = 22
    Polylines = <>
    Polygons = <>
    Circles = <>
    Rectangles = <>
    Markers = <>
    ElementContainers = <>
    HeadLinks = <>
    Options.DefaultLatitude = 52.000000000000000000
    Options.DefaultLongitude = -2.500000000000000000
    Options.DefaultZoomLevel = 12.000000000000000000
    Service = msOpenLayers
    LocalFileAccess = True
  end
  object VaComm1: TVaComm
    Baudrate = br57600
    FlowControl.OutCtsFlow = False
    FlowControl.OutDsrFlow = False
    FlowControl.ControlDtr = dtrEnabled
    FlowControl.ControlRts = rtsEnabled
    FlowControl.XonXoffOut = False
    FlowControl.XonXoffIn = False
    FlowControl.DsrSensitivity = False
    FlowControl.TxContinueOnXoff = False
    DeviceName = 'COM%d'
    SettingsStore.RegRoot = rrCURRENTUSER
    SettingsStore.Location = slINIFile
    OnRxChar = VaComm1RxChar
    Version = '2.2.0.1'
    Left = 315
    Top = 4
  end
  object tmrCommands: TTimer
    Interval = 100
    OnTimer = tmrCommandsTimer
    Left = 499
    Top = 16
  end
  object IdHTTP1: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 555
    Top = 40
  end
  object IdHTTP2: TIdHTTP
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.ContentRangeEnd = -1
    Request.ContentRangeStart = -1
    Request.ContentRangeInstanceLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    Request.Ranges.Units = 'bytes'
    Request.Ranges = <>
    HTTPOptions = [hoForceEncodeParams]
    Left = 555
    Top = 96
  end
end
