﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Tabs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TForm1 = class(TForm)
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
    procedure updateGrid();
    procedure buttonAddClick(Sender: TObject);
    procedure DateTimePicker1OnChange(Sender: TObject);
    procedure openPanelClick(Sender: TObject);
    procedure buttonChangeClick(Sender: TObject);

    procedure showMainTable(groupId, subjectId: Integer);
    function getGroupId(groupName: String): Integer;
    function getSubjectId(subjectName: String): Integer;
    procedure doQueryDaysOfWeek(groupId, subjectId: Integer);
    procedure updateArrayDaysOfWeek(groupId, subjectId: Integer);
    procedure updateStringDaysOfWeek(groupId, subjectId: Integer);
    function getMarkId(markName: String): Integer;
    function getStudentId(studentSurname: String): Integer;
    procedure addRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
    procedure updateRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
    procedure deleteRecordFromJournal(studentID, subjectID: Integer; date: TDateTime);
    procedure journalActionController(action: String; subjectId, groupId: Integer; studentComboBox, markComboBox: TDBLookupComboBox);
    function journalActionControllerCheckOnError(action, student, mark: String; date: TDateTime; errorString: TLabel): Boolean;
    function checkValueInArray(arr: array of Integer; value: Integer): Boolean;
    procedure FormCreate(Sender: TObject);
    procedure doQueryStudentsFromGroup(groupId: Integer);
    procedure buttonDeleteClick(Sender: TObject);
    procedure journalOnCellClick(Column: TColumn);
    procedure selectSubjectClick(Sender: TObject);
    procedure selectGroupClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure Main2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  groupId, subjectId: Integer;
  arrayDaysOfWeek: array of Integer;

implementation

{$R *.dfm}
{$APPTYPE CONSOLE}

uses Unit2, StrUtils, Unit3;

procedure TForm1.selectGroupClick(Sender: TObject);
begin
  updateGrid();
end;

procedure TForm1.selectSubjectClick(Sender: TObject);
begin
  updateGrid();
end;

procedure TForm1.showMainTable(groupId, subjectId: Integer);
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

function TForm1.getGroupId(groupName: String): Integer;
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT * ' +
  'FROM Groups ' +
  'WHERE name LIKE "' + groupName + '"';
  DataModule1.ADOQueryMain.Open;

  getGroupId := DataModule1.DataSourceMain.DataSet.Fields[0].AsInteger;
end;

function TForm1.getSubjectId(subjectName: String): Integer;
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT * ' +
  'FROM Subjects ' +
  'WHERE name LIKE "' + subjectName + '"';
  DataModule1.ADOQueryMain.Open;

  getSubjectId := DataModule1.DataSourceMain.DataSet.Fields[0].AsInteger;
end;

procedure TForm1.doQueryDaysOfWeek(groupId, subjectId: Integer);
begin
  DataModule1.ADOQueryTimetableGet.Close;
  DataModule1.ADOQueryTimetableGet.SQL.Text :=
    'SELECT  day_of_week '
  + 'FROM Timetable '
  + 'WHERE (group_id = ' + IntToStr(groupId) + ') AND '
  + '(subject_id = ' + IntToStr(subjectId) + ')';
  DataModule1.ADOQueryTimetableGet.Open;
end;

procedure TForm1.updateArrayDaysOfWeek(groupId, subjectId: Integer);
var
  len, i: Integer;
begin
  doQueryDaysOfWeek(groupId, subjectId);

  len := DataModule1.DataSourceTimetableGet.DataSet.RecordCount;
  SetLength(arrayDaysOfWeek, len);

  DataModule1.DataSourceTimetableGet.DataSet.First();

  while not DataModule1.DataSourceTimetableGet.DataSet.Eof do begin
    for i := 0 to len do
    begin
      arrayDaysOfWeek[i] :=
        DataModule1.DataSourceTimetableGet.DataSet.FieldByName('day_of_week').AsInteger;

      DataModule1.DataSourceTimetableGet.DataSet.Next();
    end;
  end;
end;

procedure TForm1.updateStringDaysOfWeek(groupId, subjectId: Integer);
var
  len, i: Integer;
  result: String;
begin
  updateArrayDaysOfWeek(groupId, subjectId);
  
  len := Length(arrayDaysOfWeek);
  result := '';

  for i := 0 to len - 1 do
  begin
    case(arrayDaysOfWeek[i]) of
      1: result := result + ' Понедельник';
      2: result := result + ' Вторник';
      3: result := result + ' Среда';
      4: result := result + ' Четверг';
      5: result := result + ' Пятница';
    end;
  end;

  daysOfWeekLabel.Caption := result;
end;

procedure TForm1.doQueryStudentsFromGroup(groupId: Integer);
begin
  DataModule1.ADOQueryStudentsFromGroup.Close;
  DataModule1.ADOQueryStudentsFromGroup.SQL.Text :=
  'SELECT '
  + 'Users.id AS id, '
  + 'Users.surname as surname, '
  + 'Users.name AS name, '
  + 'Users.patronymic AS patronymic '
  + 'FROM Users '
  + 'INNER JOIN Groups ON Users.group_id = Groups.id '
  + 'WHERE Groups.id = ' + IntToStr(groupId) + ' '
  + 'ORDER BY Users.id ';
  DataModule1.ADOQueryStudentsFromGroup.Open;
end;

procedure TForm1.updateGrid();
var
  group, subject: String;
begin
  group := selectGroup.KeyValue;
  subject := selectSubject.KeyValue;

  if NOT (group = '') then begin
    groupId := getGroupId(selectGroup.KeyValue)
  end
  else
  begin
    selectGroup.KeyValue := DataModule1.ADOTableGroups.FieldByName('name').AsString;
  end;

  if NOT (subject = '') then begin
    subjectId := getSubjectId(subject)
  end
  else
  begin
    selectSubject.KeyValue := DataModule1.ADOTableSubjects.FieldByName('name').AsString;
  end;
  showMainTable(groupId, subjectId);

  updateStringDaysOfWeek(groupId, subjectId);
  doQueryStudentsFromGroup(groupId);
end;

procedure TForm1.openPanelClick(Sender: TObject);
begin
  Panel1.Visible := true;
  selectStudent.KeyValue := DBGrid1.Fields[0].AsString;
end;

function TForm1.getMarkId(markName: String): Integer;
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'SELECT * '    +
  'FROM Marks ' +
  'WHERE mark LIKE "' + markName + '"';
  DataModule1.ADOQueryAddMarks.Open;

  getMarkId := DataModule1.DataSourceAddMarks.DataSet.Fields[0].AsInteger;
end;

function TForm1.getStudentId(studentSurname: String): Integer;
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'SELECT id '    +
  'FROM Users ' +
  'WHERE surname LIKE "' + studentSurname + '"';
  DataModule1.ADOQueryAddMarks.Open;

  getStudentId := DataModule1.DataSourceAddMarks.DataSet.Fields[0].AsInteger;
end;

procedure TForm1.addRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'INSERT INTO Journal (user_id, subject_id, mark_id, [date]) '   +
  'VALUES (' + IntToStr(studentID) + ', ' + IntToStr(subjectID) +
  ', ' +  IntToStr(markID)
  + ', DateValue("' + DateTimeToStr(date) + '"))';

  DataModule1.ADOQueryAddMarks.ExecSQL;
end;

procedure TForm1.updateRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'UPDATE Journal ' +
  'SET ' +
    'mark_id = ' + IntToStr(markID) + ' ' +
  'WHERE '+
  ' user_id = ' + IntToStr(studentID) + ' AND ' +
  ' subject_id = ' + IntToStr(subjectID) + ' AND ' +
  'date = DateValue("' + DateTimeToStr(date) + '"); ';
  DataModule1.ADOQueryAddMarks.ExecSQL;
end;

procedure TForm1.deleteRecordFromJournal(studentID, subjectID: Integer; date: TDateTime);
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'DELETE ' +
  'FROM Journal ' +
  'WHERE ' +
    'user_id = ' + IntToStr(studentID) + ' AND ' +
    'subject_id = ' + IntToStr(subjectID) + ' AND ' +
    'date = DateValue("' + DateTimeToStr(date) + '")';
  DataModule1.ADOQueryAddMarks.ExecSQL;
end;

function TForm1.checkValueInArray(arr: array of Integer; value: Integer): Boolean;
var
  len, i: Integer;
begin
  len := Length(arr);

  for i := 0 to len - 1 do begin
    if (arr[i] = value) then begin
      checkValueInArray := true;
      Exit;
    end;
  end;

  checkValueInArray := false;
end;

function TForm1.journalActionControllerCheckOnError(action, student, mark: String; date: TDateTime; errorString: TLabel): Boolean;
var
  selectedDayNumber: Integer;
begin
  if (student = '') then begin
    errorString.Visible := True;
    errorString.Caption := 'Укажите ученика!';
    journalActionControllerCheckOnError := True;
    Exit;
  end;

  if ((mark = '') AND NOT (action = 'delete')) then begin
    errorString.Visible := True;
    errorString.Caption := 'Укажите оценку!';
    journalActionControllerCheckOnError := True;
    Exit;
  end;

  selectedDayNumber := dayofweek(date) - 1;

  if (NOT checkValueInArray(arrayDaysOfWeek, selectedDayNumber)) then begin
    errorString.Visible := True;
    errorString.Caption := 'Неверная дата!';
    journalActionControllerCheckOnError := True;
    Exit;
  end;

  journalActionControllerCheckOnError := False;
end;

procedure TForm1.journalOnCellClick(Column: TColumn);
var
  colName: String;
  fmt: TFormatSettings;
begin
  selectStudent.KeyValue := DBGrid1.Fields[0].AsString;
  selectMark.KeyValue := DBGrid1.Fields[Column.Index].AsString;

  colName := Column.DisplayName;
  fmt.ShortDateFormat  := 'dd_mm_yyyy';
  fmt.DateSeparator   := '_';
  if NOT (colName = 'fullname') then begin
    selectDate.Date := StrToDate(colName, fmt);
  end;

end;

procedure TForm1.Main2Click(Sender: TObject);
begin
  Form3.Show();
end;

procedure TForm1.journalActionController(action: String; subjectId, groupId: Integer; studentComboBox, markComboBox: TDBLookupComboBox);
var
  markId, studentID, len, selectedDayNumber, i: Integer;
  dateIsCorrect: Boolean;
  student, mark: String;
  date: TDateTime;
begin
  date := selectDate.Date;
  student := studentComboBox.KeyValue;
  mark := markComboBox.KeyValue;

  if (journalActionControllerCheckOnError(action, student, mark, date, errorLabel) = true) then begin
    Exit;
  end;

  studentId := getStudentId(student);
  markId := getMarkId(mark);

  case StrUtils.IndexStr(action, ['add', 'update', 'delete']) of
    0: addRecordInJournal(studentID, subjectId, markID, date);
    1: updateRecordInJournal(studentID, subjectId, markID, date);
    2: deleteRecordFromJournal(studentID, subjectId, date);
  end;

  showMainTable(groupId, subjectId);

  studentComboBox.KeyValue := '';
  markComboBox.KeyValue := '';
end;

procedure TForm1.buttonAddClick(Sender: TObject);
begin
  journalActionController('add', subjectId, groupId, selectStudent, selectMark)
end;

procedure TForm1.buttonChangeClick(Sender: TObject);
begin
  journalActionController('update', subjectId, groupId, selectStudent, selectMark)
end;

procedure TForm1.buttonDeleteClick(Sender: TObject);
begin
  journalActionController('delete', subjectId, groupId, selectStudent, selectMark)
end;

procedure TForm1.DateTimePicker1OnChange(Sender: TObject);
begin
  errorLabel.Visible := False;
end;

procedure TForm1.FormActivate(Sender: TObject);
begin
  updateGrid();
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  NullStrictConvert := False;
  groupId := 1;
  subjectId := 1;
end;

end.
