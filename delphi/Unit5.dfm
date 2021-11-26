object Groups: TGroups
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Groups'
  ClientHeight = 542
  ClientWidth = 633
  Color = clBtnFace
  Constraints.MaxWidth = 649
  Constraints.MinWidth = 649
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnCreate = FormCreate
  OnMouseWheel = FormMouseWheel
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 633
    Height = 369
    Align = alBottom
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
    Left = 0
    Top = 410
    Width = 633
    Height = 132
    Align = alBottom
    TabOrder = 1
    Visible = False
    object Label3: TLabel
      Left = 86
      Top = 27
      Width = 52
      Height = 13
      Caption = #1053#1072#1079#1074#1072#1085#1080#1077':'
    end
    object errorLabel: TLabel
      Left = 144
      Top = 52
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
      Top = 26
      Width = 108
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      TabOrder = 0
      OnClick = buttonAddClick
    end
    object buttonChange: TButton
      Left = 327
      Top = 57
      Width = 108
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      TabOrder = 1
      OnClick = buttonChangeClick
    end
    object buttonDelete: TButton
      Left = 327
      Top = 88
      Width = 108
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1075#1088#1091#1087#1087#1091
      TabOrder = 2
      OnClick = buttonDeleteClick
    end
    object nameEdit: TEdit
      Left = 144
      Top = 25
      Width = 145
      Height = 21
      TabOrder = 3
      Text = 'nameEdit'
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 369
    Width = 633
    Height = 41
    Align = alBottom
    TabOrder = 2
    object openPanel: TButton
      Left = 478
      Top = 6
      Width = 75
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 0
      OnClick = openPanelClick
    end
  end
end
