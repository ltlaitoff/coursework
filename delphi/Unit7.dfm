object Teachers: TTeachers
  Left = 0
  Top = 0
  Caption = 'Teachers'
  ClientHeight = 601
  ClientWidth = 556
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
  object DBGrid1: TDBGrid
    Left = 23
    Top = 8
    Width = 506
    Height = 225
    DataSource = DataModule1.DataSourceTeachersShow
    TabOrder = 0
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -11
    TitleFont.Name = 'Tahoma'
    TitleFont.Style = []
    OnCellClick = DBGrid1CellClick
  end
  object openPanel: TButton
    Left = 396
    Top = 243
    Width = 75
    Height = 25
    Caption = #1048#1079#1084#1077#1085#1080#1090#1100
    TabOrder = 1
    OnClick = openPanelClick
  end
  object CheckBox1: TCheckBox
    Left = 169
    Top = 251
    Width = 97
    Height = 17
    Caption = 'CheckBox1'
    TabOrder = 2
    Visible = False
    OnClick = CheckBox1Click
  end
  object Panel1: TPanel
    Left = 22
    Top = 295
    Width = 490
    Height = 275
    TabOrder = 3
    Visible = False
    object Label4: TLabel
      Left = 73
      Top = 66
      Width = 51
      Height = 13
      Caption = #1060#1072#1084#1080#1083#1080#1103': '
    end
    object errorLabel: TLabel
      Left = 318
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
      Left = 101
      Top = 93
      Width = 23
      Height = 13
      Caption = #1048#1084#1103':'
    end
    object Label5: TLabel
      Left = 71
      Top = 120
      Width = 53
      Height = 13
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
    end
    object Label7: TLabel
      Left = 72
      Top = 174
      Width = 52
      Height = 13
      Caption = 'Username:'
    end
    object Label8: TLabel
      Left = 74
      Top = 201
      Width = 50
      Height = 13
      Caption = 'Password:'
    end
    object Label9: TLabel
      Left = 109
      Top = 28
      Width = 15
      Height = 13
      Caption = 'ID:'
    end
    object Label6: TLabel
      Left = 96
      Top = 147
      Width = 28
      Height = 13
      Caption = 'Email:'
      Visible = False
    end
    object buttonAdd: TButton
      Left = 318
      Top = 50
      Width = 159
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1086#1075#1086' '#1091#1095#1080#1090#1077#1083#1103
      TabOrder = 0
      OnClick = buttonAddClick
    end
    object buttonChange: TButton
      Left = 318
      Top = 81
      Width = 159
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1091#1095#1080#1090#1077#1083#1103
      TabOrder = 1
      OnClick = buttonChangeClick
    end
    object buttonDelete: TButton
      Left = 318
      Top = 112
      Width = 159
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1091#1095#1080#1090#1077#1083#1103
      TabOrder = 2
      OnClick = buttonDeleteClick
    end
    object surnameEdit: TEdit
      Left = 130
      Top = 66
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object nameEdit: TEdit
      Left = 130
      Top = 93
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object patronymicEdit: TEdit
      Left = 130
      Top = 120
      Width = 121
      Height = 21
      TabOrder = 5
    end
    object usernameEdit: TEdit
      Left = 130
      Top = 174
      Width = 121
      Height = 21
      TabOrder = 6
    end
    object passwordEdit: TEdit
      Left = 130
      Top = 201
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object selectId: TDBLookupComboBox
      Left = 130
      Top = 28
      Width = 145
      Height = 21
      Enabled = False
      KeyField = 'id'
      ListField = 'id'
      ListFieldIndex = 2
      ListSource = DataModule1.DataSourceUsersShow
      TabOrder = 8
    end
    object Button1: TButton
      Left = 318
      Top = 216
      Width = 159
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1103
      TabOrder = 9
      OnClick = Button1Click
    end
    object emailEdit: TEdit
      Left = 130
      Top = 145
      Width = 121
      Height = 21
      TabOrder = 10
      Visible = False
    end
  end
end
