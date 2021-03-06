unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, sSkinManager, StdCtrls, sMemo, sLabel, sButton, sGroupBox,
  sCheckBox, sEdit, Winsock, ScktComp, Menus, ExtCtrls, sPanel, sComboBox,
  sDialogs, sRadioButton, Buttons, sSpeedButton, ComCtrls, sPageControl,
  sMonthCalendar, sBevel, acImage, ComObj;

type
  TForm1 = class(TForm)
    sSkinManager1: TsSkinManager;
    sEdit1: TsEdit;
    sEdit2: TsEdit;
    server: TsCheckBox;
    client: TsCheckBox;
    sGroupBox1: TsGroupBox;
    sButton1: TsButton;
    sLabel1: TsLabel;
    nikname: TsEdit;
    sLabel2: TsLabel;
    sGroupBox2: TsGroupBox;
    sButton2: TsButton;
    sMemo1: TsMemo;
    ClientSocket1: TClientSocket;
    ServerSocket1: TServerSocket;
    sLabel3: TsLabel;
    MainMenu1: TMainMenu;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N4: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    G1: TMenuItem;
    sGroupBox3: TsGroupBox;
    N10: TMenuItem;
    N11: TMenuItem;
    sButton3: TsButton;
    sButton4: TsButton;
    formGamal: TsGroupBox;
    sWebLabel1: TsWebLabel;
    openkey: TsGroupBox;
    sEdit3: TsEdit;
    sButton5: TsButton;
    sLabel4: TsLabel;
    sWebLabel2: TsWebLabel;
    Gedit: TsEdit;
    pEdit: TsEdit;
    xEdit: TsEdit;
    sLabel5: TsLabel;
    sWebLabel3: TsWebLabel;
    formRSA: TsGroupBox;
    sWebLabel4: TsWebLabel;
    sWebLabel5: TsWebLabel;
    qedit: TsEdit;
    peditrsa: TsEdit;
    sLabel6: TsLabel;
    sButton6: TsButton;
    sPanel1: TsPanel;
    sButton7: TsButton;
    sButton8: TsButton;
    sCB1: TsComboBox;
    sOpenDialog1: TsOpenDialog;
    box: TsMemo;
    sPanel2: TsPanel;
    sButton10: TsButton;
    Y1: TMenuItem;
    N12: TMenuItem;
    sGroupBox4: TsGroupBox;
    sSpeedButton1: TsSpeedButton;
    sPageControl1: TsPageControl;
    sTabSheet1: TsTabSheet;
    sTabSheet2: TsTabSheet;
    proc: TsLabel;
    sTabSheet3: TsTabSheet;
    create: TsMemo;
    dec: TsMemo;
    transkey: TsButton;
    sCheckBox1: TsCheckBox;
    formDH: TsGroupBox;
    gDHedit: TsEdit;
    qDHedit: TsEdit;
    xDHedit: TsEdit;
    sLabel8: TsLabel;
    sButton9: TsButton;
    sWebLabel6: TsWebLabel;
    sWebLabel7: TsWebLabel;
    proc2: TsMemo;
    sPanel3: TsPanel;
    sSaveDialog1: TsSaveDialog;
    box2: TsMemo;
    P1: TMenuItem;
    N13: TMenuItem;
    sBevel1: TsBevel;
    con: TsLabel;
    yes: TsImage;
    no: TsImage;
    sOpenDialog2: TsOpenDialog;
    N14: TMenuItem;
    N15: TMenuItem;
    N16: TMenuItem;
    N17: TMenuItem;
    procedure sButton1Click(Sender: TObject);
    procedure sButton2Click(Sender: TObject);
    procedure ServerSocket1ClientRead(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocketRead(Sender: TObject; Socket: TCustomWinSocket);
    procedure clientClick(Sender: TObject);
    procedure serverClick(Sender: TObject);
    procedure FormKeyPress(Sender: TObject; var Key: Char);
    procedure sEdit2KeyPress(Sender: TObject; var Key: Char);
    procedure N8Click(Sender: TObject);
    procedure sButton3Click(Sender: TObject);
    procedure sWebLabel1Click(Sender: TObject);
    procedure sWebLabel2Click(Sender: TObject);
    procedure sButton4Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure sButton6Click(Sender: TObject);
    procedure sWebLabel3Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure sButton7Click(Sender: TObject);
    procedure sButton8Click(Sender: TObject);
    procedure sButton5Click(Sender: TObject);
    procedure sButton9Click(Sender: TObject);
    procedure sWebLabel5Click(Sender: TObject);
    procedure sButton10Click(Sender: TObject);
    procedure sSpeedButton1Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure N7Click(Sender: TObject);
    procedure Y1Click(Sender: TObject);
    procedure sCheckBox1Click(Sender: TObject);
    procedure transkeyClick(Sender: TObject);
    procedure sWebLabel7Click(Sender: TObject);
    procedure ServerSocket1ClientDisconnect(Sender: TObject;
      Socket: TCustomWinSocket);
    procedure ClientSocket1Error(Sender: TObject; Socket: TCustomWinSocket;
      ErrorEvent: TErrorEvent; var ErrorCode: Integer);
    procedure P1Click(Sender: TObject);
    procedure N13Click(Sender: TObject);
    procedure N10Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N2Click(Sender: TObject);
    procedure sEdit1KeyPress(Sender: TObject; var Key: Char);
    procedure N15Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure N17Click(Sender: TObject);
    procedure gDHeditKeyPress(Sender: TObject; var Key: Char);
    procedure qDHeditKeyPress(Sender: TObject; var Key: Char);
    procedure xDHeditKeyPress(Sender: TObject; var Key: Char);
    procedure GeditKeyPress(Sender: TObject; var Key: Char);
    procedure pEditKeyPress(Sender: TObject; var Key: Char);
    procedure xEditKeyPress(Sender: TObject; var Key: Char);
    procedure peditrsaKeyPress(Sender: TObject; var Key: Char);
    procedure qeditKeyPress(Sender: TObject; var Key: Char);
        private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  o, w:Integer;
  hashmes, m:String;


implementation

uses Unit2, Unit9, BaseOperationLib, InternetLib, EDS_ElGamal, EDS_RSA, EDS_DH, EDS_FS;


{$R *.dfm}

procedure TForm1.sButton1Click(Sender: TObject);
begin
Connect();
end;

//------------------------��������� ���������-------------------------//
procedure TForm1.sButton2Click(Sender: TObject);
var Text, EDS_Gamal, EDS_RSA, edshash:string;  i:integer;
begin
sTabSheet2.TabVisible:=true;
sTabSheet1.TabVisible:=true;
sPageControl1.ActivePageIndex:=1;
SendMes('> '+nikname.Text+'('+GetLocalIP+'): ' + sEdit2.Text);
  sMemo1.Lines.add('> '+nikname.Text+'('+GetLocalIP+'): ');
  sMemo1.Lines.add(sEdit2.Text);
//sPanel2.Caption:='g'+ md5('> '+nikname.Text+'('+GetLocalIP+'): ' +sEdit2.Text);
 sTabSheet3.Visible:=true;
if Form1.Caption='����������� �������� ������� El Gamal'  then GamalEncrypt();
if Form1.Caption='����������� �������� ������� RSA'  then RSAEncrypt();
if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then DHEncrypt();
if Form1.Caption='������� ��� �� ������ ��������� �����-������' then FSEncrypt();
end;

//----------------------------����� ��������� ��������----------------//
procedure TForm1.ServerSocket1ClientRead(Sender: TObject;
  Socket: TCustomWinSocket);
begin
if Socket.ReceiveText='1' then begin
con.Caption:='���������� �����������!';
sGroupBox3.Enabled:=true;
transkey.Visible:=true;
end
else begin
sMemo1.Lines.add(Socket.RemoteAddress+': ');
  sMemo1.Lines.add(Socket.ReceiveText);
  end;
  end;

  //----------------------����� ��������� ��������------------------------
procedure TForm1.ClientSocketRead(Sender: TObject;
  Socket: TCustomWinSocket);
  var Text, EDS_Gamal, EDS_RSA, edshash:string;  i:integer;
begin
Text:= Socket.ReceiveText; EDS_Gamal:='';  EDS_RSA:='';
box.Text:='';
sTabSheet3.TabVisible:=true;
if Text='%' then begin
ShowMessage('������ �������� ����������!');
sButton8.Click;
//Disconect; //Y1.Click;
exit; end;
if  Text[1]='*' then begin
    sEdit2.Enabled:=true;
    sPanel1.Caption:=Text;
    if Form1.Caption='������� ��� �� ������ ��������� �����-������' then sPanel1.Font.Size:=6;
    end
  else begin
if  Text[1]='$' then begin
  Form1.Height:=616;
  if Form1.Caption='����������� �������� ������� El Gamal'  then
  begin
  for i:=2 to Length(Text) do EDS_Gamal:= EDS_Gamal+Text[i];
  box.Lines.add(EDS_Gamal);
   edshash:=GamalDecrypt();
   end;
  if Form1.Caption='����������� �������� ������� RSA'  then
  begin
  for i:=2 to Length(Text) do EDS_RSA:= EDS_RSA+Text[i];
  Form1.box.Text:=EDS_RSA;
  edshash:=RSADecrypt();
  end;
  if (Form1.Caption='����������� �������� ������� RSA') or (Form1.Caption='����������� �������� ������� El Gamal')
  then begin
     Form1.dec.Lines.Add('�������� ��������� �������������� ��� � ����� ����������� ���������.' + #13#10 +
   '��� ����������� ���������: ' + hashmes + #13#10 +
   '���:' + edshash+ #13#10);
   if hashmes=edshash then begin
      Form1.dec.Lines.Add(hashmes + ' = ' +edshash);
   //sPanel2.Caption:='����������� ������������!';
   no.Visible:=false;
   yes.Visible:=true;
   end
   else begin
    Form1.dec.Lines.Add(hashmes + ' <> ' +edshash);
   //sPanel2.Caption:='����������� ����������� �� ������������ ��� ��������� ����������!';
   no.Visible:=true;
   yes.Visible:=false;
   end;
   end;
   if Form1.Caption='������� ��� �� ������ ��������� �����-��������'  then begin
   box.Lines.add(Text);
   DHDecrypt(m);
   end;
   if Form1.Caption='������� ��� �� ������ ��������� �����-������' then begin
   box.Lines.add(Text);
   FSDecrypt(md5(m));
   end;
end
else begin
hashmes:='';
sMemo1.Lines.add(Socket.RemoteAddress+': ');
sMemo1.Lines.add(Text);
   hashmes:='g'+md5(Text);
   m:=Text;
end;
end;
end;

procedure TForm1.clientClick(Sender: TObject);
begin
nikname.Text:='client';
sLabel1.Caption:='';
server.Checked:=False;
sButton3.Enabled:=false;
sButton7.Visible:=true;
if (sEdit1.Visible= False) then  begin
sEdit1.Visible:= True;
sLabel3.Visible:= True;
end
else begin
sEdit1.Visible:= False;
sLabel3.Visible:= false;
end;
end;

procedure TForm1.serverClick(Sender: TObject);
begin
if server.Checked=true then begin
nikname.Text:='server';
client.Checked:=False;
sButton3.Enabled:=true;
sButton7.Visible:=false;
sCB1.Enabled:=true;
if (sEdit1.Visible= True) then  begin
sEdit1.Visible:= False;
sLabel3.Visible:= False;
end;
end;
end;

procedure TForm1.FormKeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
sButton2.Click;
end;

procedure TForm1.sEdit2KeyPress(Sender: TObject; var Key: Char);
begin
if Key=#13 then
sButton2.Click;
end;

procedure TForm1.N8Click(Sender: TObject);
begin
Form1.Close; Form2.Visible:=true;
end;

procedure TForm1.sButton3Click(Sender: TObject);
begin
if Form1.Caption='����������� �������� ������� El Gamal' then
formGamal.Visible:=true;
if (Form1.Caption='����������� �������� ������� RSA') or
(Form1.Caption='������� ��� �� ������ ��������� �����-������') then
formRSA.Visible:=true;
if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then
formDH.Visible:=true;
sCheckBox1.Visible:=true;
end;

procedure TForm1.sWebLabel1Click(Sender: TObject);
begin
formRSA.Visible:=false;
formGamal.Visible:=false;
sCheckBox1.Visible:=false;
end;

procedure TForm1.sWebLabel2Click(Sender: TObject);
begin
openkey.Visible:=false;
end;

procedure TForm1.sButton4Click(Sender: TObject);
begin
openkey.Visible:=true;
sCheckBox1.Visible:=true;
if server.Checked=true then  sCB1.Enabled:=true;
end;

procedure TForm1.FormClose(Sender: TObject; var Action: TCloseAction);
begin
//if  ClientSocket1.Active=true then begin
//ShowMessage('wtf'); exit; end;
 N7.Click;
 nikname.Text:='';
 sButton8.Click;
 Disconect();
 Sleep(100);
Form2.Visible:=true;


end;



procedure TForm1.sButton6Click(Sender: TObject);
begin
  sTabSheet1.TabVisible:=true;
  Form1.Height:=616;
  GamalKeyFormirovanie();
  sEdit2.Enabled:=true;
  sButton2.Enabled:=true;
end;

procedure TForm1.sWebLabel3Click(Sender: TObject);
var p, g, x: int64;
begin
randomize;
p:= random(100000000);
while not (CanonDec(p)) do p:= random(100000000);
pEdit.Text:= IntToStr(p);
g:= random(p-1);
while not (CanonDec(g))  do g:= random(p-1);
gEdit.Text:= IntToStr(g);
x:= random(p-1);
while not (CanonDec(x)) do x:= random(p-1);
xEdit.Text:= IntToStr(x);
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
o:=0; w:=0;
end;

procedure TForm1.sButton7Click(Sender: TObject);
begin
SendMes('1');
//sPanel1.Caption:='���������� �����������!';
con.Caption:='���������� �����������!';
sGroupBox3.Enabled:=True;
sButton8.Visible:=true;
end;

procedure TForm1.sButton8Click(Sender: TObject);   //��������� ����������
begin
  if ClientSocket1.Active=True
  then begin
  ClientSocket1.Active:=False;
  ClientSocket1.Close;
  end;
if ServerSocket1.Active=True
  then begin
  SendMes('%');
  ServerSocket1.Active:=False;
  ServerSocket1.Close;
 end;
Y1.Click;
sButton8.Visible:=false;
server.Enabled:=true; client.Enabled:=true;
Form1.Position:= poDesktopCenter;
transkey.Visible:=false;
con.Caption:='';
sEdit2.Enabled:=False;
end;

procedure TForm1.sButton5Click(Sender: TObject);
var str, key:string;
begin
sOpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  If sOpenDialog1.Execute Then
  begin
  sEdit3.Text:= sOpenDialog1.FileName ;
  box2.Lines.LoadFromFile(sOpenDialog1.FileName);
  key:=box2.Text;
  if (sCB1.ItemIndex=0) or (sCB1.ItemIndex=-1)  then begin
  if w=0 then sPanel1.Caption:='';
  sPanel1.Caption:=  sPanel1.Caption + '�������� ����:'+box2.Text +#13#10;
  if (Form1.Caption='����������� �������� ������� RSA') then OpenRSAKey(key,0);
   if Form1.Caption='����������� �������� ������� El Gamal' then OpenElGamalKey(key,0);
   if (Form1.Caption='������� ��� �� ������ ��������� �����-������') then OpenFSKey(key,0);
   if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then OpenDHKey(key,0);
     if Form1.sCheckBox1.Checked=true then SendMes('*�������� ����:' + box2.Text)
  else Form1.box.Text:= '*�������� ����:' + box2.Text;
  inc(w); if w=2 then begin
  sEdit2.Enabled:=true; w:=0;
  end;
  end;
  if sCB1.ItemIndex=1 then begin
   if w=0 then sPanel1.Caption:='';
  sPanel1.Caption:=  sPanel1.Caption + '�������� ����:'+box2.Text +#13#10;
  if (Form1.Caption='����������� �������� ������� RSA') then OpenRSAKey(key,1);
   if Form1.Caption='����������� �������� ������� El Gamal' then OpenElGamalKey(key,1);
   if (Form1.Caption='������� ��� �� ������ ��������� �����-������') then OpenFSKey(key,1);
   if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then OpenDHKey(key,1);
   inc(w); if w=2 then begin
    w:=0;  sEdit2.Enabled:=true; end;
  end;
  end;
end;

procedure TForm1.sButton9Click(Sender: TObject);
begin
  sTabSheet1.TabVisible:=true;
  Form1.Height:=616;
  DHKeyFormirovanie();
  sEdit2.Enabled:=true;
  sButton2.Enabled:=true;


end;

procedure TForm1.sWebLabel5Click(Sender: TObject);
var p,q :Integer;
begin
randomize;
if (Form1.Caption='����������� �������� ������� RSA') then  begin
p:= random(100000000);
while not (CanonDec(p)) do p:= random(100000000);
peditrsa.Text:= IntToStr(p);
q:= random(100000000);
while not (CanonDec(q)) do q:= random(100000000);
qEdit.Text:= IntToStr(q);
end;
if (Form1.Caption='������� ��� �� ������ ��������� �����-������') then  begin
  p:= random(100);
  while not (CanonDec(p)) do p:= random(100);
  peditrsa.Text:= IntToStr(p);
  q:= random(100);
  while not (CanonDec(q)) do q:= random(100);
  qEdit.Text:= IntToStr(q);
end;
end;

procedure TForm1.sButton10Click(Sender: TObject);
begin
 sTabSheet1.TabVisible:=true;
 Form1.Height:=616;
 if (Form1.Caption='����������� �������� ������� RSA') then  KeyFormirovanieRSA();
 if (Form1.Caption='������� ��� �� ������ ��������� �����-������') then  begin
 KeyFormirovanieFS(); proc2.Visible:=true;
 end;
 sEdit2.Enabled:=true;
 sButton2.Enabled:=true;
end;

procedure TForm1.sSpeedButton1Click(Sender: TObject);
begin
sEdit2.Text:='';
end;

procedure TForm1.N9Click(Sender: TObject);
begin
Form1.Close; Form2.Close;
end;

procedure TForm1.N7Click(Sender: TObject);
begin
  pEdit.Text:=''; qEdit.Text:=''; xEdit.Text:='';
  peditrsa.Text:=''; gEdit.Text:='' ;
  sEdit2.Text:=''; sMemo1.Text:='';
  proc.Caption:=''; create.Text:=''; dec.Text:='';
  sTabSheet1.TabVisible:=false; sTabSheet2.TabVisible:=false; sTabSheet3.TabVisible:=false;
  sPanel1.Caption:='';   sPanel2.Caption:='';
   //server.Checked:=false;  client.Checked:=false;
 formRSA.Visible:=false; formGamal.Visible:=false;
 formDH.Visible:=false;
 con.Caption:='';
 o:=0; hashmes:=''; box.Text:='';
 transkey.Visible:=false;
 sCheckBox1.Visible:=false;
  proc2.Visible:=false;
  Form1.sPanel1.Font.Size:=10;
  Form1.Height:=405;
  sButton2.Enabled:=false;
  no.Visible:=false;
  yes.Visible:=false;
  sEdit2.Enabled:=False;

 end;

procedure TForm1.Y1Click(Sender: TObject);
begin
 N7.Click;
 server.Checked:=false;  client.Checked:=false;
 Disconect();
 sEdit2.Enabled:=false;
end;

procedure TForm1.sCheckBox1Click(Sender: TObject);
begin
if sCheckBox1.Checked=false then transkey.Enabled:=true
else transkey.Enabled:=false;
end;

procedure TForm1.transkeyClick(Sender: TObject);
begin
SendMes(box.Text);
end;

procedure TForm1.sWebLabel7Click(Sender: TObject);
var q, g, x: int64;
begin
randomize;
q:= random(100);
while not (CanonDec(q)) or (q<10) do q:= random(100);
qDHEdit.Text:= IntToStr(q);
g:= random(q-1);
while not (CanonDec(g))  do g:= random(q-1);
gDHEdit.Text:= IntToStr(g);
x:= random(10);
while not (CanonDec(x)) do x:= random(10);
xDHEdit.Text:= IntToStr(x);

end;

procedure TForm1.ServerSocket1ClientDisconnect(Sender: TObject;
  Socket: TCustomWinSocket);
begin
ShowMessage('������ �������� ����������!');
Y1.Click;
end;




procedure TForm1.ClientSocket1Error(Sender: TObject;
  Socket: TCustomWinSocket; ErrorEvent: TErrorEvent;
  var ErrorCode: Integer);
begin
if ErrorCode=10061 then begin
ShowMessage('��������� ��� ��� �� ���������!');
exit;
end;
end;



procedure TForm1.P1Click(Sender: TObject);     //��������
begin
   if (Form1.Caption='����������� �������� ������� RSA') then box2.Text:=SaveRSAKey(1);
   if Form1.Caption='����������� �������� ������� El Gamal' then box2.Text:=SaveElGamalKey(1);
   if (Form1.Caption='������� ��� �� ������ ��������� �����-������') then box2.Text:=SaveFSKey(1);
   if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then box2.Text:=SaveDHKey(1);
   sSaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  If sSaveDialog1.Execute Then
  box2.Lines.SaveToFile(sSaveDialog1.FileName +'.key');
end;

procedure TForm1.N13Click(Sender: TObject);   //��������
begin
   if (Form1.Caption='����������� �������� ������� RSA') then box2.Text:=SaveRSAKey(0);
   if Form1.Caption='����������� �������� ������� El Gamal' then box2.Text:=SaveElGamalKey(0);
   if (Form1.Caption='������� ��� �� ������ ��������� �����-������') then box2.Text:=SaveFSKey(0);
   if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then box2.Text:=SaveDHKey(0);
   sSaveDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  If sSaveDialog1.Execute Then
  box2.Lines.SaveToFile(sSaveDialog1.FileName +'.key');
end;

procedure TForm1.N10Click(Sender: TObject);   //�������� �������� ����
var key:String;
begin
  if w=0 then sPanel1.Caption:='';
  sOpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  If sOpenDialog1.Execute Then
  begin
  sEdit3.Text:= sOpenDialog1.FileName ;
  box2.Lines.LoadFromFile(sOpenDialog1.FileName);
  key:= box2.Text;
  sPanel1.Caption:=  sPanel1.Caption + '�������� ����:'+box2.Text +#13#10;
  if (Form1.Caption='����������� �������� ������� RSA') then OpenRSAKey(key, 1);
   if Form1.Caption='����������� �������� ������� El Gamal' then OpenElGamalKey(key, 1);
   if (Form1.Caption='������� ��� �� ������ ��������� �����-������') then OpenFSKey(key,1);
   if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then OpenDHKey(key,1);
  end;
  inc(w); if w=2 then begin
  sEdit2.Enabled:=true;
  w:=0;
  end;
end;

procedure TForm1.N11Click(Sender: TObject);   //�������� �������� ����
var key:String;
begin
  if w=0 then  sPanel1.Caption:='';
  sOpenDialog1.InitialDir:=ExtractFilePath(Application.ExeName);
  If sOpenDialog1.Execute Then
  begin
  sEdit3.Text:= sOpenDialog1.FileName ;
  box2.Lines.LoadFromFile(sOpenDialog1.FileName);
  key:= box2.Text;
  sPanel1.Caption:=  sPanel1.Caption + '�������� ����:'+box2.Text +#13#10;
  if (Form1.Caption='����������� �������� ������� RSA') then OpenRSAKey(key,0);
   if Form1.Caption='����������� �������� ������� El Gamal' then OpenElGamalKey(key,0);
   if (Form1.Caption='������� ��� �� ������ ��������� �����-������') then OpenFSKey(key,0);
   if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then OpenDHKey(key,0);
   if Form1.sCheckBox1.Checked=true then SendMes('*�������� ����:' + box2.Text)
  else Form1.box.Text:= '*�������� ����:' + box2.Text;
  end;
  inc(w); if w=2 then begin
  w:=0;
  sEdit2.Enabled:=true;
   end;
end;

procedure TForm1.N2Click(Sender: TObject);    //��������� ���������
begin
   sOpenDialog2.InitialDir:=ExtractFilePath(Application.ExeName);
  If sOpenDialog2.Execute Then
  begin
  box2.Lines.LoadFromFile(sOpenDialog2.FileName);
  sEdit2.Text:=box2.Text;
  end;
end;



procedure TForm1.sEdit1KeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08) and(Key<>'.') then
     Key:=#0;

end;

procedure LoadInstProg();
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + '���������\����������� ������������.doc';
    Word.Documents.Open(name, ReadOnly:=true);
  end;

 procedure TForm1.qeditKeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08)  then
     Key:=#0;
end;

   procedure TForm1.peditrsaKeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08) and(Key<>'.') then
     Key:=#0;
end;

 procedure TForm1.GeditKeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08) then
     Key:=#0;
end;

procedure TForm1.pEditKeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08)  then
     Key:=#0;

end;

procedure TForm1.xEditKeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08)  then
     Key:=#0;
end;

 procedure TForm1.xDHeditKeyPress(Sender: TObject; var Key: Char);
    var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08)  then
     Key:=#0;
end;

procedure TForm1.qDHeditKeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08)  then
     Key:=#0;
end;


procedure TForm1.N15Click(Sender: TObject);
begin
LoadInstProg();
end;

procedure TForm1.N14Click(Sender: TObject);
var Word:variant;  name:string;
begin
    Word:=CreateOleObject('Word.Application');
    Word.Visible:=true;
    name:= ExtractFilePath(Application.ExeName) + '���������\����������� ������������.doc';
    Word.Documents.Open(name, ReadOnly:=true);
end;

procedure TForm1.N17Click(Sender: TObject);
begin
Form9.Show;
end;

procedure TForm1.gDHeditKeyPress(Sender: TObject; var Key: Char);
var i:Integer;
begin
     if (Key<>'0') and (Key<>'1') and (Key<>'2') and (Key<>'3') and
     (Key<>'4') and (Key<>'5') and (Key<>'6') and (Key<>'7') and (Key<>'8') and
     (Key<>'9') and (Key<>'0') and  (Key<>#08) then
     Key:=#0;
end;

end.
