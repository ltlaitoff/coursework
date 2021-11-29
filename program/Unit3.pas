unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TSubjects = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    errorLabel: TLabel;
    buttonAdd: TButton;
    teacherComboBox: TDBLookupComboBox;
    buttonChange: TButton;
    buttonDelete: TButton;
    openPanel: TButton;
    nameEdit: TEdit;
    audienceEdit: TEdit;
    clear: TButton;
    Label1: TLabel;
    Panel2: TPanel;
    procedure subjectsActionController(action: String; nameEdit, audienceEdit: TEdit;
    teacherComboBox: TDBLookupComboBox; errorString: TLabel; recordId: Integer);
    function setRecordId(name: String; audienceNumber, teacherId: Integer): Integer;
    procedure addRecordInSubjects(name, audience: String; teacherId: Integer);
    procedure updateRecordInSubjects(name, audience: String; teacherId, recordId: Integer);
    procedure deleteRecordFromSubjects(recordId: Integer);
    function subjectsActionControllerCheckOnError(action, name, audience, teacher: String; errorString: TLabel): Boolean;
    procedure buttonAddClick(Sender: TObject);
    procedure buttonChangeClick(Sender: TObject);
    procedure buttonDeleteClick(Sender: TObject);
    function getTeacherId(surname: String): Integer;
    procedure showSubjectsTable();
    procedure openPanelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure DBGrid1CellClick(Column: TColumn);
    function getSurname(fullName: String): String;
    procedure clearClick(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    procedure teacherComboBoxClick(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Subjects: TSubjects;
  recordId: Integer;

implementation

{$R *.dfm}

uses Unit2, StrUtils, Unit9;

function TSubjects.getSurname(fullName: String): String;
var
  position: Integer;
begin
  position := Pos(' ', fullName);
  getSurname := Copy(fullName, 0, position);
end;

procedure TSubjects.showSubjectsTable();
begin
  DataModule1.ADOQuerySubjectsShow.Close;
  DataModule1.ADOQuerySubjectsShow.SQL.Text :=
    'SELECT s.id, s.name, s.audience, (t.surname & " " & t.name) AS teacher ' +
    'FROM Subjects AS s ' +
    'INNER JOIN Teachers AS t ON (t.ID = s.teacher_id) ' +
    'ORDER BY s.id';
  DataModule1.ADOQuerySubjectsShow.Open;
end;

procedure TSubjects.DBGrid1CellClick(Column: TColumn);
var
  colName: String;
  fmt: TFormatSettings;
begin
  recordId := DBGrid1.Fields[0].AsInteger;
  nameEdit.Text := DBGrid1.Fields[1].AsString;
  audienceEdit.Text := DBGrid1.Fields[2].AsString;
  teacherComboBox.KeyValue := getSurname(DBGrid1.Fields[3].AsString);
end;

function TSubjects.getTeacherId(surname: String): Integer;
begin
  DataModule1.ADOQuerySubjects.Close;
  DataModule1.ADOQuerySubjects.SQL.Text :=
  'SELECT id ' +
  'FROM Teachers ' +
  'WHERE surname = "' + surname + '";';
  DataModule1.ADOQuerySubjects.Open;

  getTeacherId := DataModule1.DataSourceSubjects.DataSet.Fields[0].AsInteger;
end;

function TSubjects.setRecordId(name: String; audienceNumber, teacherId: Integer): Integer;
begin
  DataModule1.ADOQuerySubjects.Close;
  DataModule1.ADOQuerySubjects.SQL.Text :=
  'SELECT id' +
  'FROM Subjects' +
  'WHERE (' +
    'name = ' + name + ', ' +
    'audience = ' + IntToStr(audienceNumber) + ', ' +
    'teacher_id = ' + IntToStr(teacherId) + ')';
  DataModule1.ADOQuerySubjects.Open;

  setRecordId := DataModule1.DataSourceSubjects.DataSet.Fields[0].AsInteger;
end;

procedure TSubjects.addRecordInSubjects(name, audience: String; teacherId: Integer);
begin
  DataModule1.ADOQuerySubjects.Close;
  DataModule1.ADOQuerySubjects.SQL.Text :=
  'INSERT INTO Subjects (name, audience, teacher_id) '   +
  'VALUES ("' + name + '", ' +
          '"' + audience + '", '
            +  IntToStr(teacherId) +
          ')';

  DataModule1.ADOQuerySubjects.ExecSQL;
end;

procedure TSubjects.updateRecordInSubjects(name, audience: String; teacherId, recordId: Integer);
begin
  DataModule1.ADOQuerySubjects.Close;
  DataModule1.ADOQuerySubjects.SQL.Text :=
  'UPDATE Subjects ' +
  'SET ' +
    'name = "' + name + '", ' +
    'audience = ' + audience + ', ' +
    'teacher_id = ' + IntToStr(teacherId) + ' ' +
  'WHERE '+
    'id = ' + IntToStr(recordId) + ';';
  DataModule1.ADOQuerySubjects.ExecSQL;
end;

procedure TSubjects.deleteRecordFromSubjects(recordId: Integer);
begin
  DataModule1.ADOQuerySubjects.Close;
  DataModule1.ADOQuerySubjects.SQL.Text :=
  'DELETE ' +
  'FROM Subjects ' +
  'WHERE ' +
    'id = ' + IntToStr(recordId);
  DataModule1.ADOQuerySubjects.ExecSQL;
end;

function TSubjects.subjectsActionControllerCheckOnError(action, name, audience, teacher: String; errorString: TLabel): Boolean;
var
  selectedDayNumber: Integer;
begin
  if (name = '') then begin
    errorString.Visible := True;
    errorString.Caption := 'Укажите название!';
    subjectsActionControllerCheckOnError := True;
    Exit;
  end;

  if (audience = '') then begin
    errorString.Visible := True;
    errorString.Caption := 'Укажите номер аудитории!';
    subjectsActionControllerCheckOnError := True;
    Exit;
  end;

  if (teacher = '') then begin
    errorString.Visible := True;
    errorString.Caption := 'Укажите учителя!';
    subjectsActionControllerCheckOnError := True;
    Exit;
  end;

  subjectsActionControllerCheckOnError := False;
end;

procedure TSubjects.teacherComboBoxClick(Sender: TObject);
begin
  errorLabel.Visible := False;
end;

procedure TSubjects.subjectsActionController(action: String; nameEdit, audienceEdit: TEdit;
  teacherComboBox: TDBLookupComboBox; errorString: TLabel; recordId: Integer);
var
  name, audience, teacher: String;
  teacherId: Integer;
begin
  errorLabel.Visible := False;

  name := nameEdit.Text;
  audience := audienceEdit.Text;
  teacher := teacherComboBox.KeyValue;

  if (subjectsActionControllerCheckOnError(action, name, audience, teacher, errorString) = true) then begin
    Exit;
  end;

  teacherId := getTeacherId(teacher);

  case StrUtils.IndexStr(action, ['add', 'update', 'delete']) of
    0: addRecordInSubjects(name, audience, teacherId);
    1: updateRecordInSubjects(name, audience, teacherId, recordId);
    2: deleteRecordFromSubjects(recordId);
  end;

  showSubjectsTable();

  clearClick(clear);
end;

procedure TSubjects.clearClick(Sender: TObject);
begin
  errorLabel.Visible := False;
  recordId := -1;
  nameEdit.Text := '';
  audienceEdit.Text := '';
  teacherComboBox.KeyValue := '';
end;

procedure TSubjects.buttonAddClick(Sender: TObject);
begin
  subjectsActionController('add', nameEdit, audienceEdit, teacherComboBox, errorLabel, recordId);
end;

procedure TSubjects.buttonChangeClick(Sender: TObject);
begin
  subjectsActionController('update', nameEdit, audienceEdit, teacherComboBox, errorLabel, recordId);
end;

procedure TSubjects.buttonDeleteClick(Sender: TObject);
begin
  subjectsActionController('delete', nameEdit, audienceEdit, teacherComboBox, errorLabel, recordId);
end;

procedure TSubjects.openPanelClick(Sender: TObject);
begin
  errorLabel.Visible := False;
  Panel1.Visible := NOT Panel1.Visible;
end;

procedure TSubjects.FormActivate(Sender: TObject);
begin
  openPanel.Enabled := True;
  Panel1.Visible := False;

  if ((Authorization.userType = 'student') OR (Authorization.userType = 'teacher')) then begin
    openPanel.Enabled := false;
  end;

  recordId := DBGrid1.Fields[0].AsInteger;
  nameEdit.Text := DBGrid1.Fields[1].AsString;
  audienceEdit.Text := DBGrid1.Fields[2].AsString;
  teacherComboBox.KeyValue := getSurname(DBGrid1.Fields[3].AsString);

  showSubjectsTable();
end;

procedure TSubjects.FormCreate(Sender: TObject);
begin
  NullStrictConvert := False;
end;

procedure TSubjects.FormMouseWheel(Sender: TObject; Shift: TShiftState;
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

  If teacherComboBox.Focused then begin
    If (WheelDelta < 0) then begin
      teacherComboBox.Perform(WM_KEYDOWN, VK_DOWN, 0)
    end
    else begin
      teacherComboBox.Perform(WM_KEYDOWN, VK_UP, 0);
    end;
  end;

  Handled := True;
end;

end.
