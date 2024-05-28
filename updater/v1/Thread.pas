unit Thread;

interface

uses
  Windows, Classes, Sysutils, ShellAPI, Wininet, Forms;

type
  MyThread = class(TThread)
  private
    { Private declarations }
    function GetInetFile(const fileURL, FileName: string): boolean;
  protected
    procedure Execute; override;
  end;

implementation

uses Main;

{ MyThread }

procedure MyThread.Execute;
begin
if GetInetFile('http://sc2player.do.am/sc2_player', extractfilepath(application.ExeName)+'sc2_player.!exe') then
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
    Form1.ListBoxLog.Items.Add('Поключение прошло успешно.');
    try
      AssignFile(f, FileName);
      Rewrite(f,1);
      Form1.ListBoxLog.Items.Add('Загрузка файла. Подождите немного...');
      Form1.TimerProgress.Enabled:= true;
      repeat
        InternetReadFile(hURL, @Buffer, SizeOf(Buffer), BufferLen);
        BlockWrite(f, Buffer, BufferLen);
      until
        BufferLen = 0;
      Form1.TimerProgress.Enabled:= false;
      Form1.LabelProgress.Caption:= '';
      CloseFile(f);
      Form1.ListBoxLog.Items.Add('Загрузка файла завершена.');
      Result := True;
    finally
      InternetCloseHandle(hURL);
      Form1.ListBoxLog.Items.Add('Закрываем подключение к серверу.');
    end;
  finally
    InternetCloseHandle(hSession);
    Form1.ListBoxLog.Items.Add('Закрывает интернет соединение.');
  end;
Form1.ListBoxLog.Items.Add('Файл загружен.');
RenameFile(extractfilepath(application.ExeName)+'sc2_player.!exe', extractfilepath(application.ExeName)+'sc2_player.exe');
if fileexists(extractfilepath(application.ExeName)+'sc2_player.exe') then
	ShellExecute(Handle, nil, PChar(extractfilepath(application.ExeName)+'sc2_player.exe'), nil, nil, SW_RESTORE);
Form1.TimerCloser.Enabled:= true;
KeyClose:= true;
end;

end.
