unit InternetLib;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ScktComp, Winsock, sButton;

  function GetLocalIP: String;
  procedure SendMes(Text: String);
  procedure Connect();
  procedure Disconect();

implementation
uses Unit1;

function GetLocalIP: String;
const WSVer = $101;
var
  wsaData: TWSAData;
  P: PHostEnt;
  Buf: array [0..127] of Char;
begin
  Result := '';
  if WSAStartup(WSVer, wsaData) = 0 then begin
    if GetHostName(@Buf, 128) = 0 then begin
      P := GetHostByName(@Buf); 
      if P <> nil then
        Result := iNet_ntoa(PInAddr(p^.h_addr_list^)^); 
    end; 
    WSACleanup;
  end;
end;

procedure SendMes(Text: String);
var i:Integer;
begin
with Form1 do begin
  if ServerSocket1.Active then  begin
    if ServerSocket1.Socket.ActiveConnections>0 then
      for i:=0 to ServerSocket1.Socket.ActiveConnections-1 do
      ServerSocket1.Socket.Connections[i].SendText(Text);
      end;
  if ClientSocket1.Active then
    ClientSocket1.Socket.SendText(Text);
end;
end;

procedure Connect();
begin;
with Form1 do begin
if (server.Checked=False) and  ( client.Checked=False )
then begin
ShowMessage('������� ��� �����������!');
exit;
end;
if (server.Checked=True) and  ( client.Checked=True )
then begin
ShowMessage('������� ���� ��� �����������!');
exit;
end;
if nikname.Text='' then begin
ShowMessage('������� ���� �������!');
exit;
end;
if (server.Checked=True) then begin
Form1.Left:=0; Form1.Top:=0;
 server.Enabled:=false; client.Enabled:=false;
  if Form1.Caption='����������� �������� ������� El Gamal' then
ServerSocket1.Port:=65000;
if (Form1.Caption='����������� �������� ������� RSA')  then
ServerSocket1.Port:=65001;
if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then
ServerSocket1.Port:=65002;
if Form1.Caption='������� ��� �� ������ ��������� �����-������' then
ServerSocket1.Port:=65003;
  ServerSocket1.Active:=True; // ���������� ������
  ServerSocket1.Open; //���������
   //ShowMessage('��� IP: '+GetLocalIP); //������ ��� IP �����, ���� ������ ���� � ��� ������������
   sLabel1.Caption:= '��� IP: '+GetLocalIP;
   //sPanel1.Caption:='��������� ����������� �������...';
   con.Caption:='�������� �������...' ;
   sButton8.Visible:=true;
   end;
if ( client.Checked=True ) then begin
if   sEdit1.Text='' then begin
 ShowMessage('������� IP-����� �������!');
exit;
end;
  Form1.Left:=690; Form1.Top:=0;
  server.Enabled:=false; client.Enabled:=false;
  ClientSocket1.Address:=sEdit1.Text; // IP ����� �������
if Form1.Caption='����������� �������� ������� El Gamal' then
ClientSocket1.Port:=65000;
if (Form1.Caption='����������� �������� ������� RSA')  then
ClientSocket1.Port:=65001;
if Form1.Caption='������� ��� �� ������ ��������� �����-��������' then
ClientSocket1.Port:=65002;
if Form1.Caption='������� ��� �� ������ ��������� �����-������' then
ClientSocket1.Port:=65003;

  ClientSocket1.Active:=True; //���������� �������
  ClientSocket1.Open; //���������
  sButton7.Enabled:=true;
end;
//sGroupBox3.Enabled:=true;
end;
end;

procedure Disconect();
begin
  with Form1 do begin
  if (ServerSocket1.Active=true) then begin
  SendMes('%');
  ServerSocket1.Close;
  //ServerSocket1.Active:=False; // ������������� ������
  end;
  if ( ClientSocket1.Active=true ) then begin
  ClientSocket1.Close;
  //ClientSocket1.Active:=False; //������������� �������

  end;
  end;
end;

end.
 