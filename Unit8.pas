unit Unit8;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sLabel, StdCtrls, acPNG, ExtCtrls, acImage, Buttons,
  sSpeedButton, Menus;

type
  TForm8 = class(TForm)
    sImage1: TsImage;
    sLabel1: TsLabel;
    sLabel2: TsLabel;
    sWebLabel1: TsWebLabel;
    sSpeedButton1: TsSpeedButton;
    MainMenu1: TMainMenu;
    A1: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    sSpeedButton2: TsSpeedButton;
    procedure sWebLabel1Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure N1Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sSpeedButton2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form8: TForm8;

implementation
uses Unit2;
{$R *.dfm}

procedure TForm8.sWebLabel1Click(Sender: TObject);
begin
sImage1.Visible:=true;
sSpeedButton1.Visible:=true;
sLabel1.Visible:=false;
sLabel2.Visible:=false;
sWebLabel1.Visible:=false;

end;

procedure TForm8.sSpeedButton1Click(Sender: TObject);
begin
sImage1.Visible:=false;
sSpeedButton1.Visible:=false;
sLabel1.Visible:=true;
sLabel2.Visible:=true;
sWebLabel1.Visible:=true;
end;

procedure TForm8.N1Click(Sender: TObject);
begin
 Form8.Close;
 Form2.Visible:=true;
end;

procedure TForm8.N2Click(Sender: TObject);
begin
Form8.Close;
 Form2.Close;
end;

procedure TForm8.FormClose(Sender: TObject; var Action: TCloseAction);
begin
Form2.Visible:=True;
end;

procedure TForm8.sSpeedButton2Click(Sender: TObject);
begin
  N1.Click;
end;

end.
