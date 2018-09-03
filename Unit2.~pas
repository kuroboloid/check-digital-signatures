unit Unit2;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Menus, StdCtrls, sLabel, sButton, ExtCtrls, sPanel, Buttons,
  sSpeedButton, sBevel, acPNG, acImage, OleServer, ComObj, ShellApi,
  ComCtrls;

type
  TForm2 = class(TForm)
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    spnl1: TsPanel;
    btn1: TsButton;
    btn2: TsButton;
    lbl1: TsLabel;
    spnl2: TsPanel;
    lbl2: TsLabel;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    N11: TMenuItem;
    N12: TMenuItem;
    sButton1: TsButton;
    N13: TMenuItem;
    N14: TMenuItem;
    sButton2: TsButton;
    sSpeedButton1: TsSpeedButton;
    sSpeedButton2: TsSpeedButton;
    sPanel1: TsPanel;
    sButton3: TsButton;
    sSpeedButton3: TsSpeedButton;
    sSpeedButton4: TsSpeedButton;
    J1: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    sImage1: TsImage;
    sBevel1: TsBevel;
    sBevel2: TsBevel;
    sBevel3: TsBevel;
    N17: TMenuItem;
    J2: TMenuItem;
    procedure N6Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure btn1Click(Sender: TObject);
    procedure btn2Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N5Click(Sender: TObject);
    procedure N12Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N15Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure sSpeedButton2Click(Sender: TObject);
    procedure sSpeedButton3Click(Sender: TObject);
    procedure sSpeedButton4Click(Sender: TObject);
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form2: TForm2;

implementation

uses Unit1, Unit4, Unit5, Unit6, Unit7, Unit8;

{$R *.dfm}

procedure TForm2.N6Click(Sender: TObject);
begin
 Form1.Caption:='Электронная цифровая подпись RSA';
 Form1.Show;
 Form2.Visible:=false;
end;

procedure TForm2.N7Click(Sender: TObject);
begin
 Form1.Caption:='Электронная цифровая подпись El Gamal';
 Form1.Show;
 Form2.Visible:=false;
end;

procedure TForm2.btn1Click(Sender: TObject);
begin
Form2.Visible:=False;
Form4.Show;
end;

procedure TForm2.btn2Click(Sender: TObject);
begin
Form2.Visible:=False;
Form5.Show;
end;

procedure TForm2.N10Click(Sender: TObject);
begin
 btn1.Click;
end;

procedure TForm2.N11Click(Sender: TObject);
begin
  btn2.Click;
end;

procedure TForm2.N5Click(Sender: TObject);
begin
   Form2.Close;
end;

procedure TForm2.N12Click(Sender: TObject);
begin
  Form1.Caption:='Быстрая ЭЦП на основе алгоритма Диффи-Хеллмана';
  Form1.Show;
  Form2.Visible:=false;
end;

procedure TForm2.N14Click(Sender: TObject);
begin
   Form1.Caption:='Быстрая ЭЦП на основе алгоритма Фиата-Шамира';
  Form1.Show;
  Form2.Visible:=false;
end;

procedure TForm2.N15Click(Sender: TObject);
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + 'Документы\Руководство пользователя.doc';
    Word.Documents.Open(name, ReadOnly:=true);
end;

procedure TForm2.sSpeedButton1Click(Sender: TObject);
begin
N6.Click;
end;

procedure TForm2.sSpeedButton2Click(Sender: TObject);
begin
N7.Click;
end;

procedure TForm2.sSpeedButton3Click(Sender: TObject);
begin
 N12.Click;
end;

procedure TForm2.sSpeedButton4Click(Sender: TObject);
begin
 N14.Click;
end;



procedure TForm2.sButton1Click(Sender: TObject);
begin
Form2.Visible:=false;
Form6.Show;
end;

procedure TForm2.sButton2Click(Sender: TObject);
begin
Form2.Visible:=false;
Form7.Show;
end;

procedure TForm2.sButton3Click(Sender: TObject);
begin
Form2.Visible:=false;
Form8.Show;
end;

procedure LoadInstProg();
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + 'Документы\Руководство программиста.doc';
    Word.Documents.Open(name, ReadOnly:=true);
end;

procedure TForm2.N16Click(Sender: TObject);
begin
  LoadInstProg();
end;

end.
