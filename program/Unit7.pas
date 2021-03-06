unit Unit7;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTeachers = class(TForm)
    DBGrid1: TDBGrid;
    openPanel: TButton;
    CheckBox1: TCheckBox;
    Panel1: TPanel;
    Label4: TLabel;
    errorLabel: TLabel;
    Label2: TLabel;
    Label5: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    buttonAdd: TButton;
    buttonChange: TButton;
    buttonDelete: TButton;
    surnameEdit: TEdit;
    nameEdit: TEdit;
    patronymicEdit: TEdit;
    usernameEdit: TEdit;
    passwordEdit: TEdit;
    selectId: TDBLookupComboBox;
    Button1: TButton;
    Label9: TLabel;
    Label6: TLabel;
    emailEdit: TEdit;
    Panel2: TPanel;
    procedure openPanelClick(Sender: TObject);
    procedure updatePanelFields();
    procedure resetPanelFields();
    procedure CheckBox1Click(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure addRecordInTeachers(surname, name, patronymic, email, username, password: String);
    procedure updateRecordInTeachers(id: Integer; surname, name, patronymic, email, username, password: String);
    procedure deleteRecordFromTeachers(id: Integer);
    function teachersActionControllerCheckOnError(action: String; id: Integer; surname, name, patronymic, email, username, password: String): Boolean;
    procedure teachersActionController(action: String; id: Integer; surname, name, patronymic, email, username, password: String);
    procedure buttonAddClick(Sender: TObject);
    procedure buttonChangeClick(Sender: TObject);
    procedure buttonDeleteClick(Sender: TObject);
    procedure showMainTable();
    procedure Button1Click(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    procedure selectGroupClick(Sender: TObject);
    procedure showErrorLabel(text: String);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Teachers: TTeachers;
  recordId: Integer;
  loginAndPassword: Boolean;

implementation

{$R *.dfm}

uses Unit2, StrUtils, Unit9;

procedure TTeachers.CheckBox1Click(Sender: TObject);
begin
  loginAndPassword := CheckBox1.Checked;
  DBGrid1.Columns[5].Visible := loginAndPassword;
  DBGrid1.Columns[6].Visible := loginAndPassword;
  usernameEdit.Visible := loginAndPassword;
  passwordEdit.Visible := loginAndPassword;
  Label7.Visible := loginAndPassword;
  Label8.Visible := loginAndPassword;
end;

procedure TTeachers.FormActivate(Sender: TObject);
begin
  CheckBox1.Visible := True;
  openPanel.Visible := True;
  Panel1.Visible := False;

  if (Authorization.userType = 'student') then begin
    CheckBox1.Visible := False;
    openPanel.Visible := False;
  end;

  if (Authorization.userType = 'teacher') then begin
    CheckBox1.Visible := False;
    openPanel.Visible := False;
  end;

  CheckBox1Click(CheckBox1);
end;

procedure TTeachers.FormMouseWheel(Sender: TObject; Shift: TShiftState;
  WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
begin
  If DBGrid1.Focused then begin
    If (WheelDelta < 0) then begin
      DBGrid1.Perform(WM_KEYDOWN, VK_DOWN, 0)
    end
    else begin
      DBGrid1.Perform(WM_KEYDOWN, VK_UP, 0);
    end;
  end;
end;

procedure TTeachers.openPanelClick(Sender: TObject);
begin
  Panel1.Visible := NOT Panel1.Visible;
  updatePanelFields();
  CheckBox1Click(CheckBox1);
end;

procedure TTeachers.updatePanelFields();
begin
  selectId.KeyValue := DBGrid1.Fields[0].AsString;
  recordId := selectId.KeyValue;

  surnameEdit.Text := DBGrid1.Fields[1].AsString;
  nameEdit.Text := DBGrid1.Fields[2].AsString;
  patronymicEdit.Text := DBGrid1.Fields[3].AsString;
  emailEdit.Text := DBGrid1.Fields[4].AsString;
  usernameEdit.Text := DBGrid1.Fields[5].AsString;
  passwordEdit.Text := DBGrid1.Fields[6].AsString;
end;

procedure TTeachers.resetPanelFields();
begin
  selectId.KeyValue := '';
  recordId := 0;

  surnameEdit.Text := '';
  nameEdit.Text := '';
  patronymicEdit.Text := '';
  emailEdit.Text := '';
  usernameEdit.Text := '';
  passwordEdit.Text := '';
end;

procedure TTeachers.showMainTable();
begin
  DataModule1.ADOQueryTeachersShow.Close;
  DataModule1.ADOQueryTeachersShow.SQL.Text :=
  'SELECT * ' +
  'FROM Teachers ' +
  'ORDER BY ID';
  DataModule1.ADOQueryTeachersShow.Open;
end;

procedure TTeachers.Button1Click(Sender: TObject);
begin
  resetPanelFields();
end;

procedure TTeachers.DBGrid1CellClick(Column: TColumn);
begin
  updatePanelFields();
end;

procedure TTeachers.selectGroupClick(Sender: TObject);
begin
  resetPanelFields();
end;

procedure TTeachers.showErrorLabel(text: String);
begin
  errorLabel.Visible := True;
  errorLabel.Caption := text;
end;

function TTeachers.teachersActionControllerCheckOnError(action: String; id: Integer; surname, name, patronymic, email, username, password: String): Boolean;
begin
  if ((String(id) = '') AND (action <> 'add')) then begin
    showErrorLabel('Ошибка ИД');
    teachersActionControllerCheckOnError := True;
    Exit;
  end;

  if action = 'delete' then begin
    teachersActionControllerCheckOnError := False;
    Exit;
  end;

  if surname = '' then begin
    showErrorLabel('Ошибка фамилии');
    teachersActionControllerCheckOnError := True;
    Exit;
  end;

  if name = '' then begin
    showErrorLabel('Ошибка имени');
    teachersActionControllerCheckOnError := True;
    Exit;
  end;

  if patronymic = '' then begin
    showErrorLabel('Ошибка отчества');
    teachersActionControllerCheckOnError := True;
    Exit;
  end;

  if email = '' then begin
    showErrorLabel('Ошибка email');
    teachersActionControllerCheckOnError := True;
    Exit;
  end;

  if (username = '') AND (loginAndPassword = true)  then begin
    showErrorLabel('Ошибка username');
    teachersActionControllerCheckOnError := True;
    Exit;
  end;

  if (password = '') AND (loginAndPassword = true) then begin
    showErrorLabel('Ошибка password');
    teachersActionControllerCheckOnError := True;
    Exit;
  end;

  teachersActionControllerCheckOnError := False;
end;

procedure TTeachers.addRecordInTeachers(surname, name, patronymic, email, username, password: String);
begin
  DataModule1.ADOQueryTeachers.Close;
  DataModule1.ADOQueryTeachers.SQL.Text :=
  'INSERT INTO Teachers (surname, name, patronymic, email, username, [password]) ' +
  'VALUES (' +
    '"' + surname + '", ' +
    '"' + name + '", ' +
    '"' + patronymic + '", ' +
    '"' + email + '", ' +
    '"' + username + '", ' +
    '"' + password + '" ' +
  ');';
  DataModule1.ADOQueryTeachers.ExecSQL;
end;

procedure TTeachers.updateRecordInTeachers(id: Integer; surname, name, patronymic, email, username, password: String);
begin
  DataModule1.ADOQueryTeachers.Close;
  DataModule1.ADOQueryTeachers.SQL.Text :=
  'UPDATE Teachers ' +
  'SET ' +
    'surname = "' + surname + '", ' +
    'name = "' + name + '", ' +
    'patronymic = "' + patronymic + '", ' +
    'email = "' + email + '", ' +
    'username = "' + username + '", ' +
    '[password] = "' + password + '" ' +
  'WHERE ' +
    'id = ' + IntToStr(id) + ';';
  DataModule1.ADOQueryTeachers.ExecSQL;
end;

procedure TTeachers.deleteRecordFromTeachers(id: Integer);
begin
  DataModule1.ADOQueryTeachers.Close;
  DataModule1.ADOQueryTeachers.SQL.Text :=
  'DELETE ' +
  'FROM Teachers ' +
  'WHERE id = ' + IntToStr(id) + ';';
  DataModule1.ADOQueryTeachers.ExecSQL;
end;

procedure TTeachers.teachersActionController(action: String; id: Integer; surname, name, patronymic, email, username, password: String);
begin

  if (teachersActionControllerCheckOnError(action, id, surname, name, patronymic, email, username, password) = true) then begin
    Exit;
  end;

  case StrUtils.IndexStr(action, ['add', 'update', 'delete']) of
    0: addRecordInTeachers(surname, name, patronymic, email, username, password);
    1: updateRecordInTeachers(id, surname, name, patronymic, email, username, password);
    2: deleteRecordFromTeachers(id);
  end;

  showMainTable();
  Button1Click(Button1);
end;

procedure TTeachers.buttonAddClick(Sender: TObject);
begin
  teachersActionController('add', recordId,
  surnameEdit.Text, nameEdit.Text, patronymicEdit.Text,
  emailEdit.Text, usernameEdit.Text, passwordEdit.Text);
end;

procedure TTeachers.buttonChangeClick(Sender: TObject);
begin
  teachersActionController('update', recordId,
  surnameEdit.Text, nameEdit.Text, patronymicEdit.Text,
  emailEdit.Text, usernameEdit.Text, passwordEdit.Text);
end;

procedure TTeachers.buttonDeleteClick(Sender: TObject);
begin
  teachersActionController('delete', recordId,
  surnameEdit.Text, nameEdit.Text, patronymicEdit.Text,
  emailEdit.Text, usernameEdit.Text, passwordEdit.Text);
end;

end.
