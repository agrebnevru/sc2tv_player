program update;

uses
  Forms,
  Main in 'Main.pas' {Form1},
  Thread in 'Thread.pas';

{$R *.res}

begin
  Application.Initialize;
  Application.CreateForm(TForm1, Form1);
  Application.Run;
end.
