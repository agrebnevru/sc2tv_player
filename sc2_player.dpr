program sc2_player;

uses
  Windows,
  Forms,
  MainForm in 'MainForm.pas' {FormGeneral},
  Thread in 'Thread.pas',
  AboutForm in 'AboutForm.pas' {FormAbout},
  PopupForm in 'PopupForm.pas' {FormPopUp},
  ThreadUpdatePas in 'ThreadUpdatePas.pas',
  SettingsForm in 'SettingsForm.pas' {FormSettings},
  OnlyStreamForm in 'OnlyStreamForm.pas' {StreamForm},
  MyStreamForm in 'MyStreamForm.pas' {FormMyStream},
  MessageForm in 'MessageForm.pas' {FormMessage};

{$R *.res}

const
AtStr='MyProgram';

function CheckThis : boolean; 
var 
Atom: THandle;
begin 
Atom:= GlobalFindAtom(AtStr); 
Result:= Atom <> 0; 
if not result 
then GlobalAddAtom(AtStr); 
end;

begin
if not CheckThis then
	begin // Запуск программмы
	Application.Initialize;
	Application.ShowMainForm:= false;
	Application.CreateForm(TFormGeneral, FormGeneral);
	Application.CreateForm(TFormAbout, FormAbout);
	Application.CreateForm(TFormPopUp, FormPopUp);
	Application.CreateForm(TFormSettings, FormSettings);
	Application.CreateForm(TStreamForm, StreamForm);
	Application.CreateForm(TFormMyStream, FormMyStream);
   Application.CreateForm(TFormMessage, FormMessage);
	Application.Run;
	GlobalDeleteAtom(GlobalFindAtom(AtStr)); // !!!
	end
else
	begin
	MessageBox(0,'Обнаружена уже запущенная копия программы, вы не можете запускать SC2 Player на одном компьютере несколько раз.','SC2 Player', MB_ICONEXCLAMATION);
   //GlobalDeleteAtom(GlobalFindAtom(AtStr));
   end;
end.
