﻿object Timetable: TTimetable
  Left = 0
  Top = 0
  Caption = 'Timetable'
  ClientHeight = 768
  ClientWidth = 870
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  PixelsPerInch = 96
  TextHeight = 13
  object Группа: TLabel
    Left = 29
    Top = 522
    Width = 36
    Height = 13
    Caption = #1043#1088#1091#1087#1087#1072
  end
  object Label2: TLabel
    Left = 29
    Top = 549
    Width = 44
    Height = 13
    Caption = #1055#1088#1077#1076#1084#1077#1090
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 8
    Width = 862
    Height = 481
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
        Width = 100
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'pair'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'g.name'
        Width = 50
        Visible = True
      end
      item
        Expanded = False
        FieldName = 's.name'
        Width = 200
        Visible = True
      end>
  end
  object selectGroup: TDBLookupComboBox
    Left = 101
    Top = 522
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
    Left = 101
    Top = 549
    Width = 145
    Height = 21
    KeyField = 'name'
    ListField = 'name'
    ListFieldIndex = 2
    ListSource = DataModule1.DataSourceSubjectsShow
    TabOrder = 2
    OnClick = selectSubjectClick
  end
  object Button1: TButton
    Left = 512
    Top = 517
    Width = 89
    Height = 25
    Caption = #1042#1089#1077
    TabOrder = 3
    OnClick = Button1Click
  end
  object Button2: TButton
    Left = 512
    Top = 548
    Width = 89
    Height = 25
    Caption = #1058#1086#1083#1100#1082#1086' '#1075#1088#1091#1087#1087#1091
    TabOrder = 4
    OnClick = Button2Click
  end
  object Button3: TButton
    Left = 512
    Top = 579
    Width = 89
    Height = 25
    Caption = #1055#1086' '#1087#1088#1077#1076#1084#1077#1090#1091
    TabOrder = 5
    OnClick = Button3Click
  end
end
