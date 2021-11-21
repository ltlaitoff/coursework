program coursework;

uses
  Vcl.Forms,
  Unit1 in 'Unit1.pas' {Main},
  Unit2 in 'Unit2.pas' {DataModule1: TDataModule},
  Unit3 in 'Unit3.pas' {Subjects},
  Unit6 in 'Unit6.pas' {Users},
  Unit4 in 'Unit4.pas' {Timetable},
  Unit5 in 'Unit5.pas' {Groups},
  Unit7 in 'Unit7.pas' {Teachers},
  Unit8 in 'Unit8.pas' {TimeTableReport};

{$R *.res}

begin
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.CreateForm(TMain, Main);
  Application.CreateForm(TDataModule1, DataModule1);
  Application.CreateForm(TSubjects, Subjects);
  Application.CreateForm(TUsers, Users);
  Application.CreateForm(TTimetable, Timetable);
  Application.CreateForm(TGroups, Groups);
  Application.CreateForm(TTeachers, Teachers);
  Application.CreateForm(TTimeTableReport, TimeTableReport);
  Application.Run;
end.
