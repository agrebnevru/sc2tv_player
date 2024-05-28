unit OnlyStreamForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, registry;

type
  TStreamForm = class(TForm)
    WB2: TWebBrowser;
    procedure FormCreate(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure WB2DocumentComplete(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure WB2NewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    procedure SaveProgPosition;
    procedure LoadProgPosition;
  public
    { Public declarations }
  end;

var
  StreamForm: TStreamForm;
  StreamLink: string;
  StreamUrlNotFile: boolean;
  WindowHeight, WindowWidth: integer;

implementation

uses MainForm;

{$R *.dfm}

{------------------- Сохранение/Восстановление позиции begin ------------------}
procedure TStreamForm.SaveProgPosition;
var
FIniFile: TRegIniFile;
begin
FIniFile := TRegIniFile.Create('SC2Player'); // Инициализирую реестр
FIniFile.OpenKey('SC2Player',true); // Открываю раздел
FIniFile.OpenKey('SC2Player-PositionStreamOnly',true); // Открываю ещё один раздел
if WindowState=wsNormal then
begin
FIniFile.WriteInteger('Option', 'Left', Left);
FIniFile.WriteInteger('Option', 'Top', Top);
end;
FIniFile.Free;
end;

procedure TStreamForm.LoadProgPosition;
var
FIniFile: TRegIniFile;
begin
FIniFile := TRegIniFile.Create('SC2Player');
FIniFile.OpenKey('SC2Player',true);
FIniFile.OpenKey('SC2Player-PositionStreamOnly',true);
Left:=FIniFile.ReadInteger('Option', 'Left', 100);
Top:=FIniFile.ReadInteger('Option', 'Top', 100);
FIniFile.Free;
end;
{------------------- Сохранение/Восстановление позиции end-- ------------------}

procedure TStreamForm.FormCreate(Sender: TObject);
begin
SetWindowLong(Handle, GWL_HWNDPARENT, GetDesktopWindow);
SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
end;

procedure TStreamForm.FormShow(Sender: TObject);
begin
LoadProgPosition;
if StreamUrlNotFile then
	WB2.Navigate(StreamLink)
   else
   WB2.Navigate(extractfilepath(application.ExeName)+'MyStream.html');
if WindowHeight>100 then
	Height:= WindowHeight+25
   else
   Height:= 400;
if WindowWidth>100 then
	Width:= WindowWidth+7
   else
   Width:= 600;
end;

procedure TStreamForm.WB2DocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
Caption:= 'SC2 Player ['+WB2.LocationName+']';
//////////////////////////////////////////// Прячем скролбары браузера begin
WB2.OleObject.Document.Body.Style.OverflowX := 'hidden';
WB2.OleObject.Document.Body.Style.OverflowY := 'hidden';
//////////////////////////////////////////// Прячем скролбары браузера end
end;

procedure TStreamForm.WB2NewWindow2(Sender: TObject; var ppDisp: IDispatch;
  var Cancel: WordBool);
begin
Cancel:=True;
end;

procedure TStreamForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
SaveProgPosition;
end;

procedure TStreamForm.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
CanClose:= true;
WB2.Refresh;
end;

end.
