object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'ltlaitoff coursework'
  ClientHeight = 624
  ClientWidth = 598
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  PixelsPerInch = 96
  TextHeight = 13
  object PageControl1: TPageControl
    Left = 0
    Top = 0
    Width = 991
    Height = 625
    ActivePage = TabSheet1
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = 'TabSheet1'
      object Label1: TLabel
        Left = 3
        Top = 375
        Width = 36
        Height = 13
        Caption = #1043#1088#1091#1087#1087#1072
      end
      object Label2: TLabel
        Left = 3
        Top = 402
        Width = 44
        Height = 13
        Caption = #1055#1088#1077#1076#1084#1077#1090
      end
      object Label3: TLabel
        Left = 205
        Top = 452
        Width = 48
        Height = 13
        Caption = #1057#1090#1091#1076#1077#1085#1090':'
      end
      object Label4: TLabel
        Left = 205
        Top = 480
        Width = 42
        Height = 13
        Caption = #1054#1094#1077#1085#1082#1072':'
      end
      object Label5: TLabel
        Left = 412
        Top = 510
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
      object Label6: TLabel
        Left = 261
        Top = 537
        Width = 3
        Height = 13
      end
      object DBGrid1: TDBGrid
        Left = 3
        Top = 0
        Width = 574
        Height = 369
        DataSource = DataModule1.DataSourceMain
        TabOrder = 0
        TitleFont.Charset = DEFAULT_CHARSET
        TitleFont.Color = clWindowText
        TitleFont.Height = -11
        TitleFont.Name = 'Tahoma'
        TitleFont.Style = []
      end
      object Button1: TButton
        Left = 462
        Top = 397
        Width = 75
        Height = 25
        Caption = #1054#1090#1086#1073#1088#1072#1079#1080#1090#1100
        TabOrder = 1
        OnClick = Button1Click
      end
      object DBLookupComboBox1: TDBLookupComboBox
        Left = 53
        Top = 375
        Width = 145
        Height = 21
        KeyField = 'name'
        ListField = 'name'
        ListFieldIndex = 2
        ListSource = DataModule1.DataSourceGroups
        TabOrder = 2
      end
      object DBLookupComboBox2: TDBLookupComboBox
        Left = 53
        Top = 402
        Width = 145
        Height = 21
        KeyField = 'name'
        ListField = 'name'
        ListFieldIndex = 2
        ListSource = DataModule1.DataSourceSubjects
        TabOrder = 3
      end
      object DBLookupComboBox3: TDBLookupComboBox
        Left = 261
        Top = 452
        Width = 145
        Height = 21
        KeyField = 'surname'
        ListFieldIndex = 5
        ListSource = DataModule1.DataSourceStudentFromGroup
        TabOrder = 4
      end
      object Button2: TButton
        Left = 412
        Top = 479
        Width = 108
        Height = 25
        Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1086#1094#1077#1085#1082#1091
        TabOrder = 5
        OnClick = Button2Click
      end
      object DBLookupComboBox4: TDBLookupComboBox
        Left = 261
        Top = 479
        Width = 145
        Height = 21
        KeyField = 'mark'
        ListSource = DataModule1.DataSourceTableMarks
        TabOrder = 6
      end
      object DateTimePicker1: TDateTimePicker
        Left = 220
        Top = 510
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
        TabOrder = 7
        OnChange = DateTimePicker1OnChange
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'TabSheet2'
      ImageIndex = 1
    end
    object TabSheet3: TTabSheet
      Caption = 'TabSheet3'
      ImageIndex = 2
    end
  end
end