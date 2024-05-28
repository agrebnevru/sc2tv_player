unit MainForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, OleCtrls, SHDocVw, StdCtrls, ExtCtrls, Menus, CoolTrayIcon,
  ImgList, VirtualTrees, ComCtrls, ToolWin, XPMan, Shellapi, inifiles, Thread,
  ThreadUpdatePas, ScktComp, mmsystem, RVStyle, RVScroll, RVFuncs, RVItem,
  RichView, Animate, GIFCtrl, registry, pngimage, RzBorder;
  
type
  PSLNode = ^TSLNode;

  TSLNode = record
    SN, Site, MainHint: String;
    IMG, Country, AllStr, St: integer;
    FHeight, FWidth: array of integer;
    Url, Hint: array of string;
  end;

  TFormGeneral = class(TForm)
    WB: TWebBrowser;
    CTI: TCoolTrayIcon;
    TrayMenu: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    ImgListIcon: TImageList;
    VST: TVirtualStringTree;
    ImageListVST: TImageList;
    ProgressBar: TProgressBar;
    DownPanel: TPanel;
    PanelStatus: TPanel;
    TopPanel: TPanel;
    XPManifest1: TXPManifest;
    VSTMenu: TPopupMenu;
    N5: TMenuItem;
    RightPanel: TPanel;
    CenterPanel: TPanel;
    GeneralToolBar: TToolBar;
    ShowChat: TToolButton;
    ShowStremList: TToolButton;
    ToolButtonPageRefresh: TToolButton;
    RefreshStreamList: TToolButton;
    LeftPanel: TPanel;
    TimerPageRefresh: TTimer;
    TimerStreamListRefresh: TTimer;
    ToolButtonSettings: TToolButton;
    TimerKeyConnected: TTimer;
    ShowAboutForm: TToolButton;
    TimerUpdateStart: TTimer;
    DownPanel2: TPanel;
    ShowDownPanel2: TToolButton;
    PanelHeaderStream: TPanel;
    PanelHeaderStreamList: TPanel;
    PanelHeaderChat: TPanel;
    EditMessage: TEdit;
    ILBBCode: TImageList;
    ToolBarBBCode: TToolBar;
    TBFormatB: TToolButton;
    TBFormatI: TToolButton;
    TBColorText: TToolButton;
    TBFormatU: TToolButton;
    TBFormatTire: TToolButton;
    LabelChatOnline: TLabel;
    LabelChatUserOnline: TLabel;
    Panel4: TPanel;
    Panel5: TPanel;
    Panel6: TPanel;
    CS1: TClientSocket;
    RVS: TRVStyle;
    TimerChat: TTimer;
    TimerChatMes: TTimer;
    Panel7: TPanel;
    RVChat: TRichView;
    PanelChatConnecting: TPanel;
    GIFAni: TRxGIFAnimator;
    ChatMes: TStaticText;
    RunPanel: TPanel;
    CS2: TClientSocket;
    TBCloseMesInfo: TToolBar;
    TBClosePanel: TToolButton;
    TimerReConnect: TTimer;
    RxGIFAnimator1: TRxGIFAnimator;
    Label1: TLabel;
    TBChosePlayer: TToolBar;
    TBPlayer2: TToolButton;
    TBPlayer0: TToolButton;
    TBPlayer1: TToolButton;
    TBPlayer3: TToolButton;
    TBPlayer4: TToolButton;
    TBPlayerPanelOpen: TToolBar;
    TBPlayer: TToolButton;
    ILChosePlayer: TImageList;
    TBPlayer5: TToolButton;
    TBPlayer6: TToolButton;
    TBPlayer7: TToolButton;
    TBPlayer8: TToolButton;
    PanelZoom: TPanel;
    LabelZoomer: TLabel;
    CBWBZoom: TComboBox;
    Image17: TImage;
    LabelMessage: TStaticText;
    ILBigMess: TImageList;
    BigMessage: TStaticText;
    ImageBigMess: TImage;
    TimerChangeBigMess: TTimer;
    ShowStreamInNewForm: TLabel;
    TimerCheckDL: TTimer;
    PanelColorForChat: TPanel;
    RzColorPickerChat: TRzColorPicker;
    PanelAddStream: TPanel;
    Panel1: TPanel;
    ToolBar1: TToolBar;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    LabelUserOnline: TLabel;
    LabelUserOnlineSchetchik: TLabel;
    procedure N4Click(Sender: TObject);
    procedure TrayMenuPopup(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N1Click(Sender: TObject);
    procedure CTIDblClick(Sender: TObject);
    procedure VSTGetImageIndexEx(Sender: TBaseVirtualTree;
      Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
      var Ghosted: Boolean; var IMG: Integer;
      var ImageListVST: TCustomImageList);
    procedure VSTDblClick(Sender: TObject);
    procedure VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; TextType: TVSTTextType;
      var CellText: WideString);
    procedure WBProgressChange(Sender: TObject; Progress,
      ProgressMax: Integer);
    procedure WBStatusTextChange(Sender: TObject; const Text: WideString);
    procedure VSTGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
      Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
      var HintText: WideString);
    procedure N5Click(Sender: TObject);
    procedure RefreshStreamListClick(Sender: TObject);
    procedure ShowStremListClick(Sender: TObject);
    procedure ShowChatClick(Sender: TObject);
    procedure ToolButtonPageRefreshClick(Sender: TObject);
    procedure WBDocumentComplete(Sender: TObject; const pDisp: IDispatch;
      var URL: OleVariant);
    procedure TimerStreamListRefreshTimer(Sender: TObject);
    procedure TimerPageRefreshTimer(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerKeyConnectedTimer(Sender: TObject);
    procedure ShowAboutFormClick(Sender: TObject);
    procedure SendPopupMessage(title, msg: string);
    procedure TimerUpdateStartTimer(Sender: TObject);
    procedure ToolButtonSettingsClick(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure ShowDownPanel2Click(Sender: TObject);
    procedure CS1Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CS1Connecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure CS1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CS1Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure EditMessageKeyPress(Sender: TObject; var Key: Char);
    procedure TBFormatBClick(Sender: TObject);
    procedure TBFormatIClick(Sender: TObject);
    procedure TBFormatUClick(Sender: TObject);
    procedure CS1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure TBFormatTireClick(Sender: TObject);
    procedure ChatEnabled(enabled: boolean);
    procedure TimerChatTimer(Sender: TObject);
    procedure TBColorTextClick(Sender: TObject);
    procedure TimerChatMesTimer(Sender: TObject);
    procedure TBClosePanelClick(Sender: TObject);
    procedure TimerReConnectTimer(Sender: TObject);
    procedure CS2Connect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CS2Disconnect(Sender: TObject; Socket: TCustomWinSocket);
    procedure CS2Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure CS2Connecting(Sender: TObject; Socket: TCustomWinSocket);
    procedure FormResize(Sender: TObject);
    procedure TBPlayerClick(Sender: TObject);
    procedure TBPlayer0Click(Sender: TObject);
    procedure TBPlayer1Click(Sender: TObject);
    procedure TBPlayer2Click(Sender: TObject);
    procedure TBPlayer3Click(Sender: TObject);
    procedure TBPlayer4Click(Sender: TObject);
    procedure TBPlayer5Click(Sender: TObject);
    procedure TBPlayer6Click(Sender: TObject);
    procedure TBPlayer7Click(Sender: TObject);
    procedure TBPlayer8Click(Sender: TObject);
    procedure SetSettings;
    procedure VSTResize(Sender: TObject);
    procedure CBWBZoomChange(Sender: TObject);
    procedure CS2Read(Sender: TObject; Socket: TCustomWinSocket);
    procedure TimerChangeBigMessTimer(Sender: TObject);
    procedure WBNewWindow2(Sender: TObject; var ppDisp: IDispatch;
      var Cancel: WordBool);
    procedure ShowStreamInNewFormClick(Sender: TObject);
    procedure TimerCheckDLTimer(Sender: TObject);
    procedure RzColorPickerChatChange(Sender: TObject);
    procedure TBAddStreamClick(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    { Private declarations }
    co:MyThread;
    co2:ThreadUpdate;
    function GetStyleNo(CommandChar: Char; Color: TColor; StyleNo: Integer): Integer;
    procedure ParseString(s: String);
    procedure DellFolder(Folder: string; FolderDel: boolean);
    procedure CheckNewVer;
    procedure HowMuchStream;
    procedure ConfimAddAutoRan(key: boolean);
    procedure LoadStreamList;
    procedure LoadProgPosition;
    procedure SaveProgPosition;
    function GetVerProg: string;
    procedure TBPlayerClickSend(ImgIndex, Tag: integer);
    function ColorToHTMLHexColor(Color: TColor): string;
  public
    { Public declarations }
  end;

var
  FormGeneral: TFormGeneral;
  KeyClose, KeyConnected, KeyOnTop, AlreadyStartPlaying, SoundStart, SoundAction, SoundExit,
ChatBanKey: boolean;
  KeyPOPUPStreamDL, KeyPOPUPOnOffChat: boolean;
  StreamKolVo, schet: integer;
  inifile: tinifile;
  SC2PlayerVersion, SoundStartFile, SoundActionFile, SoundExitFile, ChatNik: string;
  BigMessServer: array of array[0..1] of string;

implementation

uses AboutForm, PopupForm, SettingsForm, OnlyStreamForm, MyStreamForm,
  MessageForm;

{$R *.dfm}

{---------------------------- функции для чата begin --------------------------}
// TColor to RGB string
function GetColorStr(Color: TColor): String;
begin
  Result := IntToHex(ColorToRGB(Color),6);
  Result := Copy(Result,5,2)+Copy(Result,3,2)+Copy(Result,1,2);
end;
// RGB string to TColor
function GetStrColor(ColorValue: String): TColor;
var i,v: Integer;
begin
  ColorValue := Copy(ColorValue,5,2)+Copy(ColorValue,3,2)+Copy(ColorValue,1,2);
  Result := 0;
  for i := 1 to 6 do begin
    if ColorValue[i] in ['A'..'F'] then
      v := ord(ColorValue[i])-ord('A')+10
    else if ColorValue[i] in ['a'..'f'] then
      v := ord(ColorValue[i])-ord('a')+10
    else
      v := ord(ColorValue[i])-ord('0');
    Result := Result*16+v;
  end;
end;

function TFormGeneral.GetStyleNo(CommandChar: Char; Color: TColor;
  StyleNo: Integer): Integer;
var fi: TFontInfo;
begin
  fi := TFontInfo.Create(nil);
  fi.Assign(rvs.TextStyles[StyleNo]);
  case CommandChar of
    'b':
      if fsBold in fi.Style then
        fi.Style:= fi.Style-[fsBold]
      else
        fi.Style:= fi.Style+[fsBold];
    'i':
      if fsItalic in fi.Style then
        fi.Style:= fi.Style-[fsItalic]
      else
        fi.Style:= fi.Style+[fsItalic];
    'u':
      if fsUnderline in fi.Style then
        fi.Style:= fi.Style-[fsUnderline]
      else
        fi.Style:= fi.Style+[fsUnderline];
    's':
      if fsStrikeOut in fi.Style then
        fi.Style:= fi.Style-[fsStrikeOut]
      else
        fi.Style:= fi.Style+[fsStrikeOut];
    'c':
      if fi.Color<>Color then
      	fi.Color:= Color
         else
         fi.Color:= clNone;
    'k':
    	if fi.BackColor<>Color then
      fi.BackColor:= Color
      else
      fi.BackColor:= clNone;
  end;
  Result := rvs.TextStyles.FindSuchStyle(StyleNo, fi, RVAllFontInfoProperties);
  if Result<0 then begin
    rvs.TextStyles.Add;
    Result := rvs.TextStyles.Count-1;
    rvs.TextStyles[Result].Assign(fi);
    rvs.TextStyles[Result].Standard := False;
  end;
  fi.Free;
end;

procedure TFormGeneral.ParseString(s: String);
var i: Integer;
    ParaNo, StyleNo, StartIndex: Integer;
    CodeStarted: Boolean;
    ColorChar: Char;
    ColorValue: String;
    {..................................}
    procedure AddString(StartIndex, EndIndex: Integer);
    var str: String;
        i: Integer;
        BSDeleted: Boolean;
    begin
      if EndIndex>=StartIndex then begin
        str := Copy(s, StartIndex, EndIndex-StartIndex+1);
        BSDeleted := False;
        for i := Length(str) downto 1 do     // replacing '\\' with '\'
          if (str[i]='\') and (i>1) and (str[i-1]='\') and not BSDeleted then begin
            Delete(str, i, 1);
            BSDeleted := True;
            end
          else
            BSDeleted := False;
        RVChat.AddNL(str, StyleNo, ParaNo);
        ParaNo := -1;
      end;
    end;
    {..................................}
begin
  ParaNo := 0;
  CodeStarted := False;
  StyleNo := 0;
  StartIndex := 1;
  ColorChar := #0;
  for i := 1 to Length(s) do begin
    if (ColorChar<>#0) then begin
      if (s[i] in ['0'..'9', 'a'..'f', 'A'..'F']) then begin
        ColorValue := ColorValue + s[i];
        if Length(ColorValue)=6 then begin
          AddString(StartIndex, i-2-6);
          StartIndex := i+1;
          StyleNo := GetStyleNo(ColorChar, GetStrColor(ColorValue), StyleNo);
          ColorChar := #0;
        end;
        continue;
      end;
      ColorChar := #0;
    end;
    case s[i] of
      '\':
        CodeStarted := not CodeStarted;
      'b', 'u', 'i', 's', 'B', 'U', 'I', 'S':
        if CodeStarted then begin
          AddString(StartIndex, i-2);
          StartIndex := i+1;
          StyleNo := GetStyleNo(LowerCase(s[i])[1], clNone, StyleNo);
          CodeStarted := False;
        end;
      'c', 'C', 'k', 'K':
        if CodeStarted then begin
          ColorChar := LowerCase(s[i])[1];
          ColorValue := '';
          CodeStarted := False;
        end;
    end;
  end;
  AddString(StartIndex, Length(s));
end;
{---------------------------- функции для чата end ----------------------------}

{------------------- Сохранение/Восстановление позиции begin ------------------}
procedure TFormGeneral.SaveProgPosition;
var
FIniFile: TRegIniFile;
begin
FIniFile := TRegIniFile.Create('SC2Player'); // Инициализирую реестр
FIniFile.OpenKey('SC2Player',true); // Открываю раздел
FIniFile.OpenKey('SC2Player-PositionMain',true); // Открываю ещё один раздел
if WindowState=wsNormal then
begin
FIniFile.WriteInteger('Option', 'Left', Left);
FIniFile.WriteInteger('Option', 'Top', Top);
end;
FIniFile.WriteInteger('Option', 'WinState', Integer(WindowState));
FIniFile.Free;
end;

procedure TFormGeneral.LoadProgPosition;
var
FIniFile: TRegIniFile;
begin
FIniFile := TRegIniFile.Create('SC2Player');
FIniFile.OpenKey('SC2Player',true);
FIniFile.OpenKey('SC2Player-PositionMain',true);
Left:=FIniFile.ReadInteger('Option', 'Left', 100);
Top:=FIniFile.ReadInteger('Option', 'Top', 100);
WindowState:=TWindowState(FIniFile.ReadInteger('Option', 'WinState', 2));
FIniFile.Free;
end;
{------------------- Сохранение/Восстановление позиции end-- ------------------}

function TFormGeneral.GetVerProg: string;
type
TVerInfo=packed record
Nevazhno: array[0..47] of byte; // ненужные нам 48 байт
Minor,Major,Build,Release: word; // а тут версия
end;
var
s:TResourceStream;
v:TVerInfo;
begin
result:='';
	try
	s:=TResourceStream.Create(HInstance ,'#1',RT_VERSION); // достаём ресурс
	if s.Size>0 then
	 	begin
	 	s.Read(v,SizeOf(v)); // читаем нужные нам байты
		result:=IntToStr(v.Major)+'.'+IntToStr(v.Minor)+'.'+ // вот и версия...
		IntToStr(v.Release)+'.'+IntToStr(v. Build);
		end;
	s.Free;
	except;
	end;
end;

procedure TFormGeneral.DellFolder(Folder: string; FolderDel: boolean);
var
Found: integer;
SearchRec: TSearchRec;
begin
if DirectoryExists(Folder+'\')<>True then
	exit;
Found:= FindFirst(Folder+'\*.*', faAnyFile, SearchRec);
while Found = 0 do
begin
  if (SearchRec.name <> '.') and (SearchRec.name <> '..') then
    if (SearchRec.Attr and faDirectory) <> 0 then
    begin
    	if RemoveDir(Folder+'\'+SearchRec.name) then continue
      else
      begin
      DellFolder(Folder+'\'+SearchRec.name, true);
      end;
    end
    else
    begin
    	DeleteFile(Folder+'\'+SearchRec.name);
    end;
Found:= FindNext(SearchRec);
end;
FindClose(SearchRec);
if FolderDel=true then
	RemoveDir(Folder);
end;

procedure TFormGeneral.CheckNewVer;
begin
 co2:=ThreadUpdate.Create(true);
 co2.Resume;
 co2.Priority:=tpIdle;
end;

procedure TFormGeneral.HowMuchStream;
begin
TimerCheckDL.Enabled:= true;
 co:=MyThread.Create(true);
 co.Resume;
 co.Priority:=tpIdle;
end;

function TFormGeneral.ColorToHTMLHexColor(Color: TColor): string;
var
rgbcolor: TColorRef;
begin
rgbcolor:= ColorToRGB(Color);
result:= format('%.2x%.2x%.2x',[getrvalue(rgbcolor),getgvalue(rgbcolor),getbvalue(rgbcolor)]);
end; 

procedure TFormGeneral.ConfimAddAutoRan(key: boolean);
begin
inifile.WriteBool('Main Settings', 'KeyQvestion', true);
if key then
	begin
   inifile.WriteBool('Main Settings', 'AutoRan', true);
   FormSettings.AutoRan(true);
   end
   else
	begin
   inifile.WriteBool('Main Settings', 'AutoRan', false);
   FormSettings.AutoRan(false);
   end;
end;

procedure TFormGeneral.SetSettings;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'Config.ini');
//.............................................................. Вкладка "Общее"

//.......................................................... Вкладка "Интерфейс"
VST.Font.Style:= [];
if inifile.ReadBool('Interface Settings', 'StrimListBold', false) then
	VST.Font.Style:= [fsBold];
if inifile.ReadBool('Interface Settings', 'StrimListItalic', false) then
   VST.Font.Style:= VST.Font.Style+[fsItalic];
if inifile.ReadBool('Interface Settings', 'StrimListUnderline', false) then
	VST.Font.Style:= VST.Font.Style+[fsUnderline];
VST.Font.Color:= StringToColor(inifile.ReadString('Interface Settings', 'StrimListTextColor', 'clBlack'));
//........................................................ Вкладка "Уведемления"
KeyPOPUPStreamDL:= inifile.ReadBool('Action Settings', 'SeePopup0', true);
KeyPOPUPOnOffChat:= inifile.ReadBool('Action Settings', 'SeePopup1', true);
//.............................................................. Вкладка "Звуки"
SoundStart:= inifile.ReadBool('Sound Settings', 'SoundStartKey', true);
SoundAction:= inifile.ReadBool('Sound Settings', 'SoundActionKey', true);
SoundExit:= inifile.ReadBool('Sound Settings', 'SoundExitKey', true);
SoundStartFile:= inifile.ReadString('Sound Settings', 'SoundStartFile', extractfilepath(application.ExeName)+'sound\start.wav');
SoundActionFile:= inifile.ReadString('Sound Settings', 'SoundActionFile', extractfilepath(application.ExeName)+'sound\popupmessage.wav');
SoundExitFile:= inifile.ReadString('Sound Settings', 'SoundExitFile', extractfilepath(application.ExeName)+'sound\exit.wav');
//................................................................ Вкладка "Чат"
ChatNik:= inifile.ReadString('Chat Settings', 'Nik', '');
CS1.Host:= inifile.ReadString('Chat Settings', 'Server', '82.209.91.11');
CS2.Host:= CS1.Host;
CS1.Port:= inifile.ReadInteger('Chat Settings', 'Port', 20000);
inifile.Free;
end;

procedure TFormGeneral.SendPopupMessage(title, msg: string);
begin
if KeyPOPUPStreamDL then
	if FormPopUp.Showing<>true then
		begin
		MesTitle:= title;
		MesMessage:= msg;
		FormPopUp.Show
   	end
   	else
   	begin
   	FormPopUp.Hide;
		MesTitle:= title;
		MesMessage:= msg;
		FormPopUp.Show
   	end;
end;

procedure TFormGeneral.LoadStreamList;
var
  i, t: LongInt;
  NewNode: PVirtualNode;
  NewSL: PSLNode;
begin
PanelStatus.Caption:= 'Загружаем информацию о стримах...';
VST.Clear;
for i:=1 to StreamKolVo do
begin
 if fileexists(extractfilepath(application.ExeName)+'stream\_'+IntToStr(i)+'.ini') then
 begin
	inifile:=tinifile.Create(extractfilepath(application.ExeName)+'stream\_'+IntToStr(i)+'.ini');
	StreamKolVo:= inifile.ReadInteger('General', 'Stream', 2);
		NewNode := VST.AddChild(nil);
		NewSL := VST.GetNodeData(NewNode);
			if Assigned(NewSL) then
			with NewSL^ do
				begin
            //..................................................................
	         IMG:= inifile.ReadInteger('General', 'ImgGame', 0);
	         Country:= inifile.ReadInteger('General', 'Country', 0);
            AllStr:= inifile.ReadInteger('General', 'KolVoStream', 0);
            SetLength(FHeight, AllStr);
            SetLength(FWidth, AllStr);
            SetLength(Url, AllStr);
            SetLength(Hint, AllStr);
            //..................................................................
				SN:= inifile.ReadString('StreamInfo', 'StreamName', 'None');
	         MainHint:= inifile.ReadString('StreamInfo', 'Hint', 'none');
	         Site:= inifile.ReadString('StreamInfo', 'Site', 'none');
            //..................................................................
            for t:=0 to AllStr-1 do
            	begin
            	FHeight[t]:= inifile.ReadInteger('Stream', 'Height_'+IntToStr(t), 500);
	         	FWidth[t]:= inifile.ReadInteger('Stream', 'Width_'+IntToStr(t), 800);
               Url[t]:= 'http://sc2player.do.am/stream/'+inifile.ReadString('Stream', 'Stream_'+IntToStr(t), 'none')+'.html';
               Hint[t]:= inifile.ReadString('Stream', 'Hint_'+IntToStr(t), 'none');
               end;
				end;
	inifile.Free;
	ProgressBar.Position:= ProgressBar.Position+10;
 end;
end;
co.Terminate;
PanelStatus.Caption:= '';
ProgressBar.Position:= 0;
end;

procedure TFormGeneral.N4Click(Sender: TObject);
begin
KeyClose:= true;
Close;
end;

procedure TFormGeneral.TrayMenuPopup(Sender: TObject);
begin
if Showing then
    N1.Caption:= 'Скрыть'
else
    N1.Caption:= 'Показать';
end;

procedure TFormGeneral.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose:= KeyClose;
  if not CanClose then
	Hide
end;

procedure TFormGeneral.N1Click(Sender: TObject);
begin
if Showing then
	Hide
else
	Show;
end;

procedure TFormGeneral.CTIDblClick(Sender: TObject);
begin
if Showing then
	Hide
else
	Show;
end;

procedure TFormGeneral.VSTGetImageIndexEx(Sender: TBaseVirtualTree;
  Node: PVirtualNode; Kind: TVTImageKind; Column: TColumnIndex;
  var Ghosted: Boolean; var IMG: Integer;
  var ImageListVST: TCustomImageList);
var
  SLNode: PSLNode;
  //ImageListVST2: TCustomImageList;
begin
  SLNode := VST.GetNodeData(Node);
  if Assigned(SLNode) then
  begin
		case Column of
		0: IMG:= SLNode^.IMG;
      1: IMG:= SLNode^.Country;
      end;
    //ImageListVST := Self.ImageListVST;
    //IMG := SLNode^.IMG;
  end;
end;

procedure TFormGeneral.VSTDblClick(Sender: TObject);
var
NewSL: PSLNode;
i: integer;
begin
CBWBZoom.Enabled:= false;
NewSL := VST.GetNodeData(VST.FocusedNode);
if (VST.FocusedNode<>nil) then
begin
TBPlayer.Down:= false;
TBPlayer.ImageIndex:= 0;
TBChosePlayer.Visible:= false;
//////////////////////////////////////////// убирам все кнопки в инвиз begin
for i:=1 to 8 do
	begin
	TBChosePlayer.Buttons[i].Visible:= false;
	end;
//////////////////////////////////////////// убирам все кнопки в инвиз end
   TBPlayer.Enabled:= true;
	WB.Navigate(NewSL.Url[0]);
/////////////////////////////////////////////////////// Для OnlyStreamForm begin
StreamLink:= NewSL.Url[0];
WindowHeight:= NewSL.FHeight[0];
WindowWidth:= NewSL.FWidth[0];
StreamUrlNotFile:= true;
/////////////////////////////////////////////////////// Для OnlyStreamForm end
   Height:= NewSL.FHeight[0]+99; // +99
   Width:= NewSL.FWidth[0]+16;   // +287
   if LeftPanel.Visible then
   	Width:= Width+LeftPanel.Width;
   if RightPanel.Visible then
   	Width:= Width+RightPanel.Width;
   if RunPanel.Visible then
   	Height:= Height+RunPanel.Height;
   if DownPanel2.Visible then
   	Height:= Height+DownPanel2.Height;
   if NewSL.AllStr>1 then
		begin
   	for i:=0 to NewSL.AllStr-1 do
   		begin
      	TBChosePlayer.Buttons[i].Visible:= true;
      	TBChosePlayer.Buttons[i].Hint:= NewSL.Hint[i];
      	end;
   	end;
	end;
CBWBZoom.ItemIndex:= 7;
end;

procedure TFormGeneral.VSTGetText(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; TextType: TVSTTextType; var CellText: WideString);
var
  SLNode: PSLNode;
begin
  SLNode := Sender.GetNodeData(Node);
  if Assigned(SLNode) then
    case Column of
      2: CellText := SLNode^.SN;
    end;
end;

procedure TFormGeneral.WBProgressChange(Sender: TObject; Progress,
  ProgressMax: Integer);
begin
  Progressbar.Max := Progressmax;
  Progressbar.Position := Progress;
end;

procedure TFormGeneral.WBStatusTextChange(Sender: TObject;
  const Text: WideString);
begin
PanelStatus.Caption:= Text;
end;

procedure TFormGeneral.VSTGetHint(Sender: TBaseVirtualTree; Node: PVirtualNode;
  Column: TColumnIndex; var LineBreakStyle: TVTTooltipLineBreakStyle;
  var HintText: WideString);
var
NewSL: PSLNode;
begin
NewSL := VST.GetNodeData(Node);
HintText := NewSL.MainHint;
end;

procedure TFormGeneral.N5Click(Sender: TObject);
var
NewSL: PSLNode;
begin
NewSL := VST.GetNodeData(VST.FocusedNode);
if (VST.FocusedNode<>nil) then
	ShellExecute(Handle, 'open', PChar(NewSL.Site), nil, nil, SW_SHOW);
end;

procedure TFormGeneral.RefreshStreamListClick(Sender: TObject);
begin
if DirectoryExists(extractfilepath(application.ExeName)+'/stream')<>true then
	begin
	FormMessage.SetSettingsFromOther('Ошибка', 'Ошибка целостности программы', 'Отсутствует директория "stream".', 'Ок', '-', true, false, 3);
	FormMessage.ShowModal;
   end;
if TimerStreamListRefresh.Enabled<>true then
	begin
      KeyConnected:= false;
		HowMuchStream;
		TimerKeyConnected.Enabled:= true;
		TimerStreamListRefresh.Enabled:= true;
   end
   else
   begin
   FormMessage.SetSettingsFromOther('Антифлуд', 'Слишком частые обновления', 'Не нужно так часто кликать на обновление, стримы не появляются каждую секунду новые.', 'Ок', '-', true, false, 3);
	FormMessage.ShowModal;
   end;
end;

procedure TFormGeneral.ShowStremListClick(Sender: TObject);
begin
RightPanel.Visible:= ShowStremList.Down;
if RightPanel.Visible then
	Width:= Width+RightPanel.Width
else
   Width:= Width-RightPanel.Width;
end;

procedure TFormGeneral.ShowChatClick(Sender: TObject);
begin
if ChatBanKey<>true then
	begin
	if (Length(ChatNik)<3) OR (Length(ChatNik)>15) then
		begin
      FormMessage.SetSettingsFromOther('Чат', 'Введите свой ник', 'Необходимо в Настройках -> Чат заполнить поле "ник".', 'Ок', '-', true, false, 3);
		FormMessage.ShowModal;
   	ShowChat.Down:= false;
   	exit;
   	end;
	LeftPanel.Visible:= ShowChat.Down;
	if LeftPanel.Visible then
		begin
   	ChatMes.Caption:= 'Подключение...';
   	CS1.Active:= true;  //активировать коннект с сервером
		Width:= Width+LeftPanel.Width;
   	end
		else
   	begin
   	CS1.Active := False; // Выключаем клиента
   	Width:= Width-LeftPanel.Width;
   	RVChat.Clear;
   	end;
	end
else
	begin
   ShowChat.Down:= false;
   FormMessage.SetSettingsFromOther('Чат', 'Вы были забанены', 'Вы были забанены админом сервера.', 'Ок', '-', true, false, 3);
	FormMessage.ShowModal;
   end;
end;

procedure TFormGeneral.ToolButtonPageRefreshClick(Sender: TObject);
begin
if TimerPageRefresh.Enabled<>true then
	begin
	TimerPageRefresh.Enabled:= true;
	if Length(WB.LocationURL)>0 then
		WB.Refresh;
	end
   else
   begin
   FormMessage.SetSettingsFromOther('Антифлуд', 'Слишком частые обновления', 'Не нужно так часто кликать на обновление, все-равно плеер сам обновиться.', 'Ок', '-', true, false, 3);
	FormMessage.ShowModal;
   end;
end;

procedure TFormGeneral.WBDocumentComplete(Sender: TObject;
  const pDisp: IDispatch; var URL: OleVariant);
begin
Caption:= 'SC2 Player ['+WB.LocationName+']';
//////////////////////////////////////////// Прячем скролбары браузера begin
WB.OleObject.Document.Body.Style.OverflowX := 'hidden';
WB.OleObject.Document.Body.Style.OverflowY := 'hidden';
//////////////////////////////////////////// Прячем скролбары браузера end
CBWBZoom.Enabled:= true;
end;

procedure TFormGeneral.TimerStreamListRefreshTimer(Sender: TObject);
begin
TimerStreamListRefresh.Enabled:= false;
end;

procedure TFormGeneral.TimerPageRefreshTimer(Sender: TObject);
begin
TimerPageRefresh.Enabled:= false;
end;

procedure TFormGeneral.FormCreate(Sender: TObject);
begin
AlreadyStartPlaying:= false;
ChatBanKey:= false;
CTI.HideTaskbarIcon;
VST.NodeDataSize := SizeOf(TSLNode);
KeyClose:= false;
CTI.Hint:= 'SC2 Player';
KeyConnected:= false;
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'Config.ini');
if inifile.ReadBool('Main Settings', 'OnTop', false) then
	FormStyle:= fsStayOnTop;
inifile.Free;
{.......... ранее было в OnShow .........}
SC2PlayerVersion:= GetVerProg;
SetSettings;
LoadProgPosition;
if SoundStart AND fileexists(SoundStartFile) AND not AlreadyStartPlaying then
	SndPlaySound(PChar(SoundStartFile), SND_ASYNC);
AlreadyStartPlaying:= true;
if DirectoryExists(extractfilepath(application.ExeName)+'/stream')<>true then
	begin
   FormMessage.SetSettingsFromOther('Ошибка', 'Ошибка целостности программы', 'Отсутствует директория "stream".', 'Ок', '-', true, false, 3);
	FormMessage.ShowModal;
   end;
if KeyConnected<>true then
	begin
	HowMuchStream;
	TimerKeyConnected.Enabled:= true;
	TimerStreamListRefresh.Enabled:= true;
	end;
TBPlayerPanelOpen.Left:= 0;
TBChosePlayer.Left:= 0;
schet:= 0;
end;

procedure TFormGeneral.TimerKeyConnectedTimer(Sender: TObject);
begin
if KeyConnected=true then
	begin
	TimerKeyConnected.Enabled:= false;
	LoadStreamList;
   DellFolder(extractfilepath(application.ExeName)+'\stream', false);
   DeleteFile(extractfilepath(application.ExeName)+'\stream.ini');
   SendPopupMessage('Системное сообщение', 'Список стримов загружен.');
   TimerReConnect.Enabled:= true;
   CheckNewVer;
   end;
end;

procedure TFormGeneral.ShowAboutFormClick(Sender: TObject);
begin
FormAbout.ShowModal;
end;

procedure TFormGeneral.TimerUpdateStartTimer(Sender: TObject);
begin
TimerUpdateStart.Enabled:= false;
FormMessage.SetSettingsFromOther('Обновление', 'Доступно обновление', 'На сервере присутствует новая версия. Желаете обновить клиент?', 'Да', 'Нет', true, true, 0);
if FormMessage.ShowModal=mrOk then
	begin
   if fileexists(extractfilepath(application.ExeName)+'update.exe') then
   	begin
   	ShellExecute(Handle, nil, PChar(extractfilepath(application.ExeName)+'update.exe'), nil, nil, SW_RESTORE);
      KeyClose:= true;
      Close;
      end
   	else
      begin
      FormMessage.SetSettingsFromOther('Ошибка', 'Ошибка целостности программы', 'update.exe не найден, обновление невозможно.', 'Ок', '-', true, false, 3);
		FormMessage.ShowModal;
   	end;
   end;
end;

procedure TFormGeneral.ToolButtonSettingsClick(Sender: TObject);
begin
FormSettings.Show;
end;

procedure TFormGeneral.N2Click(Sender: TObject);
begin
FormSettings.Show;
end;

procedure TFormGeneral.ShowDownPanel2Click(Sender: TObject);
begin
DownPanel2.Visible:= ShowDownPanel2.Down;
if DownPanel2.Visible then
	begin
   TimerChangeBigMess.Enabled:= true;
	Height:= Height+DownPanel2.Height;
   DownPanel.Height:=DownPanel.Height+DownPanel2.Height
   end
	else
   begin
   TimerChangeBigMess.Enabled:= false;
   Height:= Height-DownPanel2.Height;
   DownPanel.Height:=DownPanel.Height-DownPanel2.Height
   end;
end;

procedure TFormGeneral.CS1Connect(Sender: TObject; Socket: TCustomWinSocket);
begin
ChatMes.Caption:= 'Подключение к серверу прошло успешно.';
CS1.Tag:= 1;
TimerChat.Enabled:= true;
end;

procedure TFormGeneral.CS1Connecting(Sender: TObject; Socket: TCustomWinSocket);
begin
ChatMes.Caption:= 'Подключение к серверу.';
end;

procedure TFormGeneral.CS1Disconnect(Sender: TObject; Socket: TCustomWinSocket);
begin
if CS1.Active=true then
	begin
   ChatEnabled(false);
   PanelChatConnecting.Visible:= true;
	ChatMes.Caption:= 'Cервер переключился в режим offline, сожалеем.';
	CS1.Tag:= 2;
	TimerChat.Enabled:= true;
	CS1.Active:= false;
   end;
end;

procedure TFormGeneral.CS1Read(Sender: TObject; Socket: TCustomWinSocket);
var
str, PromegStr: string;
begin
str:= CS1.Socket.ReceiveText;
if copy(str, 0, 5)='#onl#' then // "online" - сколько пользователей в сети.
	begin
   LabelChatUserOnline.Caption:= copy(str, 7, Length(str));
   end
else if copy(str, 0, 5)='#pme#' then // "personal message" - приватное сообщение.
	begin
   PromegStr:= '\k000000\cFFFFFFPM\cFFFFFF\k000000'+copy(str, 7, Length(str));
   ParseString(PromegStr);
	RVChat.FormatTail;
	RVChat.Update;
   end
else if copy(str, 0, 5)='#ban#' then // "ban" - бан данного клиента
	begin
   ChatBanKey:= true;
   CS1.Tag:= 3;
   TimerChat.Enabled:= true;
   end
else if copy(str, 0, 5)='#anb#' then // "anban" - разбан данного клиента
	begin
   ChatBanKey:= false;
   CS1.Tag:= 0;
   TimerChat.Enabled:= true;
   end
else
	begin
	ParseString(str);
	RVChat.FormatTail;
	RVChat.Update;
	end;
end;

procedure TFormGeneral.FormClose(Sender: TObject; var Action: TCloseAction);
begin
if SoundExit AND fileexists(SoundExitFile) then
	SndPlaySound('D:\Programming\delfi\__sc2tv_player\sound\exit.wav', SND_ASYNC);
SaveProgPosition;
Sleep(1000);
end;

procedure TFormGeneral.EditMessageKeyPress(Sender: TObject; var Key: Char);
begin
if (key=#13) then
	begin
	if TimerChatMes.Enabled<>true then
		begin
		CS1.Socket.SendText('\b'+ChatNik+'\b: '+EditMessage.Text);
		EditMessage.Clear;
		TimerChatMes.Enabled:= true;
		Key:=#0;
   	end
   else
   	begin
      FormMessage.SetSettingsFromOther('Чат', 'Антифлуд', 'Не нужно так часто отсылать сообщения.', 'Ок', '-', true, false, 3);
		FormMessage.ShowModal;
   	end;
   end;
end;

procedure TFormGeneral.TBFormatBClick(Sender: TObject);
begin
EditMessage.SelText:= '\b'+EditMessage.SelText+'\b';
end;

procedure TFormGeneral.TBFormatIClick(Sender: TObject);
begin
EditMessage.SelText:= '\i'+EditMessage.SelText+'\i';
end;

procedure TFormGeneral.TBFormatUClick(Sender: TObject);
begin
EditMessage.SelText:= '\u'+EditMessage.SelText+'\u';
end;

procedure TFormGeneral.CS1Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
CS1.Tag:= 0;
ChatEnabled(false);
ChatMes.Caption:= 'Неудалось подключиться. Возможно сервер отключен. Номер ошибки '+IntToStr(ErrorCode);
TimerChat.Enabled:= true;
ErrorCode:=0;
end;

procedure TFormGeneral.TBFormatTireClick(Sender: TObject);
begin
EditMessage.SelText:= '\s'+EditMessage.SelText+'\s';
end;

procedure TFormGeneral.ChatEnabled(enabled: boolean);
begin
if enabled then
	begin
   TBColorText.Enabled:= true;
   TBFormatTire.Enabled:= true;
   TBFormatU.Enabled:= true;
   TBFormatB.Enabled:= true;
   TBFormatI.Enabled:= true;
   EditMessage.Enabled:= true;
   end
   else if enabled<>true then
   begin
   TBColorText.Enabled:= false;
   TBFormatTire.Enabled:= false;
   TBFormatU.Enabled:= false;
   TBFormatB.Enabled:= false;
   TBFormatI.Enabled:= false;
   EditMessage.Enabled:= false;
   end;
end;

procedure TFormGeneral.TimerChatTimer(Sender: TObject);
begin
// tag=0 - Сервер отключен.
// tag=1 - Мы подключились.
// tag=2 - Сервер отключился.
// tag=3 - Клиент забанен.
if CS1.tag=0 then
	begin
	LeftPanel.Visible:= false;
	ShowChat.Down:= false;
	Width:= Width-LeftPanel.Width;
	TimerChat.Enabled:= false;
	CS1.Active := False;
   ChatEnabled(false);
   if KeyPOPUPOnOffChat then
   	SendPopupMessage('Системное сообщение - чат', 'Сервер отключен');
   end;
if CS1.tag=1 then
	begin
   PanelChatConnecting.Visible:= false;
	TimerChat.Enabled:= false;
   ChatEnabled(true);
   if KeyPOPUPOnOffChat then
   	SendPopupMessage('Системное сообщение - чат', 'Чат подключен');
   end;
if CS1.tag=2 then
	begin
	LeftPanel.Visible:= false;
	ShowChat.Down:= false;
	Width:= Width-LeftPanel.Width;
	TimerChat.Enabled:= false;
	CS1.Active := False;
   ChatEnabled(false);
   if KeyPOPUPOnOffChat then
   	SendPopupMessage('Системное сообщение - чат', 'Сервер отключился');
   end;
if CS1.tag=3 then
	begin
	LeftPanel.Visible:= false;
	ShowChat.Down:= false;
	Width:= Width-LeftPanel.Width;
	TimerChat.Enabled:= false;
	CS1.Active := False;
   ChatEnabled(false);
   if KeyPOPUPOnOffChat then
   	SendPopupMessage('Системное сообщение - чат', 'Вы были забанены админом сервера.');
   end;
end;

procedure TFormGeneral.TBColorTextClick(Sender: TObject);
begin
if PanelColorForChat.Visible then
	PanelColorForChat.Visible:= false
   else
   PanelColorForChat.Visible:= true;
end;

procedure TFormGeneral.TimerChatMesTimer(Sender: TObject);
begin
TimerChatMes.Enabled:= false;
end;

procedure TFormGeneral.TBClosePanelClick(Sender: TObject);
begin
Height:= Height-RunPanel.Height;
RunPanel.Visible:= false;
end;

procedure TFormGeneral.TimerReConnectTimer(Sender: TObject);
begin
CS2.Active:= true;
TimerReConnect.Interval:= 300000;
end;

procedure TFormGeneral.CS2Connect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
TimerReConnect.Enabled:= false;
end;

procedure TFormGeneral.CS2Disconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
CS2.Active:= false;
TimerReConnect.Enabled:= true;
end;

procedure TFormGeneral.CS2Error(Sender: TObject; Socket: TCustomWinSocket;
  ErrorEvent: TErrorEvent; var ErrorCode: Integer);
begin
ErrorCode:= 0;
CS2.Active:= false;
TimerReConnect.Enabled:= true;
end;

procedure TFormGeneral.CS2Read(Sender: TObject; Socket: TCustomWinSocket);
var
Pr1, Pr2: integer;
PeremMes, str, Variable: string;
begin
str:= CS2.Socket.ReceiveText;
Variable:= copy(str, 2, 7);
if Variable='message' then
	begin
	Pr1:= StrToInt(copy(str, 10, 1)); // нужно ли выводить popup
	PeremMes:= copy(str, 16, Length(str));
	if Pr1=1 then
		SendPopupMessage('Сообщение от сервера', PeremMes);
	if RunPanel.Visible<>true then
   	Height:= Height+RunPanel.Height;
	RunPanel.Visible:= true;
	LabelMessage.Caption:= PeremMes;
	LabelMessage.Hint:= PeremMes;
   end
else if Variable='bigmess' then
	begin
   Pr1:= StrToInt(copy(str, 12, 1)); // # message
   Pr2:= StrToInt(copy(str, 14, 1)); // image
   if length(BigMessServer)<Pr1+1 then
   	SetLength(BigMessServer, Pr1+1);
   BigMessServer[Pr1][0]:= IntToStr(Pr2);
   BigMessServer[Pr1][1]:= copy(str, 16, Length(str));
   if DownPanel2.Visible then
   	TimerChangeBigMess.Enabled:= true;
   end
else if Variable='onluser' then
	begin
   LabelUserOnlineSchetchik.Caption:= copy(str, 16, Length(str));
   end;
end;

procedure TFormGeneral.CS2Connecting(Sender: TObject;
  Socket: TCustomWinSocket);
begin
CS2.Active:= false;
TimerReConnect.Enabled:= true;
end;

procedure TFormGeneral.FormResize(Sender: TObject);
begin
Label1.Caption:= 'WB.Height='+IntToStr(WB.Height)+'   WB.Width='+IntToStr(WB.Width)+'______   Height='+IntToStr(Height)+'   Width='+IntToStr(Width);
//Label1.Caption:= 'Height='+IntToStr(Height)+'   Width='+IntToStr(Width);
{ Height: + 99
  Width:  + 257 }
end;

procedure TFormGeneral.TBPlayerClick(Sender: TObject);
begin
if TBPlayer.Down then
	TBChosePlayer.Visible:= true
   else
   TBChosePlayer.Visible:= false;
end;

procedure TFormGeneral.TBPlayerClickSend(ImgIndex, Tag: integer);
var
NewSL: PSLNode;
begin
CBWBZoom.Enabled:= false;
NewSL := VST.GetNodeData(VST.FocusedNode);
TBChosePlayer.Visible:= false;
WB.Navigate(NewSL.Url[Tag]);
/////////////////////////////////////////////////////// Для OnlyStreamForm begin
StreamLink:= NewSL.Url[Tag];
WindowHeight:= NewSL.FHeight[Tag];
WindowWidth:= NewSL.FWidth[Tag];
StreamUrlNotFile:= true;
/////////////////////////////////////////////////////// Для OnlyStreamForm end
TBPlayer.Down:= false;
TBPlayer.ImageIndex:= ImgIndex;
//Height:= NewSL.FHeight[Tag]+99;
//Width:= NewSL.FWidth[Tag]+287;
   Height:= NewSL.FHeight[Tag]+99; // +99
   Width:= NewSL.FWidth[Tag]+15;   // +287
   if LeftPanel.Visible then
   	Width:= Width+LeftPanel.Width;
   if RightPanel.Visible then
   	Width:= Width+RightPanel.Width;
   if RunPanel.Visible then
   	Height:= Height+RunPanel.Height;
   if DownPanel2.Visible then
   	Height:= Height+DownPanel2.Height;
end;

procedure TFormGeneral.TBPlayer0Click(Sender: TObject);
begin
TBPlayerClickSend(TBPlayer0.ImageIndex, TBPlayer0.Tag);
end;

procedure TFormGeneral.TBPlayer1Click(Sender: TObject);
begin
TBPlayerClickSend(TBPlayer1.ImageIndex, TBPlayer1.Tag);
end;

procedure TFormGeneral.TBPlayer2Click(Sender: TObject);
begin
TBPlayerClickSend(TBPlayer2.ImageIndex, TBPlayer2.Tag);
end;

procedure TFormGeneral.TBPlayer3Click(Sender: TObject);
begin
TBPlayerClickSend(TBPlayer3.ImageIndex, TBPlayer3.Tag);
end;

procedure TFormGeneral.TBPlayer4Click(Sender: TObject);
begin
TBPlayerClickSend(TBPlayer4.ImageIndex, TBPlayer4.Tag);
end;

procedure TFormGeneral.TBPlayer5Click(Sender: TObject);
begin
TBPlayerClickSend(TBPlayer5.ImageIndex, TBPlayer5.Tag);
end;

procedure TFormGeneral.TBPlayer6Click(Sender: TObject);
begin
TBPlayerClickSend(TBPlayer6.ImageIndex, TBPlayer6.Tag);
end;

procedure TFormGeneral.TBPlayer7Click(Sender: TObject);
begin
TBPlayerClickSend(TBPlayer7.ImageIndex, TBPlayer7.Tag);
end;

procedure TFormGeneral.TBPlayer8Click(Sender: TObject);
begin
TBPlayerClickSend(TBPlayer8.ImageIndex, TBPlayer8.Tag);
end;

procedure TFormGeneral.VSTResize(Sender: TObject);
begin
	VST.BackgroundOffsetX := (VST.Width div 2) - (VST.Background.Width div 2);
	VST.BackgroundOffsetY := (VST.Height div 2) - (VST.Background.Height div 2);
end;

procedure TFormGeneral.CBWBZoomChange(Sender: TObject);
begin
	WB.OleObject.Document.Body.Style.Zoom:= StrToInt(CBWBZoom.Items[CBWBZoom.ItemIndex])/100;
end;

procedure TFormGeneral.TimerChangeBigMessTimer(Sender: TObject);
begin
if Length(BigMessServer[0][1])>5 then
	begin
	if schet>Length(BigMessServer)-1 then
		schet:= 0;
	BigMessage.Caption:= BigMessServer[schet][1];
	ILBigMess.GetBitmap(StrToInt(BigMessServer[schet][0]), ImageBigMess.Picture.Bitmap);
	ImageBigMess.Refresh;
	schet:= schet+1;
	TimerChangeBigMess.Interval:= 20000;
	end;
end;

procedure TFormGeneral.WBNewWindow2(Sender: TObject; var ppDisp: IDispatch;
  var Cancel: WordBool);
begin
Cancel:=True;
end;

procedure TFormGeneral.ShowStreamInNewFormClick(Sender: TObject);
begin
if StreamForm.Showing then
	StreamForm.Close;
if CBWBZoom.Enabled then
	StreamForm.Show;
end;

procedure TFormGeneral.TimerCheckDLTimer(Sender: TObject);
begin
TimerCheckDL.Enabled:= false;
co.Terminate;
FormMessage.SetSettingsFromOther('Загрузка', 'Загрузка списка стримов', 'Невозможно загрузить информацию о стримах. Проверьте подключение к интернету. Желаете повторить попытку?', 'Да', 'Нет', true, true, 1);
if FormMessage.ShowModal=mrOk then
	begin
    co:=MyThread.Create(true);
 	 co.Resume;
 	 co.Priority:=tpIdle;
   TimerCheckDL.Enabled:= true;
   end;
end;

procedure TFormGeneral.RzColorPickerChatChange(Sender: TObject);
var
Color: string;
begin
PanelColorForChat.Visible:= false;
Color:= ColorToHTMLHexColor(RzColorPickerChat.SelectedColor);
EditMessage.SelText:= '\c'+Color+EditMessage.SelText+'\c'+Color;
end;

procedure TFormGeneral.TBAddStreamClick(Sender: TObject);
begin
FormMyStream.Show;
end;

procedure TFormGeneral.ToolButton1Click(Sender: TObject);
begin
StreamUrlNotFile:= false;
if StreamForm.Showing then
	StreamForm.Close;
if FileExists(extractfilepath(application.ExeName)+'MyStream.html') then
	StreamForm.Show
   else
   begin
	FormMessage.SetSettingsFromOther('Свой стрим', 'Воспроизведение своего плеера', 'Вы еще не добавляли собственных проигрывателей.', 'Ок', '-', true, false, 0);
	FormMessage.ShowModal;
   end;
end;

procedure TFormGeneral.FormShow(Sender: TObject);
begin
//....................... Проверка на вопрос о "Добавлен ли плеер в автозапуск?" begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'Config.ini');
if inifile.ReadBool('Main Settings', 'KeyQvestion', false)<>true then
	begin
	FormMessage.SetSettingsFromOther('Автозапуск', 'Добавление в автозапуск', 'Вы еще не добавили SC2 Player в автозагрузку и не можете своевременно узнать о прямой трансляции. Хотите сделать это сейчас? (рекомендуется)', 'Да', 'Нет', true, true, 2);
	if FormMessage.ShowModal=mrOk then
     	begin
      ConfimAddAutoRan(true);
      end
      else
      begin
      ConfimAddAutoRan(false);
      end;
   end;
inifile.Free;
//....................... Проверка на вопрос о "Добавлен ли плеер в автозапуск?" end
end;

end.
