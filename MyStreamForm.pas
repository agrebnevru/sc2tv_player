unit MyStreamForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, registry;

type
  TFormMyStream = class(TForm)
    DownPanel: TPanel;
    ToolBarOkCancel: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    MemoMyStreamCode: TMemo;
    Panel1: TPanel;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure MemoMyStreamCodeClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    procedure StreamCreateAndSave;
    procedure SaveProgPosition;
    procedure LoadProgPosition;
  public
    { Public declarations }
  end;

var
  FormMyStream: TFormMyStream;

implementation

{$R *.dfm}

{------------------- Сохранение/Восстановление позиции begin ------------------}
procedure TFormMyStream.SaveProgPosition;
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

procedure TFormMyStream.LoadProgPosition;
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

procedure TFormMyStream.StreamCreateAndSave;
var
CodePlayer: string;
begin
CodePlayer:= MemoMyStreamCode.Lines.Text;
MemoMyStreamCode.Lines.Clear;
MemoMyStreamCode.Lines.Add('<html>');
MemoMyStreamCode.Lines.Add('<head>');
MemoMyStreamCode.Lines.Add('<title>My Stream</title>');
MemoMyStreamCode.Lines.Add('<style type="text/css" media="all">');
MemoMyStreamCode.Lines.Add('@import url(http://sc2player.do.am/stream/style.css);');
MemoMyStreamCode.Lines.Add('</style>');
MemoMyStreamCode.Lines.Add('</head>');
MemoMyStreamCode.Lines.Add('<body>');
MemoMyStreamCode.Lines.Add('');
MemoMyStreamCode.Lines.Add('<table width="100%" border="0" cellspacing="0" cellpadding="0">');
MemoMyStreamCode.Lines.Add('<tr>');
MemoMyStreamCode.Lines.Add('<td valign="top">');
MemoMyStreamCode.Lines.Add('');
MemoMyStreamCode.Lines.Add(CodePlayer);
MemoMyStreamCode.Lines.Add('');
MemoMyStreamCode.Lines.Add('</td>');
MemoMyStreamCode.Lines.Add('</tr>');
MemoMyStreamCode.Lines.Add('</table>');
MemoMyStreamCode.Lines.Add('');
MemoMyStreamCode.Lines.Add('</body>');
MemoMyStreamCode.Lines.Add('</html>');
MemoMyStreamCode.Lines.SaveToFile(extractfilepath(application.ExeName)+'MyStream.html');
end;

procedure TFormMyStream.ToolButton1Click(Sender: TObject);
begin
Close;
end;

procedure TFormMyStream.ToolButton2Click(Sender: TObject);
begin
StreamCreateAndSave;
Close;
end;

procedure TFormMyStream.MemoMyStreamCodeClick(Sender: TObject);
begin
If MemoMyStreamCode.Lines.Strings[0]='Скопируйте сюда код вашего плеера.' then
	MemoMyStreamCode.Lines.Clear;
end;

procedure TFormMyStream.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
SaveProgPosition;
end;

procedure TFormMyStream.FormShow(Sender: TObject);
begin
LoadProgPosition;
end;

end.
