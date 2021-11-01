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
    DataSourceGroups: TDataSource;
    DataSourceSubjects: TDataSource;
    ADOQueryStudentsFromGroup: TADOQuery;
    DataSourceStudentFromGroup: TDataSource;
    ADOQueryAddMarks: TADOQuery;
    DataSourceAddMarks: TDataSource;
    ADOTableMarks: TADOTable;
    DataSourceTableMarks: TDataSource;
    ADOQueryTimetableGet: TADOQuery;
    DataSourceTimetableGet: TDataSource;
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


end.
