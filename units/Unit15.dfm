object ValueList: TValueList
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = #1056#1077#1079#1091#1083#1100#1090#1072#1090#1099' '#1089#1082#1072#1085#1080#1088#1086#1074#1072#1085#1080#1103':'
  ClientHeight = 278
  ClientWidth = 579
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 240
    Width = 579
    Height = 38
    Align = alBottom
    BevelOuter = bvNone
    Caption = 'Panel1'
    ShowCaption = False
    TabOrder = 0
    object BitBtn1: TBitBtn
      Left = 456
      Top = 6
      Width = 115
      Height = 25
      Caption = #1048#1084#1087#1086#1088#1090#1080#1088#1086#1074#1072#1090#1100
      TabOrder = 0
      OnClick = BitBtn1Click
    end
    object BitBtn2: TBitBtn
      Left = 336
      Top = 6
      Width = 114
      Height = 25
      Caption = #1047#1072#1082#1088#1099#1090#1100
      TabOrder = 1
      OnClick = BitBtn2Click
    end
    object BitBtn3: TBitBtn
      Left = 8
      Top = 6
      Width = 33
      Height = 25
      Caption = '[ * ]'
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 47
      Top = 6
      Width = 33
      Height = 25
      Caption = '[    ]'
      TabOrder = 3
      OnClick = BitBtn4Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 579
    Height = 240
    Align = alClient
    BevelOuter = bvNone
    Caption = 'Panel2'
    Color = clInfoBk
    ParentBackground = False
    ShowCaption = False
    TabOrder = 1
    ExplicitLeft = 208
    ExplicitTop = 112
    ExplicitWidth = 185
    ExplicitHeight = 41
    object List: TCheckListBox
      Left = 0
      Top = 0
      Width = 579
      Height = 240
      Align = alClient
      BevelInner = bvNone
      BevelOuter = bvNone
      BorderStyle = bsNone
      ItemHeight = 13
      TabOrder = 0
    end
  end
end
