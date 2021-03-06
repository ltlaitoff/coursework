object Users: TUsers
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Users'
  ClientHeight = 707
  ClientWidth = 847
  Color = clBtnFace
  Constraints.MaxWidth = 863
  Constraints.MinWidth = 863
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnActivate = FormActivate
  OnMouseWheel = FormMouseWheel
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 0
    Width = 847
    Height = 385
    Align = alBottom
    DataSource = DataModule1.DataSourceUsersShow
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
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'GN'
        Width = 30
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'surname'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'name'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'patronymic'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'email'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'username'
        Visible = True
      end
      item
        Expanded = False
        FieldName = 'password'
        Visible = True
      end>
  end
  object Panel1: TPanel
    Left = 0
    Top = 432
    Width = 847
    Height = 275
    Align = alBottom
    TabOrder = 1
    Visible = False
    object Label3: TLabel
      Left = 156
      Top = 55
      Width = 40
      Height = 13
      Caption = #1043#1088#1091#1087#1087#1072':'
    end
    object Label4: TLabel
      Left = 145
      Top = 82
      Width = 51
      Height = 13
      Caption = #1060#1072#1084#1080#1083#1080#1103': '
    end
    object errorLabel: TLabel
      Left = 390
      Top = 143
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
    object Label2: TLabel
      Left = 173
      Top = 109
      Width = 23
      Height = 13
      Caption = #1048#1084#1103':'
    end
    object Label5: TLabel
      Left = 143
      Top = 136
      Width = 53
      Height = 13
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
    end
    object Label6: TLabel
      Left = 168
      Top = 163
      Width = 28
      Height = 13
      Caption = 'Email:'
    end
    object Label7: TLabel
      Left = 144
      Top = 190
      Width = 52
      Height = 13
      Caption = 'Username:'
    end
    object Label8: TLabel
      Left = 146
      Top = 217
      Width = 50
      Height = 13
      Caption = 'Password:'
    end
    object Label9: TLabel
      Left = 181
      Top = 28
      Width = 15
      Height = 13
      Caption = 'ID:'
    end
    object buttonAdd: TButton
      Left = 390
      Top = 50
      Width = 159
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1086#1075#1086' '#1091#1095#1077#1085#1080#1082#1072
      TabOrder = 0
      OnClick = buttonAddClick
    end
    object buttonChange: TButton
      Left = 390
      Top = 81
      Width = 159
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1091#1095#1077#1085#1080#1082#1072
      TabOrder = 1
      OnClick = buttonChangeClick
    end
    object buttonDelete: TButton
      Left = 390
      Top = 112
      Width = 159
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1091#1095#1077#1085#1080#1082#1072
      TabOrder = 2
      OnClick = buttonDeleteClick
    end
    object surnameEdit: TEdit
      Left = 202
      Top = 82
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object nameEdit: TEdit
      Left = 202
      Top = 109
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object patronymicEdit: TEdit
      Left = 202
      Top = 136
      Width = 121
      Height = 21
      TabOrder = 5
    end
    object emailEdit: TEdit
      Left = 202
      Top = 163
      Width = 121
      Height = 21
      TabOrder = 6
    end
    object usernameEdit: TEdit
      Left = 202
      Top = 190
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object passwordEdit: TEdit
      Left = 202
      Top = 217
      Width = 121
      Height = 21
      TabOrder = 8
    end
    object selectId: TDBLookupComboBox
      Left = 202
      Top = 28
      Width = 145
      Height = 21
      Enabled = False
      KeyField = 'id'
      ListField = 'id'
      ListFieldIndex = 2
      ListSource = DataModule1.DataSourceUsersShow
      TabOrder = 9
    end
    object Button1: TButton
      Left = 390
      Top = 216
      Width = 159
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1103
      TabOrder = 10
      OnClick = Button1Click
    end
    object selectGroupPanel: TDBLookupComboBox
      Left = 202
      Top = 55
      Width = 145
      Height = 21
      KeyField = 'name'
      ListField = 'name'
      ListFieldIndex = 2
      ListSource = DataModule1.DataSourceTableGroups
      TabOrder = 11
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 385
    Width = 847
    Height = 47
    Align = alBottom
    TabOrder = 2
    object Label1: TLabel
      Left = 16
      Top = 20
      Width = 36
      Height = 13
      Caption = #1043#1088#1091#1087#1087#1072
    end
    object CheckBox1: TCheckBox
      Left = 312
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Password show'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object openPanel: TButton
      Left = 670
      Top = 11
      Width = 75
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = openPanelClick
    end
    object selectGroup: TDBLookupComboBox
      Left = 58
      Top = 12
      Width = 145
      Height = 21
      KeyField = 'name'
      ListField = 'name'
      ListFieldIndex = 2
      ListSource = DataModule1.DataSourceGroupsShow
      TabOrder = 2
      OnClick = selectGroupClick
    end
  end
end
