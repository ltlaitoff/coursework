object Main: TMain
  Left = 0
  Top = 0
  Width = 626
  Height = 700
  Anchors = [akTop]
  AutoScroll = True
  AutoSize = True
  Caption = 'ltlaitoff coursework'
  Color = clBtnFace
  Constraints.MaxWidth = 626
  Constraints.MinWidth = 626
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  Menu = MainMenu1
  OldCreateOrder = False
  OnActivate = FormActivate
  OnClose = FormClose
  OnCreate = FormCreate
  OnMouseWheel = FormMouseWheel
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 610
    Height = 401
    Align = alBottom
    DataSource = DataModule1.DataSourceMain
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = journalOnCellClick
  end
  object Panel1: TPanel
    Left = 0
    Top = 493
    Width = 610
    Height = 148
    Align = alBottom
    TabOrder = 1
    Visible = False
    object Label3: TLabel
      Left = 109
      Top = 30
      Width = 48
      Height = 13
      Caption = #1057#1090#1091#1076#1077#1085#1090':'
    end
    object Label4: TLabel
      Left = 115
      Top = 57
      Width = 42
      Height = 13
      Caption = #1054#1094#1077#1085#1082#1072':'
    end
    object errorLabel: TLabel
      Left = 485
      Top = 49
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
      Left = 189
      Top = 108
      Width = 3
      Height = 13
    end
    object buttonAdd: TButton
      Left = 485
      Top = 18
      Width = 108
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1094#1077#1085#1082#1091
      TabOrder = 0
      OnClick = buttonAddClick
    end
    object selectDate: TDateTimePicker
      Left = 133
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
      Left = 174
      Top = 27
      Width = 145
      Height = 21
      KeyField = 'surname'
      ListFieldIndex = 5
      ListSource = DataModule1.DataSourceStudentFromGroup
      TabOrder = 2
    end
    object selectMark: TDBLookupComboBox
      Left = 174
      Top = 54
      Width = 145
      Height = 21
      KeyField = 'mark'
      ListSource = DataModule1.DataSourceTableMarks
      TabOrder = 3
    end
    object buttonChange: TButton
      Left = 485
      Top = 68
      Width = 108
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1086#1094#1077#1085#1082#1091
      TabOrder = 4
      OnClick = buttonChangeClick
    end
    object buttonDelete: TButton
      Left = 485
      Top = 99
      Width = 108
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1086#1094#1077#1085#1082#1091
      TabOrder = 5
      OnClick = buttonDeleteClick
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 401
    Width = 610
    Height = 92
    Align = alBottom
    TabOrder = 2
    object Label1: TLabel
      Left = 11
      Top = 16
      Width = 36
      Height = 13
      Caption = #1043#1088#1091#1087#1087#1072
    end
    object Label2: TLabel
      Left = 11
      Top = 48
      Width = 44
      Height = 13
      Caption = #1055#1088#1077#1076#1084#1077#1090
    end
    object ComboBox1: TComboBox
      Left = 248
      Top = 19
      Width = 145
      Height = 21
      TabOrder = 0
      Text = 'ComboBox1'
      OnClick = ComboBox1Click
    end
    object openPanel: TButton
      Left = 502
      Top = 15
      Width = 75
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = openPanelClick
    end
    object selectGroup: TDBLookupComboBox
      Left = 61
      Top = 13
      Width = 145
      Height = 21
      KeyField = 'name'
      ListField = 'name'
      ListFieldIndex = 2
      ListSource = DataModule1.DataSourceGroupsShow
      TabOrder = 2
      OnClick = selectGroupClick
    end
    object selectSubject: TDBLookupComboBox
      Left = 61
      Top = 48
      Width = 145
      Height = 21
      KeyField = 'name'
      ListField = 'name'
      ListFieldIndex = 2
      ListSource = DataModule1.DataSourceSubjectsShow
      TabOrder = 3
      OnClick = selectSubjectClick
    end
  end
  object MainMenu1: TMainMenu
    Left = 536
    Top = 616
    object Main2: TMenuItem
      Caption = 'Subjects'
      OnClick = Main2Click
    end
    object timetable1: TMenuItem
      Caption = 'Timetable'
      OnClick = timetable1Click
    end
    object Groups1: TMenuItem
      Caption = 'Groups'
      OnClick = Groups1Click
    end
    object Users1: TMenuItem
      Caption = 'Users'
      OnClick = Users1Click
    end
    object TeachersTab: TMenuItem
      Caption = 'Teachers'
      OnClick = TeachersTabClick
    end
    object ExitTab: TMenuItem
      Caption = 'Exit'
      OnClick = ExitTabClick
    end
  end
end
