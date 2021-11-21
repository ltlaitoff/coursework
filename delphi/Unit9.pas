unit Unit9;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.StdCtrls, Data.DB, Vcl.Grids,
  Vcl.DBGrids;

type
  TAuthorization = class(TForm)
    admin: TButton;
    student: TButton;
    teacher: TButton;
    errorLabel: TLabel;

    procedure authorizationController(action: String);
    procedure studentClick(Sender: TObject);
    procedure teacherClick(Sender: TObject);
    procedure adminClick(Sender: TObject);
    function authorizationControllerCheckOnError(action, login, password: String): Boolean;
    procedure showErrorLabel(text: String);
    function teacherAuthentication(login, password: String): Integer;
    procedure showMainForm();
    function studentAuthentication(login, password: String): Integer;
  private
    { Private declarations }
  public
    userType: String;
    userID: Integer;
  end;

const
  ADMIN_LOGIN = 'admin';
  ADMIN_PASSWORD = 'admin';
var
  Authorization: TAuthorization;

implementation

{$R *.dfm}
{$APPTYPE CONSOLE}

uses Unit1, Unit2, StrUtils;

procedure TAuthorization.showErrorLabel(text: String);
begin
  errorLabel.Visible := True;
  errorLabel.Caption := text;
end;

function TAuthorization.authorizationControllerCheckOnError(action, login, password: String): Boolean;
begin
  if (login = '') then begin
    showErrorLabel('Пустой логин');
    authorizationControllerCheckOnError := true;
    Exit;
  end;

  if (password = '') then begin
    showErrorLabel('Пустой пароль');
    authorizationControllerCheckOnError := true;
    Exit;
  end;
  
  authorizationControllerCheckOnError := false;
end;

function TAuthorization.teacherAuthentication(login, password: String): Integer;
var
  value: String;
begin
  DataModule1.ADOQueryAuthorization.Close;
  DataModule1.ADOQueryAuthorization.SQL.Text := 
  'SELECT id ' + 
  'FROM Teachers ' +
  'WHERE (username = "' + login + '") AND ' +
  '(password = "' + password + '");';
  DataModule1.ADOQueryAuthorization.Open;

  value := DataModule1.DataSourceAuthorization.DataSet.Fields[0].AsString;
  if (value = '') then begin
    teacherAuthentication := -1;
    Exit;
  end;

  teacherAuthentication := StrToInt(value);
end;

function TAuthorization.studentAuthentication(login, password: String): Integer;
var
  value: String;
begin
  DataModule1.ADOQueryAuthorization.Close;
  DataModule1.ADOQueryAuthorization.SQL.Text :=
  'SELECT id ' +
  'FROM Users ' +
  'WHERE (username = "' + login + '") AND ' +
  '(password = "' + password + '");';
  DataModule1.ADOQueryAuthorization.Open;

  value := DataModule1.DataSourceAuthorization.DataSet.Fields[0].AsString;

  if (value = '') then begin
    studentAuthentication := -1;
    Exit;
  end;

  studentAuthentication := StrToInt(value);
end;


procedure TAuthorization.showMainForm();
begin
  Main.Show();
  Authorization.Hide();
end;

procedure TAuthorization.authorizationController(action: String);
var
  currentLogin, currentPassword: String;
  value: Integer;
begin
  InputQuery('������� �����', '�����: ', currentLogin);
  InputQuery('������� ������', '������: ', currentPassword);

  if (authorizationControllerCheckOnError(action, currentLogin, currentPassword) = true) then begin
    Exit;
  end;

  case StrUtils.IndexStr(action, ['admin', 'teacher', 'student']) of
    0: begin
      if (currentLogin = ADMIN_LOGIN) AND (currentPassword = ADMIN_PASSWORD) then begin
        userType := 'admin';
        showMainForm();
      end;
    end;

    1: begin
      value := teacherAuthentication(currentLogin, currentPassword);

      if (value = -1) then begin
        showErrorLabel('Вы ввели неверный логин или пароль');
        Exit;
      end;

      userType := 'teacher';
      userId := value;
      showMainForm();
    end;

    2: begin
      value := studentAuthentication(currentLogin, currentPassword);

      if (value = -1) then begin
        showErrorLabel('Вы ввели неверный логин или пароль');
        Exit;
      end;

      userType := 'student';
      userId := value;
      showMainForm();
    end;
  end;

end;

procedure TAuthorization.adminClick(Sender: TObject);
begin
  authorizationController('admin');
end;

procedure TAuthorization.studentClick(Sender: TObject);
begin
  authorizationController('student');
end;

procedure TAuthorization.teacherClick(Sender: TObject);
begin
  authorizationController('teacher');
end;

end.

