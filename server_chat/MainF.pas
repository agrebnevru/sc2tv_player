unit MainF;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, IdBaseComponent, IdComponent, IdUDPBase,
  IdUDPServer, RVStyle, RVScroll, RichView, ComCtrls, CoolTrayIcon, Menus;

type
  TForm1 = class(TForm)
    NikEdit: TEdit;
    TextEdit: TEdit;
    ServerSocket: TServerSocket;
    RVChat: TRichView;
    RVS: TRVStyle;
    Button1: TButton;
    CT: TCoolTrayIcon;
    PMTray: TPopupMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    Button2: TButton;
    LabelConnections: TLabel;
    Button3: TButton;
    MemoChat: TMemo;
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ServerSocketClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button1Click(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure N3Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure PMTrayPopup(Sender: TObject);
    procedure CTDblClick(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure ServerSocketClientError(Sender: TObject;
      Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
      var ErrorCode: Integer);
    procedure ServerSocketClientConnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ServerSocketClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure Button3Click(Sender: TObject);
  private
    { Private declarations }
    function GetStyleNo(CommandChar: Char; Color: TColor;
      StyleNo: Integer): Integer;
    procedure ParseString(s: String);
    procedure LogWrite(mes: string);
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  KeyClose: boolean;
  Connections: integer;
  History: tstrings;
  DataHis: string;

implementation

{$R *.dfm}

{-------------------------- ������� ��� ���� beginn----------------------------}
// TColor to RGB string
function GetColorStr(Color: TColor): String;
begin
  Result := IntToHex(ColorToRGB(Color),6);
  Result := Copy(Result,5,2)+Copy(Result,3,2)+Copy(Result,1,2);
end;

// RGB string to TColor
function GetStrColor(ColorValue: String): TColor;
var
i,v: Integer;
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

function TForm1.GetStyleNo(CommandChar: Char; Color: TColor;
  StyleNo: Integer): Integer;
var
fi: TFontInfo;
begin
  fi:= TFontInfo.Create(nil);
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

procedure TForm1.ParseString(s: String);
var
i: Integer;
ParaNo, StyleNo, StartIndex: Integer;
CodeStarted: Boolean;
ColorChar: Char;
ColorValue: String;
{.....................................................}
    procedure AddString(StartIndex, EndIndex: Integer);
    var
    str: String;
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
  for i:= 1 to Length(s) do begin
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
{---------------------------- ������� ��� ���� end ----------------------------}

procedure TForm1.LogWrite(mes: string);
begin
//if fileexists(extractfilepath(application.ExeName)+'log_error_'+DataHis+'.log') then
//	history.LoadFromFile(extractfilepath(application.ExeName)+'log_error_'+DataHis+'.log');
//history.Add(mes);
//history.SaveToFile(extractfilepath(application.ExeName)+'log_error_'+DataHis+'.log');
end;

procedure TForm1.FormDestroy(Sender: TObject);
begin
ServerSocket.Active:=false;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
DataHis:= DateToStr(Date);
ServerSocket.Active:=true;
Application.Minimize;
KeyClose:= false;
end;


procedure TForm1.ServerSocketClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
var
s:string;
i: integer;
begin
s:=Socket.ReceiveText;
  For i:=0 to ServerSocket.Socket.ActiveConnections-1 do
      ServerSocket.Socket.Connections[i].SendText('['+TimeToStr(Time)+'] '+s);
//ParseString('['+TimeToStr(Time)+'] '+s);
//RVChat.FormatTail;
//RVChat.Update;
MemoChat.Lines.Add(s);
end;

procedure TForm1.Button1Click(Sender: TObject);
var
i: integer;
begin
For i:=0 to ServerSocket.Socket.ActiveConnections-1 do
Begin
	ServerSocket.Socket.Connections[i].SendText('['+TimeToStr(Time)+'] '+NikEdit.Text+': '+TextEdit.Text);
end;
ParseString('['+TimeToStr(Time)+'] \b'+NikEdit.Text+'\b: '+TextEdit.Text);
RVChat.FormatTail;
RVChat.Update;
TextEdit.Clear;
end;

procedure TForm1.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
CanClose:= KeyClose;
if not CanClose then
	hide;
end;

procedure TForm1.N3Click(Sender: TObject);
begin
KeyClose:= true;
Close;
end;

procedure TForm1.N1Click(Sender: TObject);
begin
if Showing then
	Hide
else
	Show;
end;

procedure TForm1.PMTrayPopup(Sender: TObject);
begin
if Showing then
    N1.Caption:= '������'
else
    N1.Caption:= '��������';
end;

procedure TForm1.CTDblClick(Sender: TObject);
begin
if Showing then
	Hide
else
	Show;
end;

procedure TForm1.Button2Click(Sender: TObject);
begin
TextEdit.Text:= '\k000000\cFFFFFF'+TextEdit.Text+'\cFFFFFF\k000000';
end;

procedure TForm1.ServerSocketClientError(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
LogWrite(TimeToStr(Time)+' - Error #'+IntToStr(ErrorCode));
ErrorCode:= 0;
end;

procedure TForm1.ServerSocketClientConnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
i: integer;
begin
Connections:= Connections+1;
LogWrite(TimeToStr(Time)+' - User Connected, all user='+IntToStr(Connections));
LabelConnections.Caption:= '������������ � ����: '+IntToStr(Connections);

For i:=0 to ServerSocket.Socket.ActiveConnections-1 do
Begin
	ServerSocket.Socket.Connections[i].SendText('#onl# '+IntToStr(Connections));
end;
end;

procedure TForm1.ServerSocketClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
var
i: integer;
begin
if Connections>0 then
	Connections:= Connections-1;
LogWrite(TimeToStr(Time)+' - User Disconnected, all user='+IntToStr(Connections));
LabelConnections.Caption:= '������������ � ����: '+IntToStr(Connections);

For i:=0 to ServerSocket.Socket.ActiveConnections-1 do
Begin
	ServerSocket.Socket.Connections[i].SendText('#onl# '+IntToStr(Connections));
end;
end;

procedure TForm1.Button3Click(Sender: TObject);
var
i: integer;
begin
For i:=0 to ServerSocket.Socket.ActiveConnections-1 do
Begin
	ServerSocket.Socket.Connections[i].SendText(TextEdit.Text);
end;
ParseString(TextEdit.Text);
RVChat.FormatTail;
RVChat.Update;
TextEdit.Clear;
end;

end.
