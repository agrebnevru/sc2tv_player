unit SettingsForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ComCtrls, ImgList, ToolWin, StdCtrls, Spin, inifiles,
  CheckLst, ShellApi, Mask, registry, RxCombos, RzTabs, RzButton, RzRadChk,
  RzEdit, RzSpnEdt, RzBtnEdt, RzPanel, RzLstBox, RzChkLst, RzCmboBx,
  RzBorder;

type
  TFormSettings = class(TForm)
    DownPanel: TPanel;
    ToolBarOkCancel: TToolBar;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ImageListTabs: TImageList;
    OD: TOpenDialog;
    RzPageControl1: TRzPageControl;
    TSMainSettings: TRzTabSheet;
    TSInterfaceSettings: TRzTabSheet;
    TSActionSettings: TRzTabSheet;
    TSSoundSettings: TRzTabSheet;
    TSChatSettings: TRzTabSheet;
    GroupBox8: TGroupBox;
    InterfaceStrimListBold: TCheckBox;
    InterfaceStrimListItalic: TCheckBox;
    InterfaceStrimListUnderline: TCheckBox;
    GroupBox3: TGroupBox;
    CBOnTop: TCheckBox;
    CBAutoRan: TCheckBox;
    GroupBox2: TGroupBox;
    Label1: TLabel;
    EditTimerShowPopup: TEdit;
    UpDown1: TUpDown;
    GroupBox4: TGroupBox;
    Label2: TLabel;
    CBTransparentKey: TCheckBox;
    GroupBox1: TGroupBox;
    CLBSeePopup: TCheckListBox;
    GroupBox5: TGroupBox;
    CBSoundStartProg: TCheckBox;
    CBSoundAction: TCheckBox;
    CBSoundExitProg: TCheckBox;
    EditSoundStart: TEdit;
    EditSoundAction: TEdit;
    EditSoundExit: TEdit;
    ToolBar1: TToolBar;
    ToolButton4: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    Label3: TLabel;
    Label4: TLabel;
    GroupBox6: TGroupBox;
    Label5: TLabel;
    Label6: TLabel;
    EditChatNik: TEdit;
    GroupBox7: TGroupBox;
    Label7: TLabel;
    Label8: TLabel;
    EditChatServer: TEdit;
    EditChatPort: TEdit;
    CCBStrimListColor: TRzColorEdit;
    SBTransparentPopup: TScrollBar;
    Label9: TLabel;
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure CBTransparentKeyClick(Sender: TObject);
    procedure UpDown1Click(Sender: TObject; Button: TUDBtnType);
    procedure SBTransparentPopupChange(Sender: TObject);
    procedure ToolButton4Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure Label4Click(Sender: TObject);
    procedure CBAutoRanClick(Sender: TObject);
    procedure AutoRan(KeyAdd: boolean);
    procedure Label9Click(Sender: TObject);
  private
    { Private declarations }
    procedure SettingsSave;
    procedure SettingsLoad;
  public
    { Public declarations }
  end;

var
  FormSettings: TFormSettings;
  inifile: tinifile;

implementation

uses MainForm, PopupForm;

{$R *.dfm}

{--------------------------- Функции автозапуска begin ------------------------}
procedure TFormSettings.AutoRan(KeyAdd: boolean);
var
h: TRegistry;
begin
 h := TRegistry.Create;
with h do
	begin
	RootKey := HKEY_LOCAL_MACHINE;
	OpenKey('\Software\Microsoft\Windows\CurrentVersion\Run', true);
   if KeyAdd then
      WriteString('SC2 Player', '"'+Application.ExeName+'" /autoran')
		else
      DeleteValue('SC2 Player');
	CloseKey;
	Free;
	end
end;
{--------------------------- Функции автозапуска end --------------------------}

procedure TFormSettings.SettingsSave;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'Config.ini');
//.............................................................. Вкладка "Общее"
inifile.WriteBool('Main Settings', 'OnTop', CBOnTop.Checked);
inifile.WriteBool('Main Settings', 'AutoRan', CBAutoRan.Checked);
//.......................................................... Вкладка "Интерфейс"
inifile.WriteBool('Interface Settings', 'StrimListBold', InterfaceStrimListBold.Checked);
inifile.WriteBool('Interface Settings', 'StrimListItalic', InterfaceStrimListItalic.Checked);
inifile.WriteBool('Interface Settings', 'StrimListUnderline', InterfaceStrimListUnderline.Checked);
inifile.WriteString('Interface Settings', 'StrimListTextColor', ColorToString(CCBStrimListColor.SelectedColor));
//........................................................ Вкладка "Уведемления"
inifile.WriteInteger('Action Settings', 'PopupTimeWatch', StrToInt(EditTimerShowPopup.text));
inifile.WriteInteger('Action Settings', 'PopupTransparentValue', SBTransparentPopup.Position);
inifile.WriteBool('Action Settings', 'PopupTransparentKey', CBTransparentKey.Checked);
inifile.WriteBool('Action Settings', 'SeePopup0', CLBSeePopup.Checked[0]);
inifile.WriteBool('Action Settings', 'SeePopup1', CLBSeePopup.Checked[1]);
//.............................................................. Вкладка "Звуки"
inifile.WriteBool('Sound Settings', 'SoundStartKey', CBSoundStartProg.Checked);
inifile.WriteBool('Sound Settings', 'SoundActionKey', CBSoundAction.Checked);
inifile.WriteBool('Sound Settings', 'SoundExitKey', CBSoundExitProg.Checked);
inifile.WriteString('Sound Settings', 'SoundStartFile', EditSoundStart.text);
inifile.WriteString('Sound Settings', 'SoundActionFile', EditSoundAction.text);
inifile.WriteString('Sound Settings', 'SoundExitFile', EditSoundExit.text);
//................................................................ Вкладка "Чат"
inifile.WriteString('Chat Settings', 'Nik', EditChatNik.Text);
inifile.WriteString('Chat Settings', 'Server', EditChatServer.Text);
inifile.WriteInteger('Chat Settings', 'Port', StrToInt(EditChatPort.Text));
inifile.Free;
end;

procedure TFormSettings.SettingsLoad;
begin
inifile:=tinifile.Create(extractfilepath(application.ExeName)+'Config.ini');
//.............................................................. Вкладка "Общее"
CBOnTop.Checked:= inifile.ReadBool('Main Settings', 'OnTop', false);
CBAutoRan.Checked:= inifile.ReadBool('Main Settings', 'AutoRan', false);
//.......................................................... Вкладка "Интерфейс"
InterfaceStrimListBold.Checked:= inifile.ReadBool('Interface Settings', 'StrimListBold', false);
InterfaceStrimListItalic.Checked:= inifile.ReadBool('Interface Settings', 'StrimListItalic', false);
InterfaceStrimListUnderline.Checked:= inifile.ReadBool('Interface Settings', 'StrimListUnderline', false);
CCBStrimListColor.SelectedColor:= StringToColor(inifile.ReadString('Interface Settings', 'StrimListTextColor', 'clBlack'));
//........................................................ Вкладка "Уведемления"
EditTimerShowPopup.text:= IntToStr(inifile.ReadInteger('Action Settings', 'PopupTimeWatch', 10));
SBTransparentPopup.Position:= inifile.ReadInteger('Action Settings', 'PopupTransparentValue', 255);
CBTransparentKey.Checked:= inifile.ReadBool('Action Settings', 'PopupTransparentKey', false);
CLBSeePopup.Checked[0]:= inifile.ReadBool('Action Settings', 'SeePopup0', true);
CLBSeePopup.Checked[1]:= inifile.ReadBool('Action Settings', 'SeePopup1', true);
//.............................................................. Вкладка "Звуки"
CBSoundStartProg.Checked:= inifile.ReadBool('Sound Settings', 'SoundStartKey', true);
CBSoundAction.Checked:= inifile.ReadBool('Sound Settings', 'SoundActionKey', true);
CBSoundExitProg.Checked:= inifile.ReadBool('Sound Settings', 'SoundExitKey', true);
EditSoundStart.text:= inifile.ReadString('Sound Settings', 'SoundStartFile', extractfilepath(application.ExeName)+'sound\start.wav');
EditSoundAction.text:= inifile.ReadString('Sound Settings', 'SoundActionFile', extractfilepath(application.ExeName)+'sound\popupmessage.wav');
EditSoundExit.text:= inifile.ReadString('Sound Settings', 'SoundExitFile', extractfilepath(application.ExeName)+'sound\exit.wav');
//................................................................ Вкладка "Чат"
EditChatNik.Text:= inifile.ReadString('Chat Settings', 'Nik', '0');
EditChatServer.Text:= inifile.ReadString('Chat Settings', 'Server', '82.209.91.11');
EditChatPort.Text:= IntToStr(inifile.ReadInteger('Chat Settings', 'Port', 20000));
inifile.Free;
end;

procedure TFormSettings.ToolButton1Click(Sender: TObject);
begin
Close;
end;

procedure TFormSettings.ToolButton2Click(Sender: TObject);
begin
SettingsSave;
FormGeneral.SetSettings;
FormPopUp.SetSettings;
Close;
end;

procedure TFormSettings.FormShow(Sender: TObject);
begin
SettingsLoad;
end;

procedure TFormSettings.CBTransparentKeyClick(Sender: TObject);
begin
FormPopUp.AlphaBlend:= CBTransparentKey.Checked;
end;

procedure TFormSettings.UpDown1Click(Sender: TObject; Button: TUDBtnType);
begin
FormPopUp.TimerCloser.Interval:= StrToInt(EditTimerShowPopup.Text);
end;

procedure TFormSettings.SBTransparentPopupChange(Sender: TObject);
begin
FormPopUp.AlphaBlendValue:= SBTransparentPopup.Position;
end;

procedure TFormSettings.ToolButton4Click(Sender: TObject);
begin
OD.Title:= 'Звук старта SC2 Player';
if OD.Execute then
	EditSoundStart.Text:= OD.FileName;
end;

procedure TFormSettings.ToolButton3Click(Sender: TObject);
begin
OD.Title:= 'Звук для всплывающей подсказки SC2 Player';
if OD.Execute then
	EditSoundAction.Text:= OD.FileName;
end;

procedure TFormSettings.ToolButton5Click(Sender: TObject);
begin
OD.Title:= 'Звук выхода из SC2 Player';
if OD.Execute then
	EditSoundExit.Text:= OD.FileName;
end;

procedure TFormSettings.Label4Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://sc2player.do.am/load/0-0-0-4-20'), nil, nil, SW_SHOW);
end;

procedure TFormSettings.CBAutoRanClick(Sender: TObject);
begin
if CBAutoRan.Checked then
	AutoRan(true)
   else
   AutoRan(false);
end;

procedure TFormSettings.Label9Click(Sender: TObject);
begin
FormGeneral.SendPopupMessage('Тестовое сообщение', 'Предпросмотр всплывающей подсказки');
end;

end.
