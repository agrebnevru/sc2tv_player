unit AboutForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, Buttons, pngimage, ShellApi, ComCtrls;

type
  TFormAbout = class(TForm)
    LabelSC2PlayerPowered: TLabel;
    ImageMiniLogo: TImage;
    PanelForImg: TPanel;
    PanelForMemo: TPanel;
    BitBtn1: TBitBtn;
    RichEditAboutProgramm: TRichEdit;
    LabelSC2PlayerVersion: TLabel;
    LabelProgVer: TLabel;
    Label2: TLabel;
    Label_sc2tv_site: TLabel;
    PanelSupport: TPanel;
    Label3: TLabel;
    Label_goodgame_site: TLabel;
    PanelInfoVer: TPanel;
    Label1: TLabel;
    Label4: TLabel;
    procedure Label_sc2tv_siteClick(Sender: TObject);
    procedure Label_goodgame_siteClick(Sender: TObject);
    procedure Label_sc2player_siteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Label1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormAbout: TFormAbout;

implementation

uses MainForm;

{$R *.dfm}

procedure TFormAbout.Label_sc2tv_siteClick(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://sc2tv.ru/'), nil, nil, SW_SHOW);
end;

procedure TFormAbout.Label_goodgame_siteClick(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://goodgame.ru/'), nil, nil, SW_SHOW);
end;

procedure TFormAbout.Label_sc2player_siteClick(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://sc2player.do.am/'), nil, nil, SW_SHOW);
end;

procedure TFormAbout.FormShow(Sender: TObject);
begin
LabelSC2PlayerVersion.Caption:= SC2PlayerVersion;
end;

procedure TFormAbout.Label1Click(Sender: TObject);
begin
ShellExecute(Handle, 'open', PChar('http://reps.ru/'), nil, nil, SW_SHOW);
end;

end.
