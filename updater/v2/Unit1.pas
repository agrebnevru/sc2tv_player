unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdBaseComponent, IdComponent, IdTCPConnection,
  IdTCPClient, IdHTTP, OleCtrls, SHDocVw, XPMan, ComCtrls, Shellapi,
  IdIntercept, IdLogBase, IdLogStream, DateUtils, IdAntiFreezeBase,
  IdAntiFreeze, ExtCtrls, Registry, Inifiles, pngimage;

type
  TForm1 = class(TForm)
    IdHTTP1: TIdHTTP;
    XPManifest1: TXPManifest;
    IdAntiFreeze1: TIdAntiFreeze;
    Image1: TImage;
    ListBoxLog: TListBox;
    LabelProgress: TLabel;
    TimerProgress: TTimer;
    TimerCloser: TTimer;
    TimerStartDownload: TTimer;
    procedure FormCreate(Sender: TObject);
    procedure TimerProgressTimer(Sender: TObject);
    procedure TimerCloserTimer(Sender: TObject);
    procedure TimerStartDownloadTimer(Sender: TObject);
    procedure IdHTTP1Connected(Sender: TObject);
    procedure IdHTTP1Status(ASender: TObject; const AStatus: TIdStatus;
      const AStatusText: String);
    procedure IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
      const AWorkCountMax: Integer);
    procedure IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure DownLoadUpdate;
    procedure UpdateCancaled;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  KeyClose: boolean;
const
  INTERNET_CONNECTION_MODEM           = 1;
  INTERNET_CONNECTION_LAN             = 2;
  INTERNET_CONNECTION_PROXY           = 4;
  INTERNET_CONNECTION_MODEM_BUSY      = 8;

function InternetGetConnectedState(lpdwFlags: LPDWORD;dwReserved: DWORD): BOOL; stdcall;  
implementation

function InternetGetConnectedState;
external 'wininet.dll' name 'InternetGetConnectedState';

{$R *.dfm}


function Detection_Connexion:boolean;
var
  dwFlags : DWORD;
begin
  dwFlags :=INTERNET_CONNECTION_MODEM + INTERNET_CONNECTION_LAN
           + INTERNET_CONNECTION_PROXY ;
  RESULT := InternetGetConnectedState(@dwFlags,0);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
TimerStartDownload.Enabled:= true;
KeyClose:= false;
end;

procedure TForm1.TimerProgressTimer(Sender: TObject);
begin
if Length(LabelProgress.Caption)<1 then
	LabelProgress.Caption:= 'Загрузка файла';
LabelProgress.Caption:= LabelProgress.Caption + '.';
if Length(LabelProgress.Caption)>20 then
	LabelProgress.Caption:= 'Загрузка файла';
end;

procedure TForm1.TimerCloserTimer(Sender: TObject);
begin
KeyClose:= true;
//
if fileexists(extractfilepath(application.ExeName)+'sc2_player.!exe') then
	RenameFile(extractfilepath(application.ExeName)+'sc2_player.!exe', extractfilepath(application.ExeName)+'sc2_player.exe');
if fileexists(extractfilepath(application.ExeName)+'sc2_player.exe') then
	ShellExecute(Handle, nil, PChar(extractfilepath(application.ExeName)+'sc2_player.exe'), nil, nil, SW_RESTORE);
//
TimerCloser.Enabled:= false;
Close;
end;

procedure TForm1.TimerStartDownloadTimer(Sender: TObject);
begin
Detection_Connexion;
IdAntiFreeze1.Active:=True;
DownLoadUpdate;
TimerStartDownload.Enabled:= false;
end;

procedure TForm1.IdHTTP1Connected(Sender: TObject);
begin
ListBoxLog.Items.Add('Подключение прошло успешно.');
end;

procedure TForm1.IdHTTP1Status(ASender: TObject; const AStatus: TIdStatus;
  const AStatusText: String);
begin
ListBoxLog.Items.Add('Статус: '+AStatusText);
end;

procedure TForm1.IdHTTP1WorkBegin(Sender: TObject; AWorkMode: TWorkMode;
  const AWorkCountMax: Integer);
begin
ListBoxLog.Items.Add('Обновление стартовало.');
end;

procedure TForm1.IdHTTP1WorkEnd(Sender: TObject; AWorkMode: TWorkMode);
begin
ListBoxLog.Items.Add('Обновление закончено.');
end;

procedure TForm1.DownLoadUpdate;
var
  FS: TFileStream;
begin
if FileExists(extractfilepath(application.ExeName)+'sc2_player.!exe')<>true then
	begin
   TimerProgress.Enabled:= true;
		FS := TFileStream.Create(extractfilepath(application.ExeName)+'sc2_player.!exe', fmCreate);
			try
      	IdHttp1.Get('http://sc2player.do.am/sc2_player', FS);
			finally
			FS.Free;
         KeyClose:= true;
         TimerCloser.Enabled:= true;
      	end;
	end;
end;

procedure TForm1.UpdateCancaled;
begin
	try
	IdHTTP1.Free;
	IdAntiFreeze1.Active:= false;
	except
	KeyClose:= true;
	if fileexists(extractfilepath(application.ExeName)+'sc2_player.!exe') then
		DeleteFile(extractfilepath(application.ExeName)+'sc2_player.!exe');
	Close;
	end;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose:= KeyClose;
if KeyClose<>true then
	begin
   if MessageDlg('Обновление еще не завершено. Вы уверены, что хотите выйти?',
	mtConfirmation, [mbYes, mbNo], 0)=mrYes then
   	begin
      UpdateCancaled;
      end
      else
      begin
      KeyClose:= false;
      CanClose:= false;
      end;
   end;
end;

end.
