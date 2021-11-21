object Authorization: TAuthorization
  Left = 0
  Top = 0
  Caption = 'Authorization'
  ClientHeight = 115
  ClientWidth = 396
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object errorLabel: TLabel
    Left = 168
    Top = 91
    Width = 3
    Height = 13
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clRed
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object admin: TButton
    Left = 255
    Top = 31
    Width = 105
    Height = 41
    Caption = #1040#1076#1084#1080#1085#1080#1089#1090#1088#1072#1090#1086#1088
    TabOrder = 0
    OnClick = adminClick
  end
  object student: TButton
    Left = 33
    Top = 31
    Width = 105
    Height = 41
    Caption = #1059#1095#1077#1085#1080#1082
    TabOrder = 1
    OnClick = studentClick
  end
  object teacher: TButton
    Left = 144
    Top = 31
    Width = 105
    Height = 41
    Caption = #1059#1095#1080#1090#1077#1083#1100
    TabOrder = 2
    OnClick = teacherClick
  end
end
