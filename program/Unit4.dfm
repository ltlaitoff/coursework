object Timetable: TTimetable
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Timetable'
  ClientHeight = 617
  ClientWidth = 620
  Color = clBtnFace
  Constraints.MaxWidth = 636
  Constraints.MinWidth = 636
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Scaled = False
  OnActivate = FormActivate
  OnMouseWheel = FormMouseWheel
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 620
    Height = 481
    Align = alBottom
    BiDiMode = bdLeftToRight
    DataSource = DataModule1.DataSourceTimetableShow
    ParentBiDiMode = False
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    Columns = <
      item
        Expanded = False
        FieldName = 'day of week'
        Width = 75
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pair'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'group'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'audience'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'subject'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 481
    Width = 620
    Height = 136
    Align = alBottom
    TabOrder = 1
    object Group: TLabel
      Left = 36
      Top = 28
      Width = 29
      Height = 13
      Caption = 'Group'
    end
    object Subject: TLabel
      Left = 21
      Top = 55
      Width = 44
      Height = 13
      Caption = #1055#1088#1077#1076#1084#1077#1090
    end
    object Button1: TButton
      Left = 504
      Top = 24
      Width = 89
      Height = 25
      Caption = #1042#1089#1077
      TabOrder = 0
      OnClick = Button1Click
    end
    object Button2: TButton
      Left = 504
      Top = 55
      Width = 89
      Height = 25
      Caption = #1058#1086#1083#1100#1082#1086' '#1075#1088#1091#1087#1087#1091
      TabOrder = 1
      OnClick = Button2Click
    end
    object Button3: TButton
      Left = 504
      Top = 86
      Width = 89
      Height = 25
      Caption = #1055#1086' '#1087#1088#1077#1076#1084#1077#1090#1091
      TabOrder = 2
      OnClick = Button3Click
    end
    object Button4: TButton
      Left = 304
      Top = 32
      Width = 89
      Height = 25
      Caption = #1054#1090#1095#1105#1090
      TabOrder = 3
      OnClick = Button4Click
    end
    object selectGroup: TDBLookupComboBox
      Left = 85
      Top = 28
      Width = 145
      Height = 21
      KeyField = 'name'
      ListField = 'name'
      ListFieldIndex = 2
      ListSource = DataModule1.DataSourceTableGroups
      TabOrder = 4
      OnClick = selectGroupClick
    end
    object selectSubject: TDBLookupComboBox
      Left = 85
      Top = 55
      Width = 145
      Height = 21
      KeyField = 'name'
      ListField = 'name'
      ListFieldIndex = 2
      ListSource = DataModule1.DataSourceTableSubjects
      TabOrder = 5
      OnClick = selectSubjectClick
    end
  end
end
