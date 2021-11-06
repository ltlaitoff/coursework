﻿unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Tabs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ExtCtrls;

type
  TForm1 = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    Label1: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    DBGrid1: TDBGrid;
    Button1: TButton;
    DBLookupComboBox1: TDBLookupComboBox;
    DBLookupComboBox2: TDBLookupComboBox;
    DBLookupComboBox3: TDBLookupComboBox;
    Button2: TButton;
    DBLookupComboBox4: TDBLookupComboBox;
    DateTimePicker1: TDateTimePicker;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Panel1: TPanel;
    Button3: TButton;
    Button4: TButton;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure DateTimePicker1OnChange(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);

    procedure showMainTable();
    procedure getGroupId();
    procedure getSubjectId();
    procedure doQueryDaysOfWeek();
    procedure updateArrayDaysOfWeek();
    procedure updateStringDaysOfWeek();
    function getMarkId(markName: String): Integer;
    function getStudentId(studentSurname: String): Integer;
    procedure addRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
    procedure updateRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
    procedure journalActionController(action: String; studentComboBox, markComboBox: TDBLookupComboBox);
    function journalActionControllerCheckOnError(student, mark: String; date: TDateTime; errorString: TLabel): Boolean;
    function checkValueInArray(arr: array of Integer; value: Integer): Boolean;
    procedure FormCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  group_id, subject_id: Integer;
  timetableDaysOfWeek: array of Integer;

implementation

{$R *.dfm}
{$APPTYPE CONSOLE}

uses Unit2, StrUtils;

procedure TForm1.showMainTable();
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'TRANSFORM Max(j.mark_id) AS [Max-mark_id] '
  + 'SELECT u.surname AS fullname '
  + 'FROM '
  + '  ( '
  + '    SELECT * '
  + '    FROM Journal '
  + '    WHERE Journal.subject_id = ' + IntToStr(subject_id) + ' '
  + '  ) AS j '
  + '  RIGHT JOIN ( '
  + '    SELECT '
  + '      Users.id AS id, '
  + '      Users.surname as surname, '
  + '      Users.name AS name, '
  + '      Users.patronymic AS patronymic '
  + '    FROM Users '
  + '    INNER JOIN Groups ON Users.group_id = Groups.id '
  + '    WHERE Groups.id = ' + IntToStr(group_id) + ' '
  + '    ORDER BY Users.id '
  + '  ) AS u ON j.user_id = u.id '
  + 'GROUP BY u.surname  '
  + 'PIVOT j.date; ';
  DataModule1.ADOQueryMain.Open;

  DBGrid1.Columns[1].Visible := false;
end;

procedure TForm1.getGroupId();
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT * ' +
  'FROM Groups ' +
  'WHERE name LIKE "' + DBLookupComboBox1.KeyValue + '"';
  DataModule1.ADOQueryMain.Open;

  group_id := DataModule1.DataSourceMain.DataSet.Fields[0].AsInteger;
end;

procedure TForm1.getSubjectId();
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT * ' +
  'FROM Subjects ' +
  'WHERE name LIKE "' + DBLookupComboBox2.KeyValue + '"';
  DataModule1.ADOQueryMain.Open;

  subject_id := DataModule1.DataSourceMain.DataSet.Fields[0].AsInteger;
end;

procedure TForm1.doQueryDaysOfWeek();
begin
  DataModule1.ADOQueryTimetableGet.Close;
  DataModule1.ADOQueryTimetableGet.SQL.Text :=
    'SELECT  day_of_week '
  + 'FROM Timetable '
  + 'WHERE (group_id = ' + IntToStr(group_id) + ') AND '
  + '(subject_id = ' + IntToStr(subject_id) + ')';
  DataModule1.ADOQueryTimetableGet.Open;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
  NullStrictConvert := False;
end;

procedure TForm1.updateArrayDaysOfWeek();
var
  len, i: Integer;
begin
  doQueryDaysOfWeek();

  len := DataModule1.DataSourceTimetableGet.DataSet.RecordCount;
  SetLength(timetableDaysOfWeek, len);

  DataModule1.DataSourceTimetableGet.DataSet.First();

  while not DataModule1.DataSourceTimetableGet.DataSet.Eof do begin
    for i := 0 to len - 1 do
    begin
      timetableDaysOfWeek[i] := 
        DataModule1.DataSourceTimetableGet.DataSet.FieldByName('day_of_week').AsInteger;
      DataModule1.DataSourceTimetableGet.DataSet.Next();
    end;
  end;
end;

procedure TForm1.updateStringDaysOfWeek();
var
  len, i: Integer;
  result: String;
begin
  updateArrayDaysOfWeek();
  
  len := Length(timetableDaysOfWeek);
  result := '';

  for i := 0 to len - 1 do
  begin
    case(timetableDaysOfWeek[i]) of
      1: result := result + ' Понедельник';
      2: result := result + ' Вторник';
      3: result := result + ' Среда';
      4: result := result + ' Четверг';
      5: result := result + ' Пятница';
    end;
  end;

  Label6.Caption := result;
end;

procedure TForm1.Button1Click(Sender: TObject);
begin
  getGroupId();
  getSubjectId();
  showMainTable();
  updateStringDaysOfWeek();

  DataModule1.ADOQueryStudentsFromGroup.Close;
  DataModule1.ADOQueryStudentsFromGroup.SQL.Text :=
  'SELECT '
  + 'Users.id AS id, '
  + 'Users.surname as surname, '
  + 'Users.name AS name, '
  + 'Users.patronymic AS patronymic '
  + 'FROM Users '
  + 'INNER JOIN Groups ON Users.group_id = Groups.id '
  + 'WHERE Groups.id = ' + IntToStr(group_id) + ' '
  + 'ORDER BY Users.id ';
  DataModule1.ADOQueryStudentsFromGroup.Open;
end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Panel1.Visible := true;
  DBLookupComboBox3.KeyValue := DBGrid1.Fields[0].AsString;
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

function TForm1.checkValueInArray(arr: array of Integer; value: Integer): Boolean;
var
  len, i: Integer;
begin
  len := Length(arr);

  for i := 0 to len do begin
    if (arr[i] = value) then begin
      checkValueInArray := true;
    end;
  end;

  checkValueInArray := false;
end;

function TForm1.journalActionControllerCheckOnError(student, mark: String; date: TDateTime; errorString: TLabel): Boolean;
var
  selectedDayNumber: Integer;
begin
  if (student = '') then begin
    errorString.Visible := True;
    errorString.Caption := 'Укажите ученика!';
    journalActionControllerCheckOnError := True;
    Exit;
  end;

  if (mark = '') then begin
    errorString.Visible := True;
    errorString.Caption := 'Укажите оценку!';
    journalActionControllerCheckOnError := True;
    Exit;
  end;

  selectedDayNumber := dayofweek(date) - 1;

  if (NOT checkValueInArray(timetableDaysOfWeek, selectedDayNumber)) then begin
    errorString.Visible := True;
    errorString.Caption := 'Неверная дата!';
    journalActionControllerCheckOnError := True;
    Exit;
  end;

  journalActionControllerCheckOnError := False;
end;

procedure TForm1.journalActionController(action: String; studentComboBox, markComboBox: TDBLookupComboBox);
var
  markId, studentID, len, selectedDayNumber, i: Integer;
  dateIsCorrect: Boolean;
  student, mark: String;
  date: TDateTime;
begin
  date := DateTimePicker1.Date;
  student := studentComboBox.KeyValue;
  mark := markComboBox.KeyValue;

  if (journalActionControllerCheckOnError(student, mark, date, Label5) = true) then begin
    Exit;
  end;

  studentId := getStudentId(student);
  markId := getMarkId(mark);

  case StrUtils.IndexStr(action, ['add', 'update', 'delete']) of
    0: addRecordInJournal(studentID, subject_id, markID, date);
    1: updateRecordInJournal(studentID, subject_id, markID, date);
  end;
  
  showMainTable();

  studentComboBox.KeyValue := '';
  markComboBox.KeyValue := '';
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
  journalActionController('add', DBLookupComboBox3, DBLookupComboBox4)
end;

procedure TForm1.Button4Click(Sender: TObject);
begin
  journalActionController('update', DBLookupComboBox3, DBLookupComboBox4)
end;

procedure TForm1.DateTimePicker1OnChange(Sender: TObject);
begin
  Label5.Visible := False;
end;

end.
