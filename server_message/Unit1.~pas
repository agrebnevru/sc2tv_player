unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ScktComp, StdCtrls, ExtCtrls, Menus, CoolTrayIcon, ComCtrls,
  ToolWin, ImgList, inifiles;

type
  TForm1 = class(TForm)
    Label1: TLabel;
    LabelConnections: TLabel;
    ButtonSend: TButton;
    RGNeedPopUp: TRadioGroup;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    LabelGoMessage: TLabel;
    ButtonTimerRe: TButton;
    RGSendOnTime: TRadioGroup;
    LabelLastMesTime: TLabel;
    Label3: TLabel;
    LabelSkokEshe: TLabel;
    LabelOstalos: TLabel;
    TimerRefreshNadpis: TTimer;
    PMTray: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    CTI: TCoolTrayIcon;
    TimerShow: TTimer;
    SS1: TServerSocket;
    RGWatchOnTimer: TRadioGroup;
    GroupBox4: TGroupBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    ToolBar1: TToolBar;
    TBAprrove1: TToolButton;
    TBClear1: TToolButton;
    ImageForMess1: TToolButton;
    ToolBar2: TToolBar;
    TBAprrove2: TToolButton;
    TBClear2: TToolButton;
    ImageForMess2: TToolButton;
    ToolBar3: TToolBar;
    TBAprrove3: TToolButton;
    TBClear3: TToolButton;
    ImageForMess3: TToolButton;
    MemoMes1: TMemo;
    MemoMes2: TMemo;
    MemoMes3: TMemo;
    ILForMess: TImageList;
    EditMessage: TMemo;
    Label2: TLabel;
    MemoMes4: TMemo;
    ToolBar4: TToolBar;
    TBAprrove4: TToolButton;
    TBClear4: TToolButton;
    ImageForMess4: TToolButton;
    GroupBox5: TGroupBox;
    ILBigForMes: TImageList;
    ImageForMes: TImage;
    CBChoseImage: TComboBox;
    Label7: TLabel;
    Image1: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image5: TImage;
    ToolBar5: TToolBar;
    TBAprrove5: TToolButton;
    TBClear5: TToolButton;
    ImageForMess5: TToolButton;
    Label8: TLabel;
    MemoMes5: TMemo;
    TimerSendMess: TTimer;
    EditIdImage1: TEdit;
    EditIdImage2: TEdit;
    EditIdImage3: TEdit;
    EditIdImage4: TEdit;
    EditIdImage5: TEdit;
    TimerSendUserOnline: TTimer;
    procedure SS1ClientConnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure SS1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure SS1ClientError(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure FormDestroy(Sender: TObject);
    procedure TimerShowTimer(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure ButtonSendClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CTIDblClick(Sender: TObject);
    procedure PMTrayPopup(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure ButtonTimerReClick(Sender: TObject);
    procedure TimerRefreshNadpisTimer(Sender: TObject);
    procedure CBChoseImageChange(Sender: TObject);
    procedure ImageForMess1Click(Sender: TObject);
    procedure ImageForMess2Click(Sender: TObject);
    procedure ImageForMess3Click(Sender: TObject);
    procedure ImageForMess4Click(Sender: TObject);
    procedure ImageForMess5Click(Sender: TObject);
    procedure TBClear1Click(Sender: TObject);
    procedure TBClear2Click(Sender: TObject);
    procedure TBClear3Click(Sender: TObject);
    procedure TBClear4Click(Sender: TObject);
    procedure TBClear5Click(Sender: TObject);
    procedure TimerSendMessTimer(Sender: TObject);
    procedure TBAprrove1Click(Sender: TObject);
    procedure TBAprrove2Click(Sender: TObject);
    procedure TBAprrove3Click(Sender: TObject);
    procedure TBAprrove4Click(Sender: TObject);
    procedure TimerSendUserOnlineTimer(Sender: TObject);
  private
    { Private declarations }
    procedure SaveInfo;
    procedure LoadInfo;
    procedure SendingBigMessage;
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  Connections, Vrema: integer;
  KeyClose: boolean;
  inifile: tinifile;

implementation

{$R *.dfm}

procedure TForm1.SaveInfo;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'Info.ini');
inifile.WriteString('Information', 'Img1', EditIdImage1.Text);
inifile.WriteString('Information', 'Text1', MemoMes1.Lines.Text);
inifile.WriteString('Information', 'Img2', EditIdImage2.Text);
inifile.WriteString('Information', 'Text2', MemoMes2.Lines.Text);
inifile.WriteString('Information', 'Img3', EditIdImage3.Text);
inifile.WriteString('Information', 'Text3', MemoMes3.Lines.Text);
inifile.WriteString('Information', 'Img4', EditIdImage4.Text);
inifile.WriteString('Information', 'Text4', MemoMes4.Lines.Text);
inifile.WriteString('Information', 'Img5', EditIdImage5.Text);
inifile.WriteString('Information', 'Text5', MemoMes5.Lines.Text);
inifile.Free;
end;

procedure TForm1.LoadInfo;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'Info.ini');
EditIdImage1.Text:= inifile.ReadString('Information', 'Img1', '0');
MemoMes1.Lines.Text:= inifile.ReadString('Information', 'Text1', '');
ILBigForMes.GetBitmap(StrToInt(EditIdImage1.Text), Image1.Picture.Bitmap);
Image1.Refresh;
EditIdImage2.Text:= inifile.ReadString('Information', 'Img2', '0');
MemoMes2.Lines.Text:= inifile.ReadString('Information', 'Text2', '');
ILBigForMes.GetBitmap(StrToInt(EditIdImage2.Text), Image2.Picture.Bitmap);
Image2.Refresh;
EditIdImage3.Text:= inifile.ReadString('Information', 'Img3', '0');
MemoMes3.Lines.Text:= inifile.ReadString('Information', 'Text3', '');
ILBigForMes.GetBitmap(StrToInt(EditIdImage3.Text), Image3.Picture.Bitmap);
Image3.Refresh;
EditIdImage4.Text:= inifile.ReadString('Information', 'Img4', '0');
MemoMes4.Lines.Text:= inifile.ReadString('Information', 'Text4', '');
ILBigForMes.GetBitmap(StrToInt(EditIdImage4.Text), Image4.Picture.Bitmap);
Image4.Refresh;
EditIdImage5.Text:= inifile.ReadString('Information', 'Img5', '0');
MemoMes5.Lines.Text:= inifile.ReadString('Information', 'Text5', '');
ILBigForMes.GetBitmap(StrToInt(EditIdImage5.Text), Image5.Picture.Bitmap);
Image5.Refresh;
inifile.Free;
end;

procedure TForm1.SendingBigMessage;
var
i: integer;
begin
// #bigmess#[нужно_ли_выводить_popup]#[номер сообщения]#[картинка к изображению]#[сообщение]
if TBAprrove1.Down then
	for i:=0 to SS1.Socket.ActiveConnections-1 do
		Begin
		SS1.Socket.Connections[i].SendText('#bigmess#0#0#'+EditIdImage1.Text+'#'+MemoMes1.Lines.Text);
		end;
Sleep(100);
if TBAprrove2.Down then
	for i:=0 to SS1.Socket.ActiveConnections-1 do
		Begin
		SS1.Socket.Connections[i].SendText('#bigmess#0#1#'+EditIdImage2.Text+'#'+MemoMes2.Lines.Text);
		end;
Sleep(100);
if TBAprrove3.Down then
	for i:=0 to SS1.Socket.ActiveConnections-1 do
		Begin
		SS1.Socket.Connections[i].SendText('#bigmess#0#2#'+EditIdImage3.Text+'#'+MemoMes3.Lines.Text);
		end;
Sleep(100);
if TBAprrove4.Down then
	for i:=0 to SS1.Socket.ActiveConnections-1 do
		Begin
		SS1.Socket.Connections[i].SendText('#bigmess#0#3#'+EditIdImage4.Text+'#'+MemoMes4.Lines.Text);
		end;
Sleep(100);
if TBAprrove5.Down then
	for i:=0 to SS1.Socket.ActiveConnections-1 do
		Begin
		SS1.Socket.Connections[i].SendText('#bigmess#0#4#'+EditIdImage5.Text+'#'+MemoMes5.Lines.Text);
		end;
end;

procedure TForm1.SS1ClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
i: integer;
begin
Connections:= SS1.Socket.ActiveConnections;
LabelConnections.Caption:= IntToStr(Connections);
SendingBigMessage;
Sleep(100);
// #onluser#[нужно_ли_выводить_popup]#[номер сообщения]#[картинка к изображению]#[сообщение]
for i:=0 to SS1.Socket.ActiveConnections-1 do
	Begin
	SS1.Socket.Connections[i].SendText('#onluser#0#0#0#'+LabelConnections.Caption);
	end;
Sleep(100);
end;

procedure TForm1.SS1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
Connections:= SS1.Socket.ActiveConnections;
LabelConnections.Caption:= IntToStr(Connections);
end;

procedure TForm1.SS1ClientError(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
ErrorCode:= 0;
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
SS1.Active:= false;
end;

procedure TForm1.TimerShowTimer(Sender: TObject);
var
i: integer;
begin
TimerShow.Enabled:= false;
TimerRefreshNadpis.Enabled:= false;
LabelGoMessage.Caption:= 'Можно отправлять сообщение.';
if RGSendOnTime.ItemIndex=1 then
	begin
   LabelLastMesTime.Caption:= FormatDateTime('hh:nn', Time());
   for i:=0 to SS1.Socket.ActiveConnections-1 do
		Begin
      SS1.Socket.Connections[i].SendText('#message#'+IntToStr(RGNeedPopUp.ItemIndex)+'#0#0#'+EditMessage.Text);
		end;
   LabelGoMessage.Caption:= 'Была произведена авто отсылка сообщения.';
   end;
if RGWatchOnTimer.ItemIndex=1 then
	Form1.Show;
Vrema:= TimerShow.Interval;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
KeyClose:= true;
Close;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose:= KeyClose;
if not CanClose then
	Hide
   else
   SaveInfo;
end;

procedure TForm1.ButtonSendClick(Sender: TObject);
var
i: integer;
begin
LabelLastMesTime.Caption:= FormatDateTime('hh:nn', Time());
for i:=0 to SS1.Socket.ActiveConnections-1 do
	Begin
	SS1.Socket.Connections[i].SendText('#message#'+IntToStr(RGNeedPopUp.ItemIndex)+'#0#0#'+EditMessage.Text);
	end;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Application.Minimize;
Vrema:= TimerShow.Interval;
LoadInfo;
Connections:= 0;
SS1.Active:= true;
TimerShow.Enabled:= true;
TimerRefreshNadpis.Enabled:= true;
TimerSendUserOnline.Enabled:= true;
end;

procedure TForm1.CTIDblClick(Sender: TObject);
begin
if Showing then
	Hide
else
	Show;
end;

procedure TForm1.PMTrayPopup(Sender: TObject);
begin
if Showing then
    N1.Caption:= 'Скрыть'
else
    N1.Caption:= 'Показать';
end;

procedure TForm1.N1Click(Sender: TObject);
begin
if Showing then
	Hide
else
	Show;
end;

procedure TForm1.ButtonTimerReClick(Sender: TObject);
begin
LabelGoMessage.Caption:= 'Повторный отсчет.';
TimerShow.Enabled:= true;
TimerRefreshNadpis.Enabled:= true;
LabelOstalos.Caption:= IntToStr(round((Vrema/1000)/60))+' мин.';
Vrema:= TimerShow.Interval;
end;

procedure TForm1.TimerRefreshNadpisTimer(Sender: TObject);
begin
LabelOstalos.Caption:= IntToStr(round((Vrema/1000)/60))+' мин.';
Vrema:= Vrema-10000;
end;

procedure TForm1.CBChoseImageChange(Sender: TObject);
begin
ILBigForMes.GetBitmap(CBChoseImage.ItemIndex, ImageForMes.Picture.Bitmap);
ImageForMes.Refresh;
end;

procedure TForm1.ImageForMess1Click(Sender: TObject);
var
id: string;
begin
id:= inputbox('[Server] SC2 Player - Message', 'Введите id изображения', '0');
ILBigForMes.GetBitmap(StrToInt(id), Image1.Picture.Bitmap);
Image1.Refresh;
EditIdImage1.Text:= id;
end;

procedure TForm1.ImageForMess2Click(Sender: TObject);
var
id: string;
begin
id:= inputbox('[Server] SC2 Player - Message', 'Введите id изображения', '0');
ILBigForMes.GetBitmap(StrToInt(id), Image2.Picture.Bitmap);
Image2.Refresh;
EditIdImage2.Text:= id;
end;

procedure TForm1.ImageForMess3Click(Sender: TObject);
var
id: string;
begin
id:= inputbox('[Server] SC2 Player - Message', 'Введите id изображения', '0');
ILBigForMes.GetBitmap(StrToInt(id), Image3.Picture.Bitmap);
Image3.Refresh;
EditIdImage3.Text:= id;
end;

procedure TForm1.ImageForMess4Click(Sender: TObject);
var
id: string;
begin
id:= inputbox('[Server] SC2 Player - Message', 'Введите id изображения', '0');
ILBigForMes.GetBitmap(StrToInt(id), Image4.Picture.Bitmap);
Image4.Refresh;
EditIdImage4.Text:= id;
end;

procedure TForm1.ImageForMess5Click(Sender: TObject);
var
id: string;
begin
id:= inputbox('[Server] SC2 Player - Message', 'Введите id изображения', '0');
ILBigForMes.GetBitmap(StrToInt(id), Image5.Picture.Bitmap);
Image5.Refresh;
EditIdImage5.Text:= id;
end;

procedure TForm1.TBClear1Click(Sender: TObject);
begin
MemoMes1.Clear;
end;

procedure TForm1.TBClear2Click(Sender: TObject);
begin
MemoMes2.Clear;
end;

procedure TForm1.TBClear3Click(Sender: TObject);
begin
MemoMes3.Clear;
end;

procedure TForm1.TBClear4Click(Sender: TObject);
begin
MemoMes4.Clear;
end;

procedure TForm1.TBClear5Click(Sender: TObject);
begin
MemoMes5.Clear;
end;

procedure TForm1.TimerSendMessTimer(Sender: TObject);
begin
SendingBigMessage;
end;

procedure TForm1.TBAprrove1Click(Sender: TObject);
begin
if TBAprrove1.Down then
	TBAprrove2.Enabled:= true
   else
   begin
   TBAprrove2.Enabled:= false;
   TBAprrove3.Enabled:= false;
   TBAprrove4.Enabled:= false;
   TBAprrove5.Enabled:= false;
   end;
end;

procedure TForm1.TBAprrove2Click(Sender: TObject);
begin
if TBAprrove2.Down then
	TBAprrove3.Enabled:= true
   else
   begin
   TBAprrove3.Enabled:= false;
   TBAprrove4.Enabled:= false;
   TBAprrove5.Enabled:= false;
   end;
end;

procedure TForm1.TBAprrove3Click(Sender: TObject);
begin
if TBAprrove3.Down then
	TBAprrove4.Enabled:= true
   else
   begin
   TBAprrove4.Enabled:= false;
   TBAprrove5.Enabled:= false;
   end;
end;

procedure TForm1.TBAprrove4Click(Sender: TObject);
begin
if TBAprrove4.Down then
	TBAprrove5.Enabled:= true
   else
   TBAprrove5.Enabled:= false;
end;

procedure TForm1.TimerSendUserOnlineTimer(Sender: TObject);
var
i: integer;
begin
// #onluser#[нужно_ли_выводить_popup]#[номер сообщения]#[картинка к изображению]#[сообщение]
for i:=0 to SS1.Socket.ActiveConnections-1 do
	Begin
	SS1.Socket.Connections[i].SendText('#onluser#0#0#0#'+LabelConnections.Caption);
	end;
Sleep(100);
end;

end.
