unit Unit3;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Menus, Vcl.ComCtrls,
  Vcl.StdCtrls, Vcl.ExtCtrls, Vcl.DBCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TForm3 = class(TForm)
    Label1: TLabel;
    Label2: TLabel;
    DBGrid1: TDBGrid;
    selectGroup: TDBLookupComboBox;
    selectSubject: TDBLookupComboBox;
    Panel1: TPanel;
    Label3: TLabel;
    Label4: TLabel;
    errorLabel: TLabel;
    daysOfWeekLabel: TLabel;
    buttonAdd: TButton;
    selectDate: TDateTimePicker;
    selectStudent: TDBLookupComboBox;
    selectMark: TDBLookupComboBox;
    buttonChange: TButton;
    buttonDelete: TButton;
    openPanel: TButton;
    MainMenu1: TMainMenu;
    Main2: TMenuItem;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form3: TForm3;

implementation

{$R *.dfm}

uses Unit2;

procedure TForm3.showMainTable(groupId, subjectId: Integer);
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'TRANSFORM Max(j.mark_id) AS [Max-mark_id] '
  + 'SELECT u.surname AS fullname '
  + 'FROM '
  + '  ( '
  + '    SELECT * '
  + '    FROM Journal '
  + '    WHERE Journal.subject_id = ' + IntToStr(subjectId) + ' '
  + '  ) AS j '
  + '  RIGHT JOIN ( '
  + '    SELECT '
  + '      Users.id AS id, '
  + '      Users.surname as surname, '
  + '      Users.name AS name, '
  + '      Users.patronymic AS patronymic '
  + '    FROM Users '
  + '    INNER JOIN Groups ON Users.group_id = Groups.id '
  + '    WHERE Groups.id = ' + IntToStr(groupId) + ' '
  + '    ORDER BY Users.id '
  + '  ) AS u ON j.user_id = u.id '
  + 'GROUP BY u.surname  '
  + 'PIVOT j.date; ';
  DataModule1.ADOQueryMain.Open;

  DBGrid1.Columns[1].Visible := false;
end;

procedure TForm3.addRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
begin
  // DataModule1.ADOQueryAddMarks.Close;
  // DataModule1.ADOQueryAddMarks.SQL.Text :=
  // 'INSERT INTO Journal (user_id, subject_id, mark_id, [date]) '   +
  // 'VALUES (' + IntToStr(studentID) + ', ' + IntToStr(subjectID) +
  // ', ' +  IntToStr(markID)
  // + ', DateValue("' + DateTimeToStr(date) + '"))';

  // DataModule1.ADOQueryAddMarks.ExecSQL;
end;

procedure TForm3.updateRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
begin
  // DataModule1.ADOQueryAddMarks.Close;
  // DataModule1.ADOQueryAddMarks.SQL.Text :=
  // 'UPDATE Journal ' +
  // 'SET ' +
  //   'mark_id = ' + IntToStr(markID) + ' ' +
  // 'WHERE '+
  // ' user_id = ' + IntToStr(studentID) + ' AND ' +
  // ' subject_id = ' + IntToStr(subjectID) + ' AND ' +
  // 'date = DateValue("' + DateTimeToStr(date) + '"); ';
  // DataModule1.ADOQueryAddMarks.ExecSQL;
end;

procedure TForm3.deleteRecordFromJournal(studentID, subjectID: Integer; date: TDateTime);
begin
  // DataModule1.ADOQueryAddMarks.Close;
  // DataModule1.ADOQueryAddMarks.SQL.Text :=
  // 'DELETE ' +
  // 'FROM Journal ' +
  // 'WHERE ' +
  //   'user_id = ' + IntToStr(studentID) + ' AND ' +
  //   'subject_id = ' + IntToStr(subjectID) + ' AND ' +
  //   'date = DateValue("' + DateTimeToStr(date) + '")';
  // DataModule1.ADOQueryAddMarks.ExecSQL;
end;


procedure TForm3.subjectsOnCellClick(Column: TColumn);
var
//  colName: String;
//  fmt: TFormatSettings;
begin
//  selectStudent.KeyValue := DBGrid1.Fields[0].AsString;
//  selectMark.KeyValue := DBGrid1.Fields[Column.Index].AsString;
//
//  colName := Column.DisplayName;
//  fmt.ShortDateFormat  := 'dd_mm_yyyy';
//  fmt.DateSeparator   := '_';
//  if NOT (colName = 'fullname') then begin
//    selectDate.Date := StrToDate(colName, fmt);
//  end;

end;

function TForm3.subjectsActionControllerCheckOnError(action, name, audience, teacher: String; errorString: TLabel): Boolean;
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

procedure TForm3.subjectsActionController(action: String; name, audience: TEdit; teacherComboBox: TDBLookupComboBox; errorString: TLabel);
var
  name, audience, teacher: String;
begin
  name := name.Text;
  audience := audience.Text;
  teacher := teacherComboBox.KeyValue;

  if (subjectsActionControllerCheckOnError(action, name, audience, teacher, errorString) = true) then begin
    Exit;
  end;

  teacherId := getTeacherId(teacher); // getTeacherId - заглушка

  case StrUtils.IndexStr(action, ['add', 'update', 'delete']) of
    0: addRecordInSubjects(name, audience, teacherId); // Заглушка
    1: updateRecordInSubjects(name, audience, teacherId); // Заглушка
    2: deleteRecordFromSubjects(name, audience, teacherId); // Заглушка
  end;

  showMainTable(groupId, subjectId);

  teacherComboBox.KeyValue := ''; // Заменить на 1 человека в датасете
end;

procedure TForm3.buttonAddClick(Sender: TObject);
begin
  subjectsActionController('add', nameEdit, audienceEdit, teacherComboBox)
end;

procedure TForm3.buttonChangeClick(Sender: TObject);
begin
  subjectsActionController('update', nameEdit, audienceEdit, teacherComboBox)
end;

procedure TForm3.buttonDeleteClick(Sender: TObject);
begin
  subjectsActionController('delete', nameEdit, audienceEdit, teacherComboBox)
end;

procedure TForm3.openPanelClick(Sender: TObject);
begin
  Panel1.Visible := true;
end;

procedure TForm3.FormActivate(Sender: TObject);
begin
  //
end;

procedure TForm3.FormCreate(Sender: TObject);
begin
  NullStrictConvert := False;
end;

end.
