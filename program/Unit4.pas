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
    Subject: TLabel;
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
  DataModule1.ADOQueryTimetable.Close;
  DataModule1.ADOQueryTimetable.SQL.Text :=
  'SELECT name ' +
  'FROM Subjects ' +
  'WHERE teacher_id = ' + IntToStr(teacherId) + ';';
  DataModule1.ADOQueryTimetable.Open;

  getSubjectNameFromTeacherId := DataModule1.DataSourceTimetable.DataSet.Fields[0].AsString;
end;

function TTimetable.getGroupNameFromStudentId(studentId: Integer): String;
begin
  DataModule1.ADOQueryTimetable.Close;
  DataModule1.ADOQueryTimetable.SQL.Text :=
  'SELECT g.name ' +
  'FROM Users AS u ' +
  'INNER JOIN Groups AS g ON g.id = u.group_id ' +
  'WHERE u.id = ' + IntToStr(studentId) + ';';
  DataModule1.ADOQueryTimetable.Open;

  getGroupNameFromStudentId := DataModule1.DataSourceTimetable.DataSet.Fields[0].AsString;
end;

procedure TTimetable.FormActivate(Sender: TObject);
begin
  Button1.Visible := True;
  Button2.Visible := True;
  Button3.Visible := True;
  currentType := 'all';

  selectGroup.Visible := True;
  selectSubject.Visible := True;

  selectGroup.Enabled := True;
  selectSubject.Enabled := True;

  Group.Visible := True;
  Subject.Visible := True;

  selectGroup.KeyValue := DataModule1.ADOTableGroups.FieldByName('name').AsString;
  selectSubject.KeyValue := DataModule1.ADOQuerySubjectsShow.FieldByName('name').AsString;

  groupName := selectGroup.KeyValue;
  subjectName := selectSubject.KeyValue;

  if (Authorization.userType = 'teacher') then begin
    selectSubject.KeyValue := getSubjectNameFromTeacherId(Authorization.userID);
    subjectName := selectSubject.KeyValue;
    selectGroup.Visible := False;
    Group.Visible := False;
    selectSubject.Enabled := False;
    Button1.Visible := False;
    Button2.Visible := False;
    Button3.Visible := False;
    currentType := 'subject';
  end;

  if (Authorization.userType = 'student') then begin
    selectGroup.KeyValue := getGroupNameFromStudentId(Authorization.userID);
    groupName := selectGroup.KeyValue;
    selectGroup.Enabled := False;
    selectSubject.Visible := False;
    Subject.Visible := False;
    Button1.Visible := False;
    Button2.Visible := False;
    Button3.Visible := False;
    currentType := 'group';
  end;

  showTable(currentType);
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
