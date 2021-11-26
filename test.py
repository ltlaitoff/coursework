unit Unit1;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ComCtrls, Vcl.Tabs, Data.DB,
  Vcl.Grids, Vcl.DBGrids, Vcl.StdCtrls, Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Menus;

type
  TMain = class(TForm)
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
    timetable1: TMenuItem;
    Groups1: TMenuItem;
    Users1: TMenuItem;
    TeachersTab: TMenuItem;
    ExitTab: TMenuItem;
    ComboBox1: TComboBox;
    Panel2: TPanel;
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
    procedure timetable1Click(Sender: TObject);
    procedure Groups1Click(Sender: TObject);
    procedure Users1Click(Sender: TObject);
    procedure TeachersTabClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ExitTabClick(Sender: TObject);
    function getSubjectNameFromTeacherId(teacherId: Integer): String;
    function getGroupNameFromStudentId(studentId: Integer): String;
    procedure fillDatesComboBox();
    function getMounthNameFromId(id: Integer): String;
    function getMounthIdFromName(name: String): Integer;
    procedure updateDatesComboBox();
    procedure ComboBox1Click(Sender: TObject);
    procedure createDataSelectRequest();
    function getSurname(fullName: String): String;
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
    function checkRecordInDataBase(studentID, subjectID: Integer; date: TDateTime): Integer;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  CURRENT_SEMESTER = 1;
  CURRENT_YEAR = 2021;
  MOUNTH_COUNT = 5;
var
  Main: TMain;
  groupId, subjectId: Integer;
  arrayDaysOfWeek: array of Integer;
  currentMounth: Integer;
  mounthArr: array[1..MOUNTH_COUNT] of String;
  selectDates: String;

implementation

{$R *.dfm}

uses Unit2, StrUtils, DateUtils, Unit3, Unit4, Unit5, Unit6, Unit7, Unit9;

procedure TMain.selectGroupClick(Sender: TObject);
begin
  updateGrid();
end;

procedure TMain.selectSubjectClick(Sender: TObject);
begin
  updateGrid();
end;

procedure TMain.showMainTable(groupId, subjectId: Integer);
var
  firstDate, endDate, text: String;
  i: Integer;
begin
  firstDate := '1.' + IntToStr(currentMounth) + '.' + IntToStr(CURRENT_YEAR);
  endDate := IntToStr(DaysInAMonth(CURRENT_YEAR, currentMounth)) + '.' + IntToStr(currentMounth) + '.' + IntToStr(CURRENT_YEAR);

  text :=
  'TRANSFORM Max(m.mark) AS [Max-mark_id] '
  + 'SELECT t.fullname '
  + 'FROM (SELECT testing1.fullname, IIf(testing1.date = testing3.firs, testing1.mark_id, Null) AS mark_id, testing3.firs '
  + '  FROM ( '
  + '    SELECT (u.surname & " " & u.name) AS fullname, j.mark_id, j.date '
  + '    FROM  '
  + '      ( '
  + '        SELECT * '
  + '        FROM Journal '
  + '        WHERE ( '
  + '          Journal.subject_id = ' + IntToStr(subjectId) + ' AND  '
  + '          Journal.date BETWEEN DateValue("' + firstDate + '") AND DateValue("' + endDate + '") '
  + '        ) '
  + '      ) AS j  '
  + '    RIGHT JOIN ( '
  + '      SELECT '
  + '        Users.id AS id, '
  + '        Users.surname as surname, '
  + '        Users.name AS name, '
  + '        Users.patronymic AS patronymic '
  + '      FROM Users '
  + '      INNER JOIN Groups ON Users.group_id = Groups.id '
  + '      WHERE Groups.id = ' + IntToStr(groupId) + ' '
  + '      ORDER BY Users.id '
  + '    ) AS u ON j.user_id = u.id) AS testing1,  '
  + '    ( '
  + '      SELECT dates.firs '
  + '      FROM '
  + '        ( '
  + '          SELECT Timetable.day_of_week '
  + '          FROM Timetable, Subjects, Groups '
  + '          WHERE ( '
  + '            Subjects.id = Timetable.subject_id AND '
  + '            Groups.id = Timetable.group_id AND  '
  + '            Subjects.id = ' + IntToStr(subjectId) + ' AND '
  + '            Groups.id = ' + IntToStr(groupId) + ' '
  + '        )) AS Timetable_get_group_subject, '
  + '        (' + selectDates + ') AS dates '
  + '  WHERE '
  + '    Timetable_get_group_subject.day_of_week = ( Weekday(dates.firs) - 1 ) '
  + '  ORDER BY '
  + '    dates.firs '
  + '  ) AS testing3 '
  + ') AS t '
  + 'LEFT JOIN Marks AS m ON t.mark_id = m.id '
  + 'GROUP BY t.fullname '
  + 'PIVOT DAY(t.firs)';

  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text := text;
  DataModule1.ADOQueryMain.Open;

  for i := 0 to DbGrid1.Columns.Count - 1 do begin
    DBGrid1.Columns[i].Width := 25;
  end;

  DBGrid1.Columns[0].Width := 200;
end;

procedure TMain.TeachersTabClick(Sender: TObject);
begin
  Teachers.Show();
end;

function TMain.getGroupId(groupName: String): Integer;
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT * ' +
  'FROM Groups ' +
  'WHERE name LIKE "' + groupName + '"';
  DataModule1.ADOQueryMain.Open;

  getGroupId := DataModule1.DataSourceMain.DataSet.Fields[0].AsInteger;
end;

function TMain.getSubjectId(subjectName: String): Integer;
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT * ' +
  'FROM Subjects ' +
  'WHERE name LIKE "' + subjectName + '"';
  DataModule1.ADOQueryMain.Open;

  getSubjectId := DataModule1.DataSourceMain.DataSet.Fields[0].AsInteger;
end;

function TMain.getSubjectNameFromTeacherId(teacherId: Integer): String;
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT name ' +
  'FROM Subjects ' +
  'WHERE teacher_id = ' + IntToStr(teacherId) + ';';
  DataModule1.ADOQueryMain.Open;

  getSubjectNameFromTeacherId := DataModule1.DataSourceMain.DataSet.Fields[0].AsString;
end;

function TMain.getGroupNameFromStudentId(studentId: Integer): String;
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT g.name ' +
  'FROM Users AS u ' +
  'INNER JOIN Groups AS g ON g.id = u.group_id ' +
  'WHERE u.id = ' + IntToStr(studentId) + ';';
  DataModule1.ADOQueryMain.Open;

  getGroupNameFromStudentId := DataModule1.DataSourceMain.DataSet.Fields[0].AsString;
end;

procedure TMain.Groups1Click(Sender: TObject);
begin
  Groups.Show();
end;

procedure TMain.timetable1Click(Sender: TObject);
begin
  Timetable.Show();
end;

procedure TMain.doQueryDaysOfWeek(groupId, subjectId: Integer);
begin
  DataModule1.ADOQueryTimetableGet.Close;
  DataModule1.ADOQueryTimetableGet.SQL.Text :=
    'SELECT  day_of_week '
  + 'FROM Timetable '
  + 'WHERE (group_id = ' + IntToStr(groupId) + ') AND '
  + '(subject_id = ' + IntToStr(subjectId) + ')';
  DataModule1.ADOQueryTimetableGet.Open;
end;

procedure TMain.updateArrayDaysOfWeek(groupId, subjectId: Integer);
var
  len, i: Integer;
begin
  doQueryDaysOfWeek(groupId, subjectId);

  len := DataModule1.DataSourceTimetableGet.DataSet.RecordCount;
  SetLength(arrayDaysOfWeek, len);

  DataModule1.DataSourceTimetableGet.DataSet.First();

  while not DataModule1.DataSourceTimetableGet.DataSet.Eof do begin
    for i := 0 to len - 1 do
    begin
      arrayDaysOfWeek[i] :=
        DataModule1.DataSourceTimetableGet.DataSet.FieldByName('day_of_week').AsInteger;

      DataModule1.DataSourceTimetableGet.DataSet.Next();
    end;
  end;
end;

procedure TMain.updateStringDaysOfWeek(groupId, subjectId: Integer);
var
  len, i: Integer;
  result: String;
begin
  updateArrayDaysOfWeek(groupId, subjectId);

  len := Length(arrayDaysOfWeek);
  result := '';

  for i := 0 to len - 1do
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

procedure TMain.Users1Click(Sender: TObject);
begin
  Users.Show();
end;

procedure TMain.doQueryStudentsFromGroup(groupId: Integer);
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

procedure TMain.ExitTabClick(Sender: TObject);
begin
  Authorization.Show();
  Authorization.Close();
end;

procedure TMain.updateGrid();
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

procedure TMain.openPanelClick(Sender: TObject);
begin
  errorLabel.Visible := False;
  Panel1.Visible := NOT Panel1.Visible;
  selectStudent.KeyValue := '';
end;

function TMain.getMarkId(markName: String): Integer;
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'SELECT * '    +
  'FROM Marks ' +
  'WHERE mark LIKE "' + markName + '"';
  DataModule1.ADOQueryAddMarks.Open;

  getMarkId := DataModule1.DataSourceAddMarks.DataSet.Fields[0].AsInteger;
end;

function TMain.getStudentId(studentSurname: String): Integer;
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'SELECT id '    +
  'FROM Users ' +
  'WHERE surname = "' + studentSurname + '"';
  DataModule1.ADOQueryAddMarks.Open;

  getStudentId := DataModule1.DataSourceAddMarks.DataSet.Fields[0].AsInteger;
end;

procedure TMain.addRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'INSERT INTO Journal (user_id, subject_id, mark_id, [date]) '   +
  'VALUES (' + IntToStr(studentID) + ', ' + IntToStr(subjectID) +
  ', ' +  IntToStr(markID)
  + ', DateValue("' + DateTimeToStr(date) + '"))';

  DataModule1.ADOQueryAddMarks.ExecSQL;
end;

procedure TMain.updateRecordInJournal(studentID, subjectID, markID: Integer; date: TDateTime);
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

procedure TMain.deleteRecordFromJournal(studentID, subjectID: Integer; date: TDateTime);
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

function TMain.checkValueInArray(arr: array of Integer; value: Integer): Boolean;
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

function TMain.journalActionControllerCheckOnError(action, student, mark: String; date: TDateTime; errorString: TLabel): Boolean;
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

function TMain.getSurname(fullName: String): String;
var
  position: Integer;
begin
  position := Pos(' ', fullName);
  getSurname := Copy(fullName, 0, position);
end;

procedure TMain.journalOnCellClick(Column: TColumn);
var
  colName, selectedDateText, str, surname: String;
  position: Integer;
begin
  selectStudent.KeyValue := getSurname(DBGrid1.Fields[0].AsString);

  selectMark.KeyValue := DBGrid1.Fields[Column.Index].AsString;

  colName := Column.DisplayName;
  selectedDateText := colName + '.' + IntToStr(currentMounth) + '.' + IntToStr(CURRENT_YEAR);

  if NOT (colName = 'fullname') then begin
    selectDate.Date := StrToDate(selectedDateText);
  end;

end;

procedure TMain.Main2Click(Sender: TObject);
begin
  Subjects.Show();
end;

function TMain.checkRecordInDataBase(studentID, subjectID: Integer; date: TDateTime): Integer;
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'SELECT * ' +
  'FROM Journal ' +
  'WHERE ' +
  ' user_id = ' + IntToStr(studentID) + ' AND ' +
  ' subject_id = ' + IntToStr(subjectID) + ' AND ' +
  'date = DateValue("' + DateTimeToStr(date) + '"); ';
  DataModule1.ADOQueryAddMarks.Open;

  checkRecordInDataBase := DataModule1.DataSourceAddMarks.DataSet.Fields[0].AsInteger;
end;

procedure TMain.journalActionController(action: String; subjectId, groupId: Integer; studentComboBox, markComboBox: TDBLookupComboBox);
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

  if ((action = 'add') AND (checkRecordInDataBase(studentID, subjectId, date) <> 0)) then begin
    action := 'update';
  end;

  case StrUtils.IndexStr(action, ['add', 'update', 'delete']) of
    0: addRecordInJournal(studentID, subjectId, markID, date);
    1: updateRecordInJournal(studentID, subjectId, markID, date);
    2: deleteRecordFromJournal(studentID, subjectId, date);
  end;

  showMainTable(groupId, subjectId);

  studentComboBox.KeyValue := '';
  markComboBox.KeyValue := '';
end;

procedure TMain.buttonAddClick(Sender: TObject);
begin
  journalActionController('add', subjectId, groupId, selectStudent, selectMark)
end;

procedure TMain.buttonChangeClick(Sender: TObject);
begin
  journalActionController('update', subjectId, groupId, selectStudent, selectMark)
end;

procedure TMain.buttonDeleteClick(Sender: TObject);
begin
  journalActionController('delete', subjectId, groupId, selectStudent, selectMark)
end;

procedure TMain.DateTimePicker1OnChange(Sender: TObject);
begin
  errorLabel.Visible := False;
end;

procedure TMain.FormActivate(Sender: TObject);
begin
  errorLabel.Visible := False;
  ComboBox1.Clear;
  currentMounth := -1;
  Groups1.Visible := True;
  Panel1.Visible := False;

  if (Authorization.userType = 'teacher') then begin
    selectSubject.KeyValue := getSubjectNameFromTeacherId(Authorization.userID);
    selectSubject.Enabled := False;
    Groups1.Visible := False;
  end;

  if (Authorization.userType = 'student') then begin
    selectGroup.KeyValue := getGroupNameFromStudentId(Authorization.userID);
    selectGroup.Enabled := False;
    openPanel.Enabled := False;
    Groups1.Visible := False;
  end;

  fillDatesComboBox();
  updateGrid();
end;

procedure TMain.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  Authorization.Show();
  selectSubject.Enabled := True;
  selectGroup.Enabled := True;
  openPanel.Enabled := True;
end;

procedure TMain.FormCreate(Sender: TObject);
begin
  NullStrictConvert := False;
  groupId := 1;
  subjectId := 1;
end;

procedure TMain.FormMouseWheel(Sender: TObject; Shift: TShiftState;
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

  If selectSubject.Focused then begin
    If (WheelDelta < 0) then begin
      selectSubject.Perform(WM_KEYDOWN, VK_DOWN, 0)
    end
    else begin
      selectSubject.Perform(WM_KEYDOWN, VK_UP, 0);
    end;
  end;

  If selectStudent.Focused then begin
    If (WheelDelta < 0) then begin
      selectStudent.Perform(WM_KEYDOWN, VK_DOWN, 0)
    end
    else begin
      selectStudent.Perform(WM_KEYDOWN, VK_UP, 0);
    end;
  end;

  If selectMark.Focused then begin
    If (WheelDelta < 0) then begin
      selectMark.Perform(WM_KEYDOWN, VK_DOWN, 0)
    end
    else begin
      selectMark.Perform(WM_KEYDOWN, VK_UP, 0);
    end;
  end;

  Handled := True;
end;

function TMain.getMounthNameFromId(id: Integer): String;
const months: Array [1..12] of String = ('Январь', 'Февраль', 'Март', 'Апрель',
  'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь');
begin
  if ((id < 1) OR (id > 12)) then begin
    ShowMessage('getMounthNameFromId ID error');
    Exit;
  end;
  getMounthNameFromId := months[id];
end;

function TMain.getMounthIdFromName(name: String): Integer;
const months: Array [1..12] of String = ('Январь', 'Февраль', 'Март', 'Апрель',
  'Май', 'Июнь', 'Июль', 'Август', 'Сентябрь', 'Октябрь', 'Ноябрь', 'Декабрь');
begin
  getMounthIdFromName := StrUtils.IndexStr(name, months) + 1;
end;

procedure TMain.createDataSelectRequest();
var
  len, i: Integer;
  resultStr: String;
begin
  len := DaysInAMonth(CURRENT_YEAR, currentMounth);
  resultStr := '';

  for i := 1 to len do begin
    resultStr := resultStr + 'SELECT DateValue("'+ IntToStr(i) + '.' + IntToStr(currentMounth) + '.' + IntToStr(CURRENT_YEAR) + '") AS firs FROM Teachers';
    if (i <> len) then begin
      resultStr := resultStr + ' UNION ';
    end;
  end;

  selectDates := resultStr;
end;

procedure TMain.fillDatesComboBox();
var
  i: Integer;
begin
  if (CURRENT_SEMESTER = 1) then begin
    currentMounth := 9;
    ComboBox1.Items.Add(getMounthNameFromId(currentMounth));
    ComboBox1.Items.Add(getMounthNameFromId(10));
    ComboBox1.Items.Add(getMounthNameFromId(11));
    ComboBox1.Items.Add(getMounthNameFromId(12));
    ComboBox1.Items.Add(getMounthNameFromId(1));
  end
  else
  if (CURRENT_SEMESTER = 2) then begin
    currentMounth := 2;
    ComboBox1.Items.Add(getMounthNameFromId(currentMounth));
    ComboBox1.Items.Add(getMounthNameFromId(3));
    ComboBox1.Items.Add(getMounthNameFromId(4));
    ComboBox1.Items.Add(getMounthNameFromId(5));
    ComboBox1.Items.Add(getMounthNameFromId(6));
  end;

  updateDatesComboBox();
end;

procedure TMain.updateDatesComboBox();
begin
  ComboBox1.Text := getMounthNameFromId(currentMounth);
  createDataSelectRequest();
end;

procedure TMain.ComboBox1Click(Sender: TObject);
begin
  currentMounth := getMounthIdFromName(ComboBox1.Text);

  createDataSelectRequest();

  showMainTable(groupId, subjectId);
end;

end.


UNIT 2
unit Unit2;

interface

uses
  System.SysUtils, System.Classes, Data.DB, Data.Win.ADODB;

type
  TDataModule1 = class(TDataModule)
    ADOConnection: TADOConnection;
    ADOQueryMain: TADOQuery;
    DataSourceMain: TDataSource;
    ADOTableGroups: TADOTable;
    ADOTableSubjects: TADOTable;
    DataSourceTableGroups: TDataSource;
    DataSourceTableSubjects: TDataSource;
    ADOQueryStudentsFromGroup: TADOQuery;
    DataSourceStudentFromGroup: TDataSource;
    ADOQueryAddMarks: TADOQuery;
    DataSourceAddMarks: TDataSource;
    ADOTableMarks: TADOTable;
    DataSourceTableMarks: TDataSource;
    ADOQueryTimetableGet: TADOQuery;
    DataSourceTimetableGet: TDataSource;
    ADOQuerySubjects: TADOQuery;
    DataSourceSubjects: TDataSource;
    ADOTableTeachers: TADOTable;
    DataSourceTableTeachers: TDataSource;
    ADOQuerySubjectsShow: TADOQuery;
    DataSourceSubjectsShow: TDataSource;
    ADOQueryTimetable: TADOQuery;
    DataSourceTimetable: TDataSource;
    ADOQueryTimetableShow: TADOQuery;
    DataSourceTimetableShow: TDataSource;
    ADOQueryTimetableShowdayofweek: TWideMemoField;
    ADOQueryTimetableShowpair: TIntegerField;
    ADOTableGroupsID: TAutoIncField;
    ADOTableGroupsname: TWideStringField;
    ADOQueryGroupsShow: TADOQuery;
    DataSourceGroupsShow: TDataSource;
    ADOQueryGroups: TADOQuery;
    DataSourceQueryGroups: TDataSource;
    ADOQueryUsersShow: TADOQuery;
    DataSourceUsersShow: TDataSource;
    ADOQueryUsers: TADOQuery;
    DataSourceUsers: TDataSource;
    ADOQueryUsersShowid: TAutoIncField;
    ADOQueryUsersShowGN: TWideStringField;
    ADOQueryUsersShowsurname: TWideStringField;
    ADOQueryUsersShowname: TWideStringField;
    ADOQueryUsersShowpatronymic: TWideStringField;
    ADOQueryUsersShowemail: TWideStringField;
    ADOQueryUsersShowusername: TWideStringField;
    ADOQueryUsersShowpassword: TWideStringField;
    ADOQueryTeachersShow: TADOQuery;
    DataSourceTeachersShow: TDataSource;
    ADOQueryTeachers: TADOQuery;
    DataSourceTeachers: TDataSource;
    ADOQueryAuthorization: TADOQuery;
    DataSourceAuthorization: TDataSource;
    ADOQuerySubjectsShowid: TAutoIncField;
    ADOQuerySubjectsShowname: TWideStringField;
    ADOQuerySubjectsShowaudience: TIntegerField;
    ADOQuerySubjectsShowteacher: TWideMemoField;
    ADOQueryTimetableShowgroup: TWideStringField;
    ADOQueryTimetableShowsubject: TWideStringField;
    ADOQueryTimetableShowaudience: TIntegerField;
    procedure getText(Sender: TField; var Text: string; DisplayText: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  DataModule1: TDataModule1;

implementation

{%CLASSGROUP 'Vcl.Controls.TControl'}

{$R *.dfm}

procedure TDataModule1.getText(Sender: TField; var Text: string; DisplayText: Boolean);
begin
  Text := Sender.AsString;
end;

end.


UNIT 3
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

procedure TSubjects.subjectsActionController(action: String; nameEdit, audienceEdit: TEdit;
  teacherComboBox: TDBLookupComboBox; errorString: TLabel; recordId: Integer);
var
  name, audience, teacher: String;
  teacherId: Integer;
begin
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


UNIT 4
unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.StdCtrls, Vcl.ExtCtrls;

type
  TTimetable = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Group: TLabel;
    Label2: TLabel;
    selectGroup: TDBLookupComboBox;
    selectSubject: TDBLookupComboBox;
    procedure selectGroupClick(Sender: TObject);
    procedure selectSubjectClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure showTable(commitType: String);
    function getGroupId(groupName: String): Integer;
    function getSubjectId(subjectName: String): Integer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    function getGroupNameFromStudentId(studentId: Integer): String;
    function getSubjectNameFromTeacherId(teacherId: Integer): String;
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Timetable: TTimetable;
  groupName, subjectName, currentType: String;

implementation

{$R *.dfm}

USES Unit2, StrUtils, Unit8, Unit9;

function TTimetable.getGroupId(groupName: String): Integer;
begin
  DataModule1.ADOQueryTimetable.Close;
  DataModule1.ADOQueryTimetable.SQL.Text :=
  'SELECT * ' +
  'FROM Groups ' +
  'WHERE name LIKE "' + groupName + '"';
  DataModule1.ADOQueryTimetable.Open;

  getGroupId := DataModule1.DataSourceTimetable.DataSet.Fields[0].AsInteger;
end;

function TTimetable.getSubjectId(subjectName: String): Integer;
begin
  DataModule1.ADOQueryTimetable.Close;
  DataModule1.ADOQueryTimetable.SQL.Text :=
  'SELECT * ' +
  'FROM Subjects ' +
  'WHERE name LIKE "' + subjectName + '"';
  DataModule1.ADOQueryTimetable.Open;

  getSubjectId := DataModule1.DataSourceTimetable.DataSet.Fields[0].AsInteger;
end;

procedure TTimetable.showTable(commitType: String);
var
  group, subject: String;
begin
  group := 'group_id';
  subject := 'subject_id';

  case StrUtils.IndexStr(commitType, ['all', 'group', 'subject']) of
    1: group := IntToStr(getGroupId(groupName));
    2: subject := IntToStr(getSubjectId(subjectName));
  end;

  DataModule1.ADOQueryTimetableShow.Close;
  DataModule1.ADOQueryTimetableShow.SQL.Text :=
  'SELECT ' +
    'WeekdayName(t.day_of_week) AS [day of week], ' +
    't.pair AS [pair], ' +
    'g.name AS [group], ' +
    's.audience AS [audience], ' +
    's.name AS [subject]' +
  'FROM ' +
    'Timetable AS t, ' +
    'Subjects AS s, ' +
    'Groups AS g ' +
  'WHERE ' +
    '( ' +
      '(t.subject_id = s.id) AND ' +
      '(g.id = t.group_id) AND ' +
      '(t.subject_id = ' + subject + ') AND ' +
      '(t.group_id = ' + group + ') ' +
    ') ' +
  'ORDER BY ' +
    't.day_of_week, ' +
    'g.name, ' +
    't.pair;';
  DataModule1.ADOQueryTimetableShow.Open;
end;

procedure TTimetable.Button1Click(Sender: TObject);
begin
  showTable('all');
  currentType := 'all';
end;

procedure TTimetable.Button2Click(Sender: TObject);
begin
  showTable('group');
  currentType := 'group';
end;

procedure TTimetable.Button3Click(Sender: TObject);
begin
  showTable('subject');
  currentType := 'subject';
end;

procedure TTimetable.Button4Click(Sender: TObject);
begin
  TimeTableReport.QuickRep1.PreviewModal();
end;

function TTimetable.getSubjectNameFromTeacherId(teacherId: Integer): String;
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT name ' +
  'FROM Subjects ' +
  'WHERE teacher_id = ' + IntToStr(teacherId) + ';';
  DataModule1.ADOQueryMain.Open;

  getSubjectNameFromTeacherId := DataModule1.DataSourceMain.DataSet.Fields[0].AsString;
end;

function TTimetable.getGroupNameFromStudentId(studentId: Integer): String;
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT g.name ' +
  'FROM Users AS u ' +
  'INNER JOIN Groups AS g ON g.id = u.group_id ' +
  'WHERE u.id = ' + IntToStr(studentId) + ';';
  DataModule1.ADOQueryMain.Open;

  getGroupNameFromStudentId := DataModule1.DataSourceMain.DataSet.Fields[0].AsString;
end;

procedure TTimetable.FormActivate(Sender: TObject);
begin
  Button1.Visible := True;
  Button2.Visible := True;
  Button3.Visible := True;
  currentType := 'all';

  selectGroup.KeyValue := DataModule1.ADOTableGroups.FieldByName('name').AsString;
  selectSubject.KeyValue := DataModule1.ADOQuerySubjectsShow.FieldByName('name').AsString;

  groupName := selectGroup.KeyValue;
  subjectName := selectSubject.KeyValue;

  if (Authorization.userType = 'teacher') then begin
    selectSubject.KeyValue := getSubjectNameFromTeacherId(Authorization.userID);
    subjectName := selectSubject.KeyValue;
    selectSubject.Enabled := False;
    Button1.Visible := False;
    Button2.Visible := False;
    Button3.Visible := False;
    currentType := 'subject';
    showTable('subject');
  end;

  if (Authorization.userType = 'student') then begin
    selectGroup.KeyValue := getGroupNameFromStudentId(Authorization.userID);
    groupName := selectGroup.KeyValue;
    selectGroup.Enabled := False;
    Button1.Visible := False;
    Button2.Visible := False;
    Button3.Visible := False;
    currentType := 'group';
    showTable('group');
  end;
end;

procedure TTimetable.FormMouseWheel(Sender: TObject; Shift: TShiftState;
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

  If selectSubject.Focused then begin
    If (WheelDelta < 0) then begin
      selectSubject.Perform(WM_KEYDOWN, VK_DOWN, 0)
    end
    else begin
      selectSubject.Perform(WM_KEYDOWN, VK_UP, 0);
    end;
  end;

  Handled := True;
end;

procedure TTimetable.selectGroupClick(Sender: TObject);
begin
  groupName := selectGroup.KeyValue;
  showTable(currentType);
end;

procedure TTimetable.selectSubjectClick(Sender: TObject);
begin
  subjectName := selectSubject.KeyValue;
  showTable(currentType);
end;

end.


UNIT 5
unit Unit5;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Menus, Vcl.StdCtrls,
  Vcl.DBCtrls, Vcl.ExtCtrls, Vcl.Grids, Vcl.DBGrids;

type
  TGroups = class(TForm)
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    Label3: TLabel;
    errorLabel: TLabel;
    buttonAdd: TButton;
    buttonChange: TButton;
    buttonDelete: TButton;
    nameEdit: TEdit;
    openPanel: TButton;
    Panel2: TPanel;
    procedure showGroupsTable();
    procedure DBGrid1CellClick(Column: TColumn);
    procedure addRecordInGroups(name: String);
    procedure updateRecordInGroups(groupId: Integer; name: String);
    procedure deleteRecordFromGroups(groupId: Integer);
    procedure groupsActionController(action: String; nameEdit: TEdit; groupId: Integer; errorString: TLabel);
    function groupsActionControllerCheckOnError(action, name: String; errorString: TLabel): Boolean;
    procedure buttonAddClick(Sender: TObject);
    procedure buttonChangeClick(Sender: TObject);
    procedure buttonDeleteClick(Sender: TObject);
    procedure openPanelClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormMouseWheel(Sender: TObject; Shift: TShiftState;
      WheelDelta: Integer; MousePos: TPoint; var Handled: Boolean);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Groups: TGroups;
  groupId: Integer;

implementation

{$R *.dfm}

uses Unit2, StrUtils, Unit9;

procedure TGroups.showGroupsTable();
begin
  DataModule1.ADOQueryGroupsShow.Close;
  DataModule1.ADOQueryGroupsShow.SQL.Text :=
    'SELECT *' +
    'FROM Groups';
  DataModule1.ADOQueryGroupsShow.Open;
end;

procedure TGroups.DBGrid1CellClick(Column: TColumn);
begin
  groupId := DBGrid1.Fields[0].AsInteger;
  nameEdit.Text := DBGrid1.Fields[1].AsString;
end;

procedure TGroups.addRecordInGroups(name: String);
begin
  DataModule1.ADOQueryGroups.Close;
  DataModule1.ADOQueryGroups.SQL.Text :=
  'INSERT INTO Groups (name) ' +
  'VALUES ("' + name + '");';
  DataModule1.ADOQueryGroups.ExecSQL;
end;

procedure TGroups.updateRecordInGroups(groupId: Integer; name: String);
begin
  DataModule1.ADOQueryGroups.Close;
  DataModule1.ADOQueryGroups.SQL.Text :=
  'UPDATE Groups ' +
  'SET ' +
    'name = "' + name + '" ' +
  'WHERE '+
    'id = ' + IntToStr(groupId) + ';';
  DataModule1.ADOQueryGroups.ExecSQL;
end;

procedure TGroups.deleteRecordFromGroups(groupId: Integer);
begin
  DataModule1.ADOQueryGroups.Close;
  DataModule1.ADOQueryGroups.SQL.Text :=
  'DELETE ' +
  'FROM Groups ' +
  'WHERE ' +
    'id = ' + IntToStr(groupId);
  DataModule1.ADOQueryGroups.ExecSQL;
end;

function TGroups.groupsActionControllerCheckOnError(action, name: String; errorString: TLabel): Boolean;
var
  selectedDayNumber: Integer;
begin
  if ((name = '') AND NOT (action = 'delete')) then begin
    errorString.Visible := True;
    errorString.Caption := '������� ��������!';
    groupsActionControllerCheckOnError := True;
    Exit;
  end;

  groupsActionControllerCheckOnError := False;
end;

procedure TGroups.groupsActionController(action: String; nameEdit: TEdit; groupId: Integer; errorString: TLabel);
var
  name: String;
begin
  name := nameEdit.Text;

  if (groupsActionControllerCheckOnError(action, name, errorString) = true) then begin
    Exit;
  end;

  case StrUtils.IndexStr(action, ['add', 'update', 'delete']) of
    0: addRecordInGroups(name);
    1: updateRecordInGroups(groupId, name);
    2: deleteRecordFromGroups(groupId);
  end;

  showGroupsTable();

  nameEdit.Text := '';
end;

procedure TGroups.buttonAddClick(Sender: TObject);
begin
  groupsActionController('add', nameEdit, groupId, errorLabel);
end;

procedure TGroups.buttonChangeClick(Sender: TObject);
begin
  groupsActionController('update', nameEdit, groupId, errorLabel);
end;

procedure TGroups.buttonDeleteClick(Sender: TObject);
begin
  groupsActionController('delete', nameEdit, groupId, errorLabel);
end;

procedure TGroups.openPanelClick(Sender: TObject);
begin
  Panel1.Visible := NOT Panel1.Visible;
end;

procedure TGroups.FormActivate(Sender: TObject);
begin
  Panel1.Visible := False;
  openPanel.Enabled := True;

  if ((Authorization.userType = 'teacher') OR (Authorization.userType = 'student')) then begin
    openPanel.Enabled := False;
  end;

  groupId := DBGrid1.Fields[0].AsInteger;
  nameEdit.Text := DBGrid1.Fields[1].AsString;
end;

procedure TGroups.FormCreate(Sender: TObject);
begin
  NullStrictConvert := False;
end;


procedure TGroups.FormMouseWheel(Sender: TObject; Shift: TShiftState;
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

end.


UNIT 6
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
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT g.name ' +
  'FROM Users AS u ' +
  'INNER JOIN Groups AS g ON g.id = u.group_id ' +
  'WHERE u.id = ' + IntToStr(studentId) + ';';
  DataModule1.ADOQueryMain.Open;

  getGroupNameFromStudentId := DataModule1.DataSourceMain.DataSet.Fields[0].AsString;
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
    showErrorLabel('Ошибка ИД группы'); 
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


UNIT 7
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


UNIT 8
unit Unit8;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Vcl.ExtCtrls, QuickRpt, QRCtrls;

type
  TTimeTableReport = class(TForm)
    QuickRep1: TQuickRep;
    TitleBand1: TQRBand;
    ColumnHeaderBand1: TQRBand;
    DetailBand1: TQRBand;
    QRLabel1: TQRLabel;
    QRLabel2: TQRLabel;
    QRLabel3: TQRLabel;
    QRLabel4: TQRLabel;
    QRDBText1: TQRDBText;
    QRDBText2: TQRDBText;
    QRDBText4: TQRDBText;
    QRLabel5: TQRLabel;
    QRDBText3: TQRDBText;
    QRDBText5: TQRDBText;
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  TimeTableReport: TTimeTableReport;

implementation

{$R *.dfm}

uses Unit4, Unit2;

end.


UNIT 9
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
    procedure hideErrorLabel();
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

uses Unit1, Unit2, StrUtils;

procedure TAuthorization.showErrorLabel(text: String);
begin
  errorLabel.Visible := True;
  errorLabel.Caption := text;
end;

procedure TAuthorization.hideErrorLabel();
begin
  errorLabel.Visible := False;
  errorLabel.Caption := '';
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
  hideErrorLabel();
  InputQuery('Input login', 'Login: ', currentLogin);
  InputQuery('Input password', 'Password: ', currentPassword);

  if (authorizationControllerCheckOnError(action, currentLogin, currentPassword) = true) then begin
    Exit;
  end;

  case StrUtils.IndexStr(action, ['admin', 'teacher', 'student']) of
    0: begin
      if (currentLogin = ADMIN_LOGIN) AND (currentPassword = ADMIN_PASSWORD) then begin
        userType := 'admin';
        showMainForm();
        Exit;
      end;

      showErrorLabel('Вы ввели неверный логин или пароль');
      Exit;
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