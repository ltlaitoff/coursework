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
    errorString.Caption := 'Укажите название!';
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
  Panel1.Visible := true;
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

end.
