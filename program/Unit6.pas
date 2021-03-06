unit Unit6;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.ComCtrls, Vcl.StdCtrls,
  Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TUsers = class(TForm)
    Label1: TLabel;
    DBGrid1: TDBGrid;
    selectGroup: TDBLookupComboBox;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    errorLabel: TLabel;
    buttonAdd: TButton;
    buttonChange: TButton;
    buttonDelete: TButton;
    openPanel: TButton;
    CheckBox1: TCheckBox;
    Label2: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    surnameEdit: TEdit;
    nameEdit: TEdit;
    patronymicEdit: TEdit;
    emailEdit: TEdit;
    usernameEdit: TEdit;
    passwordEdit: TEdit;
    Label9: TLabel;
    selectId: TDBLookupComboBox;
    Button1: TButton;
    selectGroupPanel: TDBLookupComboBox;
    Panel2: TPanel;
    procedure selectGroupClick(Sender: TObject);
    function getGroupId(groupName: String): Integer;
    procedure showMainTable(groupId: Integer);
    procedure updateGrid();
    procedure FormActivate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure openPanelClick(Sender: TObject);
    procedure updatePanelFields();
    procedure DBGrid1CellClick(Column: TColumn);
    function usersActionControllerCheckOnError(action: String; id, groupId: Integer; surname, name, patronymic, email, username, password: String): Boolean;
    procedure usersActionController(action: String; id: Integer; group, surname, name, patronymic, email, username, password: String);
    procedure showErrorLabel(text: String);
    procedure resetPanelFields();
    procedure addRecordInUsers(groupId: Integer; surname, name, patronymic, email, username, password: String);
    procedure updateRecordInUsers(id, groupId: Integer; surname, name, patronymic, email, username, password: String);
    procedure deleteRecordFromUsers(id: Integer);
    procedure Button1Click(Sender: TObject);
    procedure buttonAddClick(Sender: TObject);
    procedure buttonChangeClick(Sender: TObject);
    procedure buttonDeleteClick(Sender: TObject);
    function getGroupNameFromStudentId(studentId: Integer): String;
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Users: TUsers;
  recordId: Integer;
  loginAndPassword: Boolean;

implementation

{$R *.dfm}

Uses Unit2, StrUtils, Unit9;

procedure TUsers.Button1Click(Sender: TObject);
begin
  errorLabel.Visible := False;
  resetPanelFields();
end;

procedure TUsers.CheckBox1Click(Sender: TObject);
begin
  loginAndPassword := CheckBox1.Checked;
  DBGrid1.Columns[6].Visible := loginAndPassword;
  DBGrid1.Columns[7].Visible := loginAndPassword;
  usernameEdit.Visible := loginAndPassword;
  passwordEdit.Visible := loginAndPassword;
  Label7.Visible := loginAndPassword;
  Label8.Visible := loginAndPassword;
end;

procedure TUsers.DBGrid1CellClick(Column: TColumn);
begin
  updatePanelFields();
end;

function TUsers.getGroupNameFromStudentId(studentId: Integer): String;
begin
  DataModule1.ADOQueryUsers.Close;
  DataModule1.ADOQueryUsers.SQL.Text :=
  'SELECT g.name ' +
  'FROM Users AS u ' +
  'INNER JOIN Groups AS g ON g.id = u.group_id ' +
  'WHERE u.id = ' + IntToStr(studentId) + ';';
  DataModule1.ADOQueryUsers.Open;

  getGroupNameFromStudentId := DataModule1.DataSourceUsers.DataSet.Fields[0].AsString;
end;


procedure TUsers.FormActivate(Sender: TObject);
begin
  CheckBox1.Visible := True;
  openPanel.Visible := True;
  selectGroup.Enabled := True;
  Panel1.Visible := False;

  if (Authorization.userType = 'student') then begin
    CheckBox1.Visible := False;
    openPanel.Visible := False;
    selectGroup.KeyValue := getGroupNameFromStudentId(Authorization.userID);
    selectGroup.Enabled := False;
  end;

  if (Authorization.userType = 'teacher') then begin
    CheckBox1.Visible := False;
    openPanel.Visible := False;
  end;

  updateGrid();
  CheckBox1Click(CheckBox1);
end;

procedure TUsers.FormMouseWheel(Sender: TObject; Shift: TShiftState;
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

  If selectGroup.Focused then begin
    If (WheelDelta < 0) then begin
      selectGroup.Perform(WM_KEYDOWN, VK_DOWN, 0)
    end
    else begin
      selectGroup.Perform(WM_KEYDOWN, VK_UP, 0);
    end;
  end;

  If selectGroupPanel.Focused then begin
    If (WheelDelta < 0) then begin
      selectGroupPanel.Perform(WM_KEYDOWN, VK_DOWN, 0)
    end
    else begin
      selectGroupPanel.Perform(WM_KEYDOWN, VK_UP, 0);
    end;
  end;

  Handled := True;
end;

function TUsers.getGroupId(groupName: String): Integer;
begin
  DataModule1.ADOQueryUsers.Close;
  DataModule1.ADOQueryUsers.SQL.Text :=
  'SELECT * ' +
  'FROM Groups ' +
  'WHERE name LIKE "' + groupName + '"';
  DataModule1.ADOQueryUsers.Open;

  getGroupId := DataModule1.DataSourceUsers.DataSet.Fields[0].AsInteger;
end;

procedure TUsers.openPanelClick(Sender: TObject);
begin
  errorLabel.Visible := False;
  Panel1.Visible := NOT Panel1.Visible;
  updatePanelFields();
end;

procedure TUsers.updatePanelFields();
begin
  selectId.KeyValue := DBGrid1.Fields[0].AsString;
  recordId := selectId.KeyValue;

  selectGroupPanel.KeyValue := DBGrid1.Fields[1].AsString;
  surnameEdit.Text := DBGrid1.Fields[2].AsString;
  nameEdit.Text := DBGrid1.Fields[3].AsString;
  patronymicEdit.Text := DBGrid1.Fields[4].AsString;
  emailEdit.Text := DBGrid1.Fields[5].AsString;
  usernameEdit.Text := DBGrid1.Fields[6].AsString;
  passwordEdit.Text := DBGrid1.Fields[7].AsString;
end;

procedure TUsers.resetPanelFields();
begin
  selectId.KeyValue := '';
  recordId := 0;
  
  selectGroupPanel.KeyValue := '';
  surnameEdit.Text := '';
  nameEdit.Text := '';
  patronymicEdit.Text := '';
  emailEdit.Text := '';
  usernameEdit.Text := '';
  passwordEdit.Text := '';
end;

procedure TUsers.showMainTable(groupId: Integer);
begin
  DataModule1.ADOQueryUsersShow.Close;
  DataModule1.ADOQueryUsersShow.SQL.Text :=
  'SELECT u.id, g.name AS GN, surname, u.name, patronymic, email, username, password ' +
  'FROM Users AS u ' +
  'INNER JOIN Groups AS g ON ((g.id = u.group_id) AND (g.id = ' + IntToStr(groupId) + ')) ' +
  'ORDER BY u.id';
  DataModule1.ADOQueryUsersShow.Open;
end;

procedure TUsers.selectGroupClick(Sender: TObject);
begin
  updateGrid();
  resetPanelFields();
end;

procedure TUsers.updateGrid();
var
  group: String;
  groupId: Integer;
begin
  group := selectGroup.KeyValue;

  if NOT (group = '') then begin
    groupId := getGroupId(group)
  end
  else
  begin
    selectGroup.KeyValue := DataModule1.ADOQueryGroupsShow.FieldByName('name').AsString;
    groupId := getGroupId(selectGroup.KeyValue)
  end;

  showMainTable(groupId);
end;

procedure TUsers.showErrorLabel(text: String);
begin
  errorLabel.Visible := True;
  errorLabel.Caption := text;
end;

function TUsers.usersActionControllerCheckOnError(action: String; id, groupId: Integer; surname, name, patronymic, email, username, password: String): Boolean;
begin
  if ((String(id) = '') AND (action <> 'add')) then begin
    showErrorLabel('Ошибка ИД');
    usersActionControllerCheckOnError := True;
    Exit;
  end;

  if action = 'delete' then begin
    usersActionControllerCheckOnError := False;
    Exit;
  end;

  if String(groupId) = '' then begin
    showErrorLabel('Ошибка группы');
    usersActionControllerCheckOnError := True;
    Exit;
  end;

  if surname = '' then begin
    showErrorLabel('Ошибка фамилии');
    usersActionControllerCheckOnError := True;
    Exit;
  end;

  if name = '' then begin
    showErrorLabel('Ошибка имени');
    usersActionControllerCheckOnError := True;
    Exit;
  end;

  if patronymic = '' then begin
    showErrorLabel('Ошибка отчества');
    usersActionControllerCheckOnError := True;
    Exit;
  end;

  if email = '' then begin
    showErrorLabel('Ошибка email');
    usersActionControllerCheckOnError := True;
    Exit;
  end;

  if (username = '') AND (loginAndPassword = true)  then begin
    showErrorLabel('Ошибка username');
    usersActionControllerCheckOnError := True;
    Exit;
  end;

  if (password = '') AND (loginAndPassword = true) then begin
    showErrorLabel('Ошибка password');
    usersActionControllerCheckOnError := True;
    Exit;
  end;

  usersActionControllerCheckOnError := False;
end;

procedure TUsers.addRecordInUsers(groupId: Integer; surname, name, patronymic, email, username, password: String);
begin
  DataModule1.ADOQueryUsers.Close;
  DataModule1.ADOQueryUsers.SQL.Text :=
  'INSERT INTO Users (surname, name, patronymic, email, username, [password], group_id) ' +
  'VALUES (' +
    '"' + surname + '", ' + 
    '"' + name + '", ' +
    '"' + patronymic + '", ' +
    '"' + email + '", ' +
    '"' + username + '", ' +
    '"' + password + '", ' +
    IntToStr(groupId)+
  ');';
  DataModule1.ADOQueryUsers.ExecSQL;
end;

procedure TUsers.updateRecordInUsers(id, groupId: Integer; surname, name, patronymic, email, username, password: String);
begin
  DataModule1.ADOQueryUsers.Close;
  DataModule1.ADOQueryUsers.SQL.Text :=
  'UPDATE Users ' +
  'SET '+
    'surname = "' + surname + '", ' +
    '[name] = "' + name + '", ' +
    'patronymic= "' + patronymic + '", ' +
    'email = "' + email + '", ' +
    'username = "' + username + '", ' +
    '[password] = "' + password + '", ' +
    'group_id = ' + IntToStr(groupId) + ' ' +
  'WHERE ' +
    'id = ' + IntToStr(id) + ';';
  DataModule1.ADOQueryUsers.ExecSQL;
end;

procedure TUsers.deleteRecordFromUsers(id: Integer);
begin
  DataModule1.ADOQueryUsers.Close;
  DataModule1.ADOQueryUsers.SQL.Text :=
  'DELETE ' +
  'FROM Users ' +
  'WHERE id = ' + IntToStr(id) + ';';
  DataModule1.ADOQueryUsers.ExecSQL;
end;

procedure TUsers.usersActionController(action: String; id: Integer; group, surname, name, patronymic, email, username, password: String);
var
  groupId: Integer;
begin
  errorLabel.Visible := False;
  groupId := getGroupId(group);

  if (usersActionControllerCheckOnError(action, id, groupId, surname, name, patronymic, email, username, password) = true) then begin
    Exit;
  end;

  case StrUtils.IndexStr(action, ['add', 'update', 'delete']) of
    0: addRecordInUsers(groupId, surname, name, patronymic, email, username, password);
    1: updateRecordInUsers(id, groupId, surname, name, patronymic, email, username, password);
    2: deleteRecordFromUsers(id);
  end;

  showMainTable(groupId);
  selectGroup.KeyValue := group;
  CheckBox1Click(CheckBox1);
  Button1Click(Button1);
end;

procedure TUsers.buttonAddClick(Sender: TObject);
begin
  usersActionController('add', recordId, selectGroupPanel.KeyValue, 
  surnameEdit.Text, nameEdit.Text, patronymicEdit.Text,
  emailEdit.Text, usernameEdit.Text, passwordEdit.Text);
end;

procedure TUsers.buttonChangeClick(Sender: TObject);
begin
  usersActionController('update', recordId, selectGroupPanel.KeyValue,
  surnameEdit.Text, nameEdit.Text, patronymicEdit.Text,
  emailEdit.Text, usernameEdit.Text, passwordEdit.Text);
end;

procedure TUsers.buttonDeleteClick(Sender: TObject);
begin
  usersActionController('delete', recordId, selectGroupPanel.KeyValue,
  surnameEdit.Text, nameEdit.Text, patronymicEdit.Text,
  emailEdit.Text, usernameEdit.Text, passwordEdit.Text);
end;

end.
