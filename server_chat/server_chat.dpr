program server_chat;

uses
  Forms,
  MainF in 'MainF.pas' {Form1};

{$R *.res}

begin
	Application.Initialize;
	Application.ShowMainForm:= false;
	Application.CreateForm(TForm1, Form1);
	Application.Run;
end.
