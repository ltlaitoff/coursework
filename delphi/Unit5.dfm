object Groups: TGroups
  Left = 0
  Top = 0
  Caption = 'Groups'
  ClientHeight = 577
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 27
    Top = 8
    Width = 574
    Height = 369
    DataSource = DataModule1.DataSourceGroupsShow
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object Panel1: TPanel
    Left = 27
    Top = 429
    Width = 558
    Height = 132
    TabOrder = 1
    Visible = False
    object Label3: TLabel
      Left = 69
      Top = 22
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    end
    object errorLabel: TLabel
      Left = 141
      Top = 43
      Width = 3
      Height = 13
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clRed
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentColor = False
      ParentFont = False
      Transparent = True
    end
    object buttonAdd: TButton
      Left = 327
      Top = 18
      Width = 108
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      TabOrder = 0
      OnClick = buttonAddClick
    end
    object buttonChange: TButton
      Left = 327
      Top = 49
      Width = 108
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      TabOrder = 1
      OnClick = buttonChangeClick
    end
    object buttonDelete: TButton
      Left = 327
      Top = 80
      Width = 108
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      TabOrder = 2
      OnClick = buttonDeleteClick
    end
    object nameEdit: TEdit
      Left = 141
      Top = 16
      Width = 145
      Height = 21
      TabOrder = 3
      Text = 'nameEdit'
    end
  end
  object openPanel: TButton
    Left = 526
    Top = 390
    Width = 75
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 2
    OnClick = openPanelClick
  end
end
