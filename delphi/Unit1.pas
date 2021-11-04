unit Unit1;

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
    procedure setDaysLabel();
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//const

var
  Form1: TForm1;
  group_id, subject_id: Integer;
  timetableDaysOfWeek: array of Integer;

implementation

{$R *.dfm}
{$APPTYPE CONSOLE}

uses Unit2;

{
  TODO:
  [x] ��������� ���������� ������ ������ � ����,
      � ������� �������� ���������� ���� � ������ ������ �������� �����������
  [x] �������� ������� ������� ����� ���������� ���
  [x] ������ ������ �������
  [x] �������� ����������� ��������� ������ ��������

  [ ] �������� ����, ����� ��������� � ��������� ���������/�������
  [ ] ������ �� ������ - �������� � ����� ������������ ��� �����

  [ ] �������� ����������� �������� ������ � ��������
  [ ] ���������� ������� �� params
  [ ] ����������� ������ ���������� ������ � �������� ������
      � �������� �������(��� ����� ������ �������) ��� ��������������
  [ ] ����������� ���������� �������� � ��������
  [ ] ����������� ���������� ���������
  [ ] ����� ������� ��� �������� � ���������

  UX: � ������ ������

  ����:
  ���� �������� ��������� ������ �� 1 ���� ��������� ������ ����
}
procedure TForm1.Button1Click(Sender: TObject);
begin
  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT * ' +
  'FROM Groups ' +
  'WHERE name LIKE "' + DBLookupComboBox1.KeyValue + '"';
  DataModule1.ADOQueryMain.Open;

  group_id := DataModule1.DataSourceMain.DataSet.Fields[0].AsInteger;

  DataModule1.ADOQueryMain.Close;
  DataModule1.ADOQueryMain.SQL.Text :=
  'SELECT * ' +
  'FROM Subjects ' +
  'WHERE name LIKE "' + DBLookupComboBox2.KeyValue + '"';
  DataModule1.ADOQueryMain.Open;

  subject_id := DataModule1.DataSourceMain.DataSet.Fields[0].AsInteger;

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

  DataModule1.ADOQueryTimetableGet.Close;
  DataModule1.ADOQueryTimetableGet.SQL.Text :=
    'SELECT  day_of_week '
  + 'FROM Timetable '
  + 'WHERE (group_id = ' + IntToStr(group_id) + ') AND '
  + '(subject_id = ' + IntToStr(subject_id) + ')';
  DataModule1.ADOQueryTimetableGet.Open;

  SetLength(timetableDaysOfWeek, DataModule1.ADOQueryTimetableGet.RecordCount);
  DataModule1.ADOQueryTimetableGet.First();

  while not DataModule1.ADOQueryTimetableGet.Eof do begin
    for var i := 0 to DataModule1.ADOQueryTimetableGet.RecordCount - 1 do
    begin
      timetableDaysOfWeek[i] :=
        DataModule1.ADOQueryTimetableGet.FieldByName('day_of_week').AsInteger;
      DataModule1.ADOQueryTimetableGet.Next();
    end;
  end;

  setDaysLabel();
end;

procedure TForm1.setDaysLabel();
begin
  var len := Length(timetableDaysOfWeek);
  Label6.Caption := '';

  for var i := 0 to len do begin
    case(timetableDaysOfWeek[i]) of
      1: begin
        Label6.Caption := Label6.Caption + ' �����������';
        continue;
      end;

      2: begin
        Label6.Caption := Label6.Caption + ' �������';
        continue;
      end;

      3: begin
        Label6.Caption := Label6.Caption + ' �����';
        continue;
      end;

      4: begin
        Label6.Caption := Label6.Caption + ' �������';
        continue;
      end;

      5: begin
        Label6.Caption := Label6.Caption + ' �������';
        continue;
      end;
    end;
  end;

end;


procedure TForm1.Button2Click(Sender: TObject);
var
  mark_id, student_id: Integer;
  a: String;
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'SELECT * '    +
  'FROM Marks ' +
  'WHERE mark LIKE "' + DBLookupComboBox4.KeyValue + '"';
  DataModule1.ADOQueryAddMarks.Open;

  mark_id := DataModule1.DataSourceAddMarks.DataSet.Fields[0].AsInteger;

  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'SELECT id '    +
  'FROM Users ' +
  'WHERE surname LIKE "' + DBLookupComboBox3.KeyValue + '"';
  DataModule1.ADOQueryAddMarks.Open;

  student_id := DataModule1.DataSourceAddMarks.DataSet.Fields[0].AsInteger;

  DataModule1.ADOQueryTimetableGet.Close;
  DataModule1.ADOQueryTimetableGet.SQL.Text :=
    'SELECT  day_of_week '
  + 'FROM Timetable '
  + 'WHERE (group_id = ' + IntToStr(group_id) + ') AND '
  + '(subject_id = ' + IntToStr(subject_id) + ')';
  DataModule1.ADOQueryTimetableGet.Open;

  SetLength(timetableDaysOfWeek, DataModule1.ADOQueryTimetableGet.RecordCount);
  DataModule1.ADOQueryTimetableGet.First();

  while not DataModule1.ADOQueryTimetableGet.Eof do begin
    for var i := 0 to DataModule1.ADOQueryTimetableGet.RecordCount - 1 do
    begin
      timetableDaysOfWeek[i] :=
        DataModule1.ADOQueryTimetableGet.FieldByName('day_of_week').AsInteger;
      DataModule1.ADOQueryTimetableGet.Next();
    end;
  end;

  var len := Length(timetableDaysOfWeek);
  var insert_boolean := false;

  for var i := 0 to len do begin
    if (timetableDaysOfWeek[i] = dayofweek(DateTimePicker1.Date) - 1) then begin
      DataModule1.ADOQueryAddMarks.Close;
      DataModule1.ADOQueryAddMarks.SQL.Text :=
      'INSERT INTO Journal (user_id, subject_id, mark_id, [date]) '   +
      'VALUES (' + IntToStr(student_id) + ', ' + IntToStr(subject_id) +
      ', ' +  IntToStr(mark_id)
      + ', DateValue("' + DateTimeToStr(DateTimePicker1.Date) + '"))';
      DataModule1.ADOQueryAddMarks.ExecSQL;

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

      DBLookupComboBox3.KeyValue := '';
      DBLookupComboBox4.KeyValue := '';
      insert_boolean := True;

      break;
    end;
  end;

  if (NOT insert_boolean) then begin
    Label5.Visible := True;
    Label5.Caption := '�������� ����!';
  end;

end;

procedure TForm1.Button3Click(Sender: TObject);
begin
  Panel1.Visible := true;
  writeln(DBGrid1.Fields[0].AsString);
  DBLookupComboBox3.KeyValue := DBGrid1.Fields[0].AsString;
end;

procedure TForm1.Button4Click(Sender: TObject);
var
  mark_id, student_id: Integer;
begin
  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'SELECT * '    +
  'FROM Marks ' +
  'WHERE mark LIKE "' + DBLookupComboBox4.KeyValue + '"';
  DataModule1.ADOQueryAddMarks.Open;

  mark_id := DataModule1.DataSourceAddMarks.DataSet.Fields[0].AsInteger;

  DataModule1.ADOQueryAddMarks.Close;
  DataModule1.ADOQueryAddMarks.SQL.Text :=
  'SELECT id '    +
  'FROM Users ' +
  'WHERE surname LIKE "' + DBLookupComboBox3.KeyValue + '"';
  DataModule1.ADOQueryAddMarks.Open;

  student_id := DataModule1.DataSourceAddMarks.DataSet.Fields[0].AsInteger;

  DataModule1.ADOQueryTimetableGet.Close;
  DataModule1.ADOQueryTimetableGet.SQL.Text :=
    'SELECT  day_of_week '
  + 'FROM Timetable '
  + 'WHERE (group_id = ' + IntToStr(group_id) + ') AND '
  + '(subject_id = ' + IntToStr(subject_id) + ')';
  DataModule1.ADOQueryTimetableGet.Open;

  SetLength(timetableDaysOfWeek, DataModule1.ADOQueryTimetableGet.RecordCount);
  DataModule1.ADOQueryTimetableGet.First();

  while not DataModule1.ADOQueryTimetableGet.Eof do begin
    for var i := 0 to DataModule1.ADOQueryTimetableGet.RecordCount - 1 do
    begin
      timetableDaysOfWeek[i] :=
        DataModule1.ADOQueryTimetableGet.FieldByName('day_of_week').AsInteger;
      DataModule1.ADOQueryTimetableGet.Next();
    end;
  end;

  var len := Length(timetableDaysOfWeek);
  var insert_boolean := false;

  for var i := 0 to len do begin
    if (timetableDaysOfWeek[i] = dayofweek(DateTimePicker1.Date) - 1) then begin
      DataModule1.ADOQueryAddMarks.Close;
      DataModule1.ADOQueryAddMarks.SQL.Text :=
      'UPDATE Journal ' +
      'SET ' +
        'mark_id = ' + IntToStr(mark_id) + ' ' +
      'WHERE '+
      ' user_id = ' + IntToStr(student_id) + ' AND ' +
      ' subject_id = ' + IntToStr(subject_id) + ' AND ' +
      'date = DateValue("' + DateTimeToStr(DateTimePicker1.Date) + '"); ';
      DataModule1.ADOQueryAddMarks.ExecSQL;

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

      DBLookupComboBox3.KeyValue := '';
      DBLookupComboBox4.KeyValue := '';
      insert_boolean := True;

      break;
    end;
  end;

  if (NOT insert_boolean) then begin
    Label5.Visible := True;
    Label5.Caption := '�������� ����!';
  end;
end;

procedure TForm1.DateTimePicker1OnChange(Sender: TObject);
begin
  Label5.Visible := False;
end;

end.
