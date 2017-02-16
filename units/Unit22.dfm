object PrintForm: TPrintForm
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1053#1072#1089#1090#1088#1086#1081#1082#1072' '#1087#1077#1095#1072#1090#1080': '
  ClientHeight = 281
  ClientWidth = 308
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 24
    Top = 16
    Width = 52
    Height = 19
    Caption = #1044#1072#1090#1072': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label2: TLabel
    Left = 24
    Top = 41
    Width = 99
    Height = 19
    Caption = #1050#1072#1090#1077#1075#1086#1088#1080#1103': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label3: TLabel
    Left = 206
    Top = 43
    Width = 75
    Height = 19
    Caption = #1060#1086#1088#1084#1072#1090': '
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object DTP: TDateTimePicker
    Left = 82
    Top = 16
    Width = 199
    Height = 21
    Date = 42782.530314826390000000
    Time = 42782.530314826390000000
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 240
    Width = 308
    Height = 41
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 82
    ExplicitTop = 200
    ExplicitWidth = 185
    object BitBtn1: TBitBtn
      Left = 206
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1050
      TabOrder = 0
    end
    object BitBtn2: TBitBtn
      Left = 125
      Top = 8
      Width = 75
      Height = 25
      Caption = #1054#1058#1052#1045#1053#1040
      TabOrder = 1
    end
  end
  object Cat: TCheckListBox
    Left = 24
    Top = 66
    Width = 121
    Height = 135
    ItemHeight = 13
    TabOrder = 2
  end
  object Format: TCheckListBox
    Left = 160
    Top = 66
    Width = 121
    Height = 135
    ItemHeight = 13
    TabOrder = 3
  end
  object Action: TCheckBox
    Left = 24
    Top = 207
    Width = 257
    Height = 17
    Caption = #1042#1079#1103#1090#1100' '#1094#1077#1085#1099' '#1080#1079' '#1092#1072#1081#1083#1072' ?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    TabOrder = 4
  end
end
