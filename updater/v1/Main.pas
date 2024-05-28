unit Main;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, pngimage, ExtCtrls, StdCtrls, ShellAPI, Wininet, Thread;

type
  TForm1 = class(TForm)
    ListBoxLog: TListBox;
    Image1: TImage;
    TimerCloser: TTimer;
    TimerProgress: TTimer;
    LabelProgress: TLabel;
    procedure FormShow(Sender: TObject);
    procedure TimerCloserTimer(Sender: TObject);
    procedure TimerProgressTimer(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
  private
    { Private declarations }
    co:MyThread;
    procedure UpdateCancaled;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  KeyClose: boolean;

implementation

{$R *.dfm}

procedure TForm1.FormShow(Sender: TObject);
begin
 co:=MyThread.Create(true);
 co.Resume;
 co.Priority:=tpIdle;
end;

procedure TForm1.UpdateCancaled;
begin
co.Terminate;
KeyClose:= true;
if fileexists(extractfilepath(application.ExeName)+'sc2_player.!exe') then
	DeleteFile(extractfilepath(application.ExeName)+'sc2_player.!exe');
Close;
end;

procedure TForm1.TimerCloserTimer(Sender: TObject);
begin
TimerCloser.Enabled:= false;
Close;
end;

procedure TForm1.TimerProgressTimer(Sender: TObject);
begin
LabelProgress.Caption:= LabelProgress.Caption + '.';
if Length(LabelProgress.Caption)>20 then
	LabelProgress.Caption:= 'Загрузка файла';
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
      CanClose:= false;
      end;
   end;
end;

end.
