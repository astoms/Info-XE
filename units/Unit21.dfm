object ZvMessage: TZvMessage
  Left = 0
  Top = 0
  AlphaBlend = True
  AlphaBlendValue = 220
  Anchors = []
  BorderIcons = [biSystemMenu]
  BorderStyle = bsDialog
  Caption = #1057#1082#1083#1072#1076':'
  ClientHeight = 85
  ClientWidth = 331
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 8
    Top = 19
    Width = 240
    Height = 19
    Caption = #1057#1086#1086#1073#1097#1077#1085#1080#1077': '#1047#1072#1103#1074#1082#1072' '#8470' 0 '#1075#1086#1090#1086#1074#1072'.'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object BitBtn1: TBitBtn
    Left = 184
    Top = 52
    Width = 131
    Height = 25
    Caption = #1055#1077#1088#1077#1081#1090#1080' '#1082' '#1079#1072#1103#1074#1082#1077' ->'
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 8
    Top = 52
    Width = 163
    Height = 25
    Caption = #1054#1090#1083#1086#1078#1080#1090#1100' (5 '#1084#1080#1085')'
    TabOrder = 1
    OnClick = BitBtn2Click
  end
end
