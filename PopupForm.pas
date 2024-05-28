unit PopupForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, pngimage, mmsystem, inifiles;

type
  TFormPopUp = class(TForm)
    ImagePhone: TImage;
    POPUPTitle: TLabel;
    POPUPMessage: TStaticText;
    TimerCloser: TTimer;
    ImageNotClose: TImage;
    procedure TimerCloserTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure POPUPMessageMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ImagePhoneMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure POPUPTitleMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormCreate(Sender: TObject);
	 procedure SetSettings;
    procedure ImageNotCloseClick(Sender: TObject);
  private
    { Private declarations }
    procedure ClickM(Button: TMouseButton);
  public
    { Public declarations }
  end;

var
  FormPopUp: TFormPopUp;
  MesTitle, MesMessage: string;
  inifile: tinifile;

implementation

uses MainForm;

{$R *.dfm}

procedure TFormPopUp.SetSettings;
var
per: boolean;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'Config.ini');
FormPopUp.TimerCloser.Interval:= (inifile.ReadInteger('Action Settings', 'PopupTimeWatch', 10))*1000;
FormPopUp.AlphaBlendValue:= inifile.ReadInteger('Action Settings', 'PopupTransparentValue', 255);
FormPopUp.AlphaBlend:= inifile.ReadBool('Action Settings', 'PopupTransparentKey', false);
inifile.Free;
end;

procedure TFormPopUp.ClickM(Button: TMouseButton);
begin
if Button=mbLeft then
	if FormGeneral.Showing<>true then
   	begin
   	FormGeneral.Show;
      Close;
      end
      else
      Close;
if Button=mbRight  then
	begin
	Close;
   end;
end;

procedure TFormPopUp.TimerCloserTimer(Sender: TObject);
begin
TimerCloser.Enabled:= false;
Close;
end;

procedure TFormPopUp.FormShow(Sender: TObject);
begin
if SoundAction AND fileexists(SoundActionFile) then
	SndPlaySound(PChar(SoundActionFile), SND_ASYNC);
FormPopUp.Left:=screen.WorkAreaWidth-FormPopUp.Width;
FormPopUp.Top:=screen.WorkAreaHeight-FormPopUp.Height;
POPUPTitle.Caption:= MesTitle;
POPUPMessage.Caption:= '   ' + MesMessage;
TimerCloser.Enabled:= true;
end;

procedure TFormPopUp.POPUPMessageMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
ClickM(Button);
end;

procedure TFormPopUp.ImagePhoneMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ClickM(Button);
end;

procedure TFormPopUp.POPUPTitleMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
ClickM(Button);
end;

procedure TFormPopUp.FormCreate(Sender: TObject);
begin
SetSettings;
FormPopUp.FormStyle:=fsStayOnTop;
SetWindowLong(Handle, GWL_HWNDPARENT, GetDesktopWindow);
SetWindowPos(Handle, HWND_TOPMOST, 0, 0, 0, 0, SWP_NOSIZE or SWP_NOMOVE);
end;

procedure TFormPopUp.ImageNotCloseClick(Sender: TObject);
begin
TimerCloser.Enabled:= false;
end;

end.
