unit Unit7;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, sLabel, ExtCtrls, acImage, Buttons,
  sSpeedButton, sBitBtn, ComObj;

type
  TForm7 = class(TForm)
    sImage1: TsImage;
    sLabelFX1: TsLabelFX;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    sBitBtn1: TsBitBtn;
    sSpeedButton1: TsSpeedButton;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    procedure N2Click(Sender: TObject);
    procedure N4Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure sBitBtn1Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure N8Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form7: TForm7;

implementation
uses Unit1, Unit2, Unit9;

{$R *.dfm}

procedure TForm7.N2Click(Sender: TObject);
begin
   Form1.Caption:='Быстрая ЭЦП на основе алгоритма Фиата-Шамира';
   Form1.Show;
   Form7.Visible:=false;
end;

procedure TForm7.N4Click(Sender: TObject);
begin
Form7.Close;
Form2.Visible:=true;
end;

procedure TForm7.N5Click(Sender: TObject);
begin
Form7.Close;
Form2.Close;
end;

procedure TForm7.sBitBtn1Click(Sender: TObject);
begin
 N2.Click;
end;

procedure TForm7.sSpeedButton1Click(Sender: TObject);
begin
  N4.Click;
end;

procedure TForm7.FormClose(Sender: TObject; var Action: TCloseAction);
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

procedure TForm7.N8Click(Sender: TObject);
begin
LoadInstProg();
end;

procedure TForm7.N7Click(Sender: TObject);
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + 'Документы\Руководство пользователя.doc';
    Word.Documents.Open(name, ReadOnly:=true);
end;

procedure TForm7.N10Click(Sender: TObject);
begin
Form9.Show;
end;

end.
