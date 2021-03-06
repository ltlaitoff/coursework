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
