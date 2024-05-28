unit ThreadUpdatePas;

interface

uses
  Windows, Classes, Sysutils, Wininet, Forms, inifiles;

type
  ThreadUpdate = class(TThread)
  private
    { Private declarations }
    function GetInetFile(const fileURL, FileName: string): boolean;
  protected
    procedure Execute; override;
  end;

Const
UpdateUrl = 'http://sc2player.do.am/lastver.ini';
UpdateTF = 'lastver.ini';

implementation

uses MainForm;

{ ThreadUpdate }

procedure ThreadUpdate.Execute;
var
LastVers: string;
begin
if GetInetFile(UpdateUrl, UpdateTF) then
	begin
   inifile:=tinifile.Create(extractfilepath(application.ExeName)+'lastver.ini');
	LastVers:= inifile.ReadString('General', 'LastVer', '0');
	inifile.Free;
	end;
if SC2PlayerVersion<>LastVers then
   FormGeneral.TimerUpdateStart.Enabled:= true;
end;

function ThreadUpdate.GetInetFile(const fileURL, FileName: string): boolean;
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
