object Teachers: TTeachers
  Left = 0
  Top = 0
  AutoSize = True
  Caption = 'Teachers'
  ClientHeight = 564
  ClientWidth = 944
  Color = clBtnFace
  Constraints.MinWidth = 960
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
    Width = 944
    Height = 285
    Align = alBottom
    DataSource = DataModule1.DataSourceTeachersShow
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
    Top = 335
    Width = 944
    Height = 229
    Align = alBottom
    TabOrder = 1
    Visible = False
    object Label4: TLabel
      Left = 249
      Top = 58
      Width = 51
      Height = 13
      Caption = #1060#1072#1084#1080#1083#1080#1103': '
    end
    object errorLabel: TLabel
      Left = 494
      Top = 135
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
      Left = 277
      Top = 85
      Width = 23
      Height = 13
      Caption = #1048#1084#1103':'
    end
    object Label5: TLabel
      Left = 247
      Top = 112
      Width = 53
      Height = 13
      Caption = #1054#1090#1095#1077#1089#1090#1074#1086':'
    end
    object Label7: TLabel
      Left = 248
      Top = 166
      Width = 52
      Height = 13
      Caption = 'Username:'
    end
    object Label8: TLabel
      Left = 250
      Top = 193
      Width = 50
      Height = 13
      Caption = 'Password:'
    end
    object Label9: TLabel
      Left = 285
      Top = 20
      Width = 15
      Height = 13
      Caption = 'ID:'
    end
    object Label6: TLabel
      Left = 272
      Top = 139
      Width = 28
      Height = 13
      Caption = 'Email:'
    end
    object buttonAdd: TButton
      Left = 494
      Top = 42
      Width = 159
      Height = 25
      Caption = #1044#1086#1073#1072#1074#1080#1090#1100' '#1085#1086#1074#1086#1075#1086' '#1091#1095#1080#1090#1077#1083#1103
      TabOrder = 0
      OnClick = buttonAddClick
    end
    object buttonChange: TButton
      Left = 494
      Top = 73
      Width = 159
      Height = 25
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1091#1095#1080#1090#1077#1083#1103
      TabOrder = 1
      OnClick = buttonChangeClick
    end
    object buttonDelete: TButton
      Left = 494
      Top = 104
      Width = 159
      Height = 25
      Caption = #1059#1076#1072#1083#1080#1090#1100' '#1076#1072#1085#1085#1099#1077' '#1091#1095#1080#1090#1077#1083#1103
      TabOrder = 2
      OnClick = buttonDeleteClick
    end
    object surnameEdit: TEdit
      Left = 306
      Top = 58
      Width = 121
      Height = 21
      TabOrder = 3
    end
    object nameEdit: TEdit
      Left = 306
      Top = 85
      Width = 121
      Height = 21
      TabOrder = 4
    end
    object patronymicEdit: TEdit
      Left = 306
      Top = 112
      Width = 121
      Height = 21
      TabOrder = 5
    end
    object usernameEdit: TEdit
      Left = 306
      Top = 166
      Width = 121
      Height = 21
      TabOrder = 6
    end
    object passwordEdit: TEdit
      Left = 306
      Top = 193
      Width = 121
      Height = 21
      TabOrder = 7
    end
    object selectId: TDBLookupComboBox
      Left = 306
      Top = 20
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
      Left = 494
      Top = 192
      Width = 159
      Height = 25
      Caption = #1054#1095#1080#1089#1090#1080#1090#1100' '#1087#1086#1083#1103
      TabOrder = 9
      OnClick = Button1Click
    end
    object emailEdit: TEdit
      Left = 306
      Top = 137
      Width = 121
      Height = 21
      TabOrder = 10
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 285
    Width = 944
    Height = 50
    Align = alBottom
    TabOrder = 2
    object CheckBox1: TCheckBox
      Left = 22
      Top = 16
      Width = 97
      Height = 17
      Caption = 'Password show'
      TabOrder = 0
      OnClick = CheckBox1Click
    end
    object openPanel: TButton
      Left = 698
      Top = 6
      Width = 197
      Height = 34
      Caption = #1048#1079#1084#1077#1085#1080#1090#1100
      TabOrder = 1
      OnClick = openPanelClick
    end
  end
end
