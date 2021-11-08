object Subjects: TSubjects
  Left = 0
  Top = 0
  Caption = 'Subjects'
  ClientHeight = 587
  ClientWidth = 644
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
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
    DataSource = DataModule1.DataSourceSubjectsShow
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
    Columns = <
      item
        Expanded = False
        FieldName = 'id'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Width = 150
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'audience'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'teacher'
        Visible = True
      end>
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
    object Label4: TLabel
      Left = 64
      Top = 41
      Width = 63
      Height = 13
      Caption = #1040#1091#1076#1080#1090#1086#1088#1080#1103': '
    end
    object errorLabel: TLabel
      Left = 141
      Top = 97
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
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1087#1088#1077#1076#1084#1077#1090
      TabOrder = 0
      OnClick = buttonAddClick
    end
    object teacherComboBox: TDBLookupComboBox
      Left = 141
      Top = 70
      Width = 145
      Height = 21
      KeyField = 'surname'
      ListFieldIndex = 5
      ListSource = DataModule1.DataSourceTableTeachers
      TabOrder = 1
    end
    object buttonChange: TButton
      Left = 327
      Top = 57
      Width = 108
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1087#1088#1077#1076#1084#1077#1090
      TabOrder = 2
      OnClick = buttonChangeClick
    end
    object buttonDelete: TButton
      Left = 327
      Top = 88
      Width = 108
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1087#1088#1077#1076#1084#1077#1090
      TabOrder = 3
      OnClick = buttonDeleteClick
    end
    object nameEdit: TEdit
      Left = 141
      Top = 16
      Width = 145
      Height = 21
      TabOrder = 4
      Text = 'nameEdit'
    end
    object audienceEdit: TEdit
      Left = 141
      Top = 43
      Width = 145
      Height = 21
      TabOrder = 5
      Text = 'audienceEdit'
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
  object MainMenu1: TMainMenu
    Left = 56
    Top = 384
    object Main2: TMenuItem
    end
  end
end
