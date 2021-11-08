object Main: TMain
  Left = 0
  Top = 0
  Caption = 'ltlaitoff coursework'
  ClientHeight = 633
  ClientWidth = 629
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
  object Label1: TLabel
    Left = 27
    Top = 399
    Width = 36
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1072
  end
  object Label2: TLabel
    Left = 27
    Top = 426
    Width = 44
    Height = 13
    Caption = #1055#1088#1077#1076#1084#1077#1090
  end
  object DBGrid1: TDBGrid
    Left = 27
    Top = 8
    Width = 574
    Height = 369
    DataSource = DataModule1.DataSourceMain
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = journalOnCellClick
  end
  object selectGroup: TDBLookupComboBox
    Left = 77
    Top = 399
    Width = 145
    Height = 21
    KeyField = 'name'
    ListField = 'name'
    ListFieldIndex = 2
    ListSource = DataModule1.DataSourceGroups
    TabOrder = 1
    OnClick = selectGroupClick
  end
  object selectSubject: TDBLookupComboBox
    Left = 77
    Top = 426
    Width = 145
    Height = 21
    KeyField = 'name'
    ListField = 'name'
    ListFieldIndex = 2
    ListSource = DataModule1.DataSourceSubjectsShow
    TabOrder = 2
    OnClick = selectSubjectClick
  end
  object Panel1: TPanel
    Left = 27
    Top = 453
    Width = 574
    Height = 148
    TabOrder = 3
    Visible = False
    object Label3: TLabel
      Left = 85
      Top = 30
      Width = 48
      Height = 13
      Caption = #1057#1090#1091#1076#1077#1085#1090':'
    end
    object Label4: TLabel
      Left = 91
      Top = 57
      Width = 42
      Height = 13
      Caption = #1054#1094#1077#1085#1082#1072':'
    end
    object errorLabel: TLabel
      Left = 327
      Top = 57
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
    object daysOfWeekLabel: TLabel
      Left = 165
      Top = 108
      Width = 3
      Height = 13
    end
    object buttonAdd: TButton
      Left = 327
      Top = 26
      Width = 108
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1094#1077#1085#1082#1091
      TabOrder = 0
      OnClick = buttonAddClick
    end
    object selectDate: TDateTimePicker
      Left = 109
      Top = 81
      Width = 186
      Height = 21
      CalColors.BackColor = clCream
      CalColors.TextColor = clCream
      CalColors.TitleBackColor = clCream
      CalColors.TitleTextColor = clCream
      CalColors.MonthBackColor = clCream
      CalColors.TrailingTextColor = clCream
      Date = 44501.000000000000000000
      Time = 0.906503252313996200
      Color = clCream
      TabOrder = 1
      OnChange = DateTimePicker1OnChange
    end
    object selectStudent: TDBLookupComboBox
      Left = 150
      Top = 27
      Width = 145
      Height = 21
      KeyField = 'surname'
      ListFieldIndex = 5
      ListSource = DataModule1.DataSourceStudentFromGroup
      TabOrder = 2
    end
    object selectMark: TDBLookupComboBox
      Left = 150
      Top = 54
      Width = 145
      Height = 21
      KeyField = 'mark'
      ListSource = DataModule1.DataSourceTableMarks
      TabOrder = 3
    end
    object buttonChange: TButton
      Left = 327
      Top = 76
      Width = 108
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1086#1094#1077#1085#1082#1091
      TabOrder = 4
      OnClick = buttonChangeClick
    end
    object buttonDelete: TButton
      Left = 327
      Top = 107
      Width = 108
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1086#1094#1077#1085#1082#1091
      TabOrder = 5
      OnClick = buttonDeleteClick
    end
  end
  object openPanel: TButton
    Left = 526
    Top = 414
    Width = 75
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 4
    OnClick = openPanelClick
  end
  object MainMenu1: TMainMenu
    Left = 392
    Top = 392
    object Main2: TMenuItem
      Caption = 'Subjects'
      OnClick = Main2Click
    end
    object timetable1: TMenuItem
      Caption = 'Timetable'
      OnClick = timetable1Click
    end
  end
end
