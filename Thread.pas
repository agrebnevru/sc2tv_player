unit Thread;

interface

uses
  Windows, Classes, Sysutils, Wininet, Forms, inifiles;

type
  MyThread = class(TThread)
  private
    { Private declarations }
    function GetInetFile(const fileURL, FileName: string): boolean;
  protected
    procedure Execute; override;
  end;

implementation

uses MainForm;

{ MyThread }

procedure MyThread.Execute;
var
i, y: integer;
begin
if DirectoryExists(extractfilepath(application.ExeName)+'/stream')<>true then
	exit;
FormGeneral.PanelStatus.Caption:= 'Подключение к серверу...';
FormGeneral.ProgressBar.Position:= 5;
GetInetFile('http://sc2player.do.am/stream_v2.ini', extractfilepath(application.ExeName)+'/stream.ini');
FormGeneral.PanelStatus.Caption:= 'Получение данных...';
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'stream.ini');
StreamKolVo:= inifile.ReadInteger('General', 'Stream', 0);
inifile.Free;
FormGeneral.ProgressBar.Position:= 10;
FormGeneral.PanelStatus.Caption:= 'Загрузка данных о стримах...';
y:= round((FormGeneral.ProgressBar.Max-FormGeneral.ProgressBar.Position)/StreamKolVo);
For i:=1 to StreamKolVo do
	begin
   FormGeneral.PanelStatus.Caption:= 'Загрузка данных о стриме №'+IntToStr(i)+'...';
   GetInetFile('http://sc2player.do.am/xml_v2/_'+IntToStr(i)+'.ini', extractfilepath(application.ExeName)+'stream/_'+IntToStr(i)+'.ini');
	FormGeneral.ProgressBar.Position:= FormGeneral.ProgressBar.Position+y;
   end;
FormGeneral.ProgressBar.Position:= 0;
FormGeneral.PanelStatus.Caption:= '';
FormGeneral.TimerCheckDL.Enabled:= false;
KeyConnected:= true;
end;

function MyThread.GetInetFile(const fileURL, FileName: string): boolean;
const
  BufferSize = 1024;
var
  hSession, hURL: HInternet;
  Buffer: array[1..BufferSize] of Byte;
  BufferLen: DWORD;
  f: file;
  sAppName: string;
begin
  Result := False;
  sAppName := ExtractFileName(Application.ExeName);
  hSession := InternetOpen(PChar(sAppName),
  INTERNET_OPEN_TYPE_PRECONFIG, nil, nil, 0);
  try
    hURL := InternetOpenURL(hSession, PChar(fileURL), nil, 0, INTERNET_FLAG_RELOAD, 0);
    try
      AssignFile(f, FileName);
      Rewrite(f,1);
      repeat
        InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
        BlockWrite(f, Buffer, BufferLen);
      until
        BufferLen = 0;
      CloseFile(f);
      Result := True;
    finally
      InternetCloseHandle(hURL);
    end;
  finally
    InternetCloseHandle(hSession);
  end;
end;

end.
 