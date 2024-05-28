unit MessageForm;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ComCtrls, ToolWin, ExtCtrls, StdCtrls, ImgList;

type
  TFormMessage = class(TForm)
    ILIcon: TImageList;
    STMesBody: TStaticText;
    STTitle: TStaticText;
    ButtonCancel: TButton;
    ButtonOkey: TButton;
    ImageIcon: TImage;
    procedure SetSettingsFromOther(FCap, MesHead, MesBody, OKCap, CancelCap: string; OKVis, CancelVis: boolean; Icon: integer);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  FormMessage: TFormMessage;
  FormCaption: string;
  ButtonCancelCaption, ButtonOkCaption: string;
  ButtonCancelVis, ButtonOkVis: boolean;
  MessageTitle, MessageBody: string;
  Icon: integer;
  

implementation

{$R *.dfm}

// SetSettingsFromOther([Заголовок формы], [Заголовок сообщения], [Текст сообщения], [Заголовок ОК], [Заголовок ОТМЕНА], [Показывать ОТМЕНА], [Показывать ОК], [Номер иконки])
procedure TFormMessage.SetSettingsFromOther(FCap, MesHead, MesBody, OKCap, CancelCap: string; OKVis, CancelVis: boolean; Icon: integer);
begin
FormMessage.Caption:= FCap;
STTitle.Caption:= MesHead;
STMesBody.Caption:= MesBody;
ButtonOkey.Caption:= OKCap;
ButtonCancel.Caption:= CancelCap;
ButtonOkey.Visible:= OKVis;
ButtonCancel.Visible:= CancelVis;
ILIcon.GetBitmap(Icon, ImageIcon.Picture.Bitmap);
ImageIcon.Refresh;
end;

end.
