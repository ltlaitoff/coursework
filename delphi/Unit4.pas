unit Unit4;

interface

uses
  Winapi.Windows, Winapi.Messages, System.SysUtils, System.Variants, System.Classes, Vcl.Graphics,
  Vcl.Controls, Vcl.Forms, Vcl.Dialogs, Data.DB, Vcl.Grids, Vcl.DBGrids,
  Vcl.DBCtrls, Vcl.StdCtrls;

type
  TTimetable = class(TForm)
    DBGrid1: TDBGrid;
    selectGroup: TDBLookupComboBox;
    selectSubject: TDBLookupComboBox;
    ������: TLabel;
    Label2: TLabel;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    procedure selectGroupClick(Sender: TObject);
    procedure selectSubjectClick(Sender: TObject);
    procedure FormActivate(Sender: TObject);
    procedure showTable(commitType: String);
    function getGroupId(groupName: String): Integer;
    function getSubjectId(subjectName: String): Integer;
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
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

USES Unit2, StrUtils;

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
    't.pair, ' +
    'g.name, ' +
    's.name ' +
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

procedure TTimetable.FormActivate(Sender: TObject);
begin
  selectGroup.KeyValue := DataModule1.ADOTableGroups.FieldByName('name').AsString;
  selectSubject.KeyValue := DataModule1.ADOQuerySubjectsShow.FieldByName('name').AsString;

  groupName := selectGroup.KeyValue;
  subjectName := selectSubject.KeyValue;

  currentType := 'all';
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
