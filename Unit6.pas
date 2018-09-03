unit Unit6;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, sLabel, ExtCtrls, acImage, sButton, Buttons,
  sSpeedButton, ComObj;

type
  TForm6 = class(TForm)
    sImage1: TsImage;
    sLabelFX1: TsLabelFX;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    G1: TMenuItem;
    sButton1: TsButton;
    sSpeedButton1: TsSpeedButton;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N7Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form6: TForm6;

implementation
uses Unit2, Unit1, Unit9;

{$R *.dfm}



procedure TForm6.N2Click(Sender: TObject);
begin
  Form1.Caption:='Быстрая ЭЦП на основе алгоритма Диффи-Хеллмана';
  Form1.Show;
  Form6.Visible:=false;
end;



procedure TForm6.N4Click(Sender: TObject);
begin
Form6.Close;
Form2.Visible:=true;
end;

procedure TForm6.N5Click(Sender: TObject);
begin
Form6.Close;
Form2.Close;
end;

procedure TForm6.sButton1Click(Sender: TObject);
begin
N2.Click;
end;

procedure TForm6.sSpeedButton1Click(Sender: TObject);
begin
 N4.Click;
end;

procedure TForm6.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form2.Visible:=True;
end;

procedure LoadInstProg();
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + 'Документы\Руководство программиста.doc';
    Word.Documents.Open(name, ReadOnly:=true);
end;

procedure TForm6.N7Click(Sender: TObject);
begin
LoadInstProg();
end;

procedure TForm6.N6Click(Sender: TObject);
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + 'Документы\Руководство пользователя.doc';
    Word.Documents.Open(name, ReadOnly:=true);
end;

procedure TForm6.N9Click(Sender: TObject);
begin
Form9.Show;
end;

end.
