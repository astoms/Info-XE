object MainForm: TMainForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'MainForm'
  ClientHeight = 109
  ClientWidth = 590
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 59
    Width = 74
    Height = 13
    Caption = #1063#1077#1088#1077#1079' $ '#1076#1085#1077#1081': '
  end
  object Label2: TLabel
    Left = 351
    Top = 59
    Width = 73
    Height = 13
    Caption = 'E-Mail '#1072#1076#1088#1077#1089#1089': '
  end
  object BitBtn1: TBitBtn
    Left = 120
    Top = 24
    Width = 225
    Height = 21
    Caption = #1040#1074#1090#1086#1084#1072#1090#1080#1095#1077#1089#1082#1080#1081' '#1088#1072#1089#1095#1077#1090' '#1087#1086' '#1074#1088#1077#1084#1077#1085#1080
    TabOrder = 0
  end
  object DateTimePicker1: TDateTimePicker
    Left = 24
    Top = 24
    Width = 81
    Height = 21
    Date = 42580.041666666660000000
    Time = 42580.041666666660000000
    Kind = dtkTime
    TabOrder = 1
  end
  object Button1: TButton
    Left = 120
    Top = 51
    Width = 225
    Height = 21
    Caption = #1047#1072#1087#1091#1089#1090#1080#1090#1100' '#1088#1072#1089#1095#1077#1090' '#1089#1077#1081#1095#1072#1089
    TabOrder = 2
    OnClick = Button1Click
  end
  object BitBtn2: TBitBtn
    Left = 120
    Top = 78
    Width = 225
    Height = 21
    Caption = #1074#1082#1083#1102#1095#1080#1090#1100': E-Mail'
    TabOrder = 3
  end
  object Edit1: TEdit
    Left = 24
    Top = 78
    Width = 81
    Height = 21
    TabOrder = 4
    Text = '5'
  end
  object Edit2: TEdit
    Left = 351
    Top = 78
    Width = 210
    Height = 21
    TabOrder = 5
    Text = 'gurinenko@tut.by'
  end
  object Button2: TButton
    Left = 430
    Top = 22
    Width = 75
    Height = 25
    Caption = #1056#1072#1089#1095#1077#1090
    TabOrder = 6
    OnClick = Button2Click
  end
  object OraQuery: TADOQuery
    Connection = OraSes
    Parameters = <>
    Left = 424
    Top = 8
  end
  object OraSes: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDAORA.1;Password=qqq;User ID=supermag;Data Source=MIL' +
      'E_CO;Persist Security Info=True'
    LoginPrompt = False
    Provider = 'MSDAORA.1'
    Left = 368
    Top = 8
  end
  object MS_Conn: TADOConnection
    Connected = True
    ConnectionString = 
      'Provider=MSDASQL.1;Password=kj87dyt;Persist Security Info=True;U' +
      'ser ID=root;Extended Properties="Driver=MySQL ODBC 5.3 Unicode D' +
      'river;SERVER=192.168.1.242;UID=root;DATABASE=info;PORT=3306;COLU' +
      'MN_SIZE_S32=1"'
    LoginPrompt = False
    Left = 488
    Top = 8
  end
  object MS_Query: TADOQuery
    Connection = MS_Conn
    Parameters = <>
    Left = 544
    Top = 8
  end
  object MS_Query2: TADOQuery
    Connection = MS_Conn
    Parameters = <>
    Left = 544
    Top = 56
  end
  object MS_Query3: TADOQuery
    Connection = MS_Conn
    Parameters = <>
    Left = 472
    Top = 56
  end
end
