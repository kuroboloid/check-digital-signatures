unit Unit4;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, sLabel, Menus, sButton, acPNG, ExtCtrls, acImage,
  Buttons, sSpeedButton, ComObj;

type
  TForm4 = class(TForm)
    mm1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    lbl1: TsLabelFX;
    img1: TsImage;
    btn1: TsButton;
    sSpeedButton1: TsSpeedButton;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    N10: TMenuItem;
    procedure N5Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure btn1Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form4: TForm4;

implementation
uses Unit2, Unit1, Unit9;

{$R *.dfm}

procedure TForm4.N5Click(Sender: TObject);
begin
Form4.Close;
Form2.Visible:=True;
end;

procedure TForm4.FormClose(Sender: TObject; var Action: TCloseAction);
begin
 Form2.Visible:=True;
end;

procedure TForm4.btn1Click(Sender: TObject);
begin
 Form1.Caption:='����������� �������� ������� RSA';
 Form1.Show;
 Form4.Visible:=false;
end;

procedure TForm4.sSpeedButton1Click(Sender: TObject);
begin
Form4.Close; Form2.Visible:=true;
end;

procedure LoadInstProg();
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + '���������\����������� ������������.doc';
    Word.Documents.Open(name, ReadOnly:=true);
end;

procedure TForm4.N8Click(Sender: TObject);
begin
LoadInstProg();
end;

procedure TForm4.N7Click(Sender: TObject);
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + '���������\����������� ������������.doc';
    Word.Documents.Open(name, ReadOnly:=true);
end;

procedure TForm4.N10Click(Sender: TObject);
begin
Form9.Show;
end;

procedure TForm4.N3Click(Sender: TObject);
begin
 Form1.Caption:='����������� �������� ������� RSA';
 Form1.Show;
 Form4.Visible:=false;
end;

procedure TForm4.N6Click(Sender: TObject);
begin
Form4.Close; Form2.Close;
end;

end.
