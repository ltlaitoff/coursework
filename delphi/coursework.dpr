program coursework;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Main},
  Unit2 in 'Unit2.pas' {DataModule1: TDataModule},
  Unit3 in 'Unit3.pas' {Subjects};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TSubjects, Subjects);
  Application.Run;
end.
