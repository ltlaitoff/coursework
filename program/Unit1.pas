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
  firstShow: Boolean;

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

procedure TMain.doQueryDaysOfWeek(groupId, subjectId: Integer);
begin
  DataModule1.ADOQueryTimetableGet.Close;
  DataModule1.ADOQueryTimetableGet.SQL.Text :=
    'SELECT day_of_week '
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

  if firstShow = False then begin
    currentMounth := -1;
    ComboBox1.Clear;
    fillDatesComboBox();

    firstShow := True;
  end;

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

procedure TMain.Users1Click(Sender: TObject);
begin
  Users.Show();
end;

procedure TMain.TeachersTabClick(Sender: TObject);
begin
  Teachers.Show();
end;

procedure TMain.Groups1Click(Sender: TObject);
begin
  Groups.Show();
end;

procedure TMain.timetable1Click(Sender: TObject);
begin
  Timetable.Show();
end;

procedure TMain.Main2Click(Sender: TObject);
begin
  Subjects.Show();
end;

end.
