unit EDS_ElGamal;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdHTTP, IdHashMessageDigest, Math;
  procedure GamalKeyFormirovanie();
  procedure GamalEncrypt();
  function GamalDecrypt():string;
    function SaveElGamalKey(l:integer):string;
  procedure OpenElGamalKey(key:string; l: integer);
implementation
Uses Unit1, BaseOperationLib, InternetLib;

var a,p,g,x,y:int64;
 Timer:TDateTime=0;


procedure GamalKeyFormirovanie();
var
i:integer;
//a,p,x:int64;
buf: longint;
STR, bufs2: string;
C:char;
begin
randomize;
if not TryStrToInt64(Form1.pEdit.Text, p) then begin
ShowMessage('�������� p ������ ���� ������� ����� ������!');  exit; end;
if not TryStrToInt64(Form1.gEdit.Text, g) then begin
ShowMessage('�������� g ������ ����  ����� ������!');  exit; end;
if not TryStrToInt64(Form1.xEdit.Text, x) then begin
ShowMessage('�������� x ������ ���� ����� ������!!');  exit; end;
if not CanonDec(p) then begin  ShowMessage('����� p - �� �������!' ); exit;  end;
if p<300 then begin  ShowMessage('����� p ������� ����!' ); exit;  end;
if not CanonDec(g) then begin  ShowMessage('����� g - �� �������!'); exit;  end;
if g>p then  begin  ShowMessage('����� g ������ ���� ������ p! '); exit;  end;


Form1.proc.Caption:= Form1.proc.Caption + '-------------������ ��������� ������������ ������:-------------' + #13#10 + #13#10;
Form1.proc.Caption:= Form1.proc.Caption + 'p = ' + IntToStr(p) +#13#10 +
'g = ' + IntToStr(g) +#13#10 +
'x = ' + IntToStr(x) + #13#10+#13#10;
 Form1.proc.Caption:= Form1.proc.Caption + '������ ���� y:';
y:= stdown(g,x,p,1);
Form1.proc.Caption:= Form1.proc.Caption + 'y = g^x mod p = '+ IntToStr(g)+'^'+
IntToStr(x) +' mod ' +IntToStr(p) +' = '+IntToStr(y)+#13#10;
Form1.sPanel1.Caption:='�������� ����:' + IntToStr(x)+ #13#10 +
                        '�������� ����:' + IntToStr(y);
Form1.proc.Caption:=Form1.proc.Caption + '�������� ����:' + IntToStr(x)+ #13#10 +
                        '�������� ����:' + IntToStr(y)+#13#10;
Form1.proc.Caption:= Form1.proc.Caption + '-------------��������� ������������ ������ ���������:-------------' + #13#10 + #13#10;
if Form1.sCheckBox1.Checked=true then
SendMes('*�������� ����:' + IntToStr(x))
else Form1.box.Text:= '*�������� ����:' + IntToStr(x);
end;

function DecToHex(DecInt: Integer): String;
var s1,s2:String;
begin
//s1:=IntToStr(DecInt div 16);
case DecInt div 16 of
10: s1:='A';
11: s1:='B';
12: s1:='C';
13: s1:='D';
14: s1:='E';
15: s1:='F';
else
s1:=IntToStr(DecInt div 16);
end;
end;

function HexToDec(const HexStr: String): integer;
var d, i: integer;
begin
Result := 0;
for i := 1 to Length(HexStr) do
begin
if HexStr[i] in ['A'..'F'] then
begin
case HexStr[i] of
  'A': d:=10;
  'B': d:=11;
  'C': d:=12;
  'D': d:=13;
  'E': d:=14;
  'F': d:=15;
  end;
  end else
d:= StrToInt(HexStr[i]);

Result := Result + d * Round(Power(16, Length(HexStr) - i));
end;
end;



 function HexToStr(hex: string): string;
var
  i: Integer;
begin
//  hex:= StringReplace(hex, ' ', '', [rfReplaceAll]);
 // for i:= 1 to Length(hex) div 2 do
    Result:=Char(StrToInt('$' + hex));
end;


procedure GamalEncrypt();
var
i:integer;
b,k, M:int64;
buf: longint;
STR, bufs2, bbuf: string;
Shifr: array of integer;
C:char;
Messege: array of integer;
begin
randomize;
bufs2:='';
STR:='g'+ md5('> '+Form1.nikname.Text+'('+GetLocalIP+'): ' +Form1.sEdit2.Text);
Form1.create.Text:= '��� ������������� ���������: '+STR + #13#10 + #13#10;
Form1.create.Lines.Add('---------------������ ���������� ���� ���������:---------------');
timer:=Now;
SetLength (Messege, Length(Str));
SetLength (Shifr, Length(Str));
for i:=0 to Length(Str)-1 do begin
C:=Str[i+1];
Messege[i]:=HexToDec(IntToHex(integer(C),2));
bufs2:=bufs2+IntToStr(Messege[i])+' ';
end;
//Form1.sMemo1.Lines.Add('�������� ����� � �������� �������������:');
Form1.create.Lines.Add('������� ������ ������ ��� ascii-�����:');
Form1.create.Lines.Add(bufs2);
Form1.create.Lines.Add('');
k:=Random(p-1);
while (GetNOD(p-1,k)<>1) or (k<0) do k:=random(p-1);
Form1.create.Lines.Add('������� ��������� ����� k =' + inttostr(k));
Form1.create.Lines.Add('');
a:=stdown(g,k,p,1);
//a:=trunc(Power(g,k));
Form1.create.Lines.Add('���������� ���� a = g^k mod p = ' +
IntToStr(g) + '^' + IntToStr(k) + 'mod ' + IntToStr(p) + ' = '  + inttostr(a) +#13#10);
//a:=a mod p;
//sMemo2.Lines.Add('= ' + inttostr(a));
bufs2:='';  bbuf:='';
Form1.create.Lines.Add('�������� �������������� ������� ��������:');
for i:=0 to Length(Str)-1 do  begin
//Form1.sMemo1.Lines.Add('b:' + inttostr(y) + ' ^ ' + inttostr(k));
b:=stdown(y,k,p,Messege[i]);
Form1.create.Lines.Add('b['+ IntToStr(i) + '] = C['+IntToStr(i)+']*' +IntToStr(x)+ '^'+
IntToStr(k)+ ' mod ' + IntToStr(p) + ' = ' + inttostr(b));
 //Form1.create.Lines.Add('���������� ���� a:' + inttostr(a));
Shifr[i]:=b;
bufs2:=bufs2 + inttostr(b) + ' ';
bbuf:=bbuf+IntToStr(a) +' ' + IntToStr(b);
end;
 Form1.create.Lines.Add('');
 Form1.create.Lines.Add('---------------���������� ���� ��������� ���������:---------------');
    Form1.create.Lines.Add('');
   Form1.create.Lines.Add('���������� ���:');
   Form1.create.Lines.Add(bbuf);
   Form1.create.Lines.Add('');
   Form1.create.Lines.Add('������������ �������� ���.');
   Form1.create.Lines.Add('����� ������������ ���: ' + FormatDateTime('ss,zzz', Now-timer) + '���');
   ShowMessage('����� ������������ ���: ' + FormatDateTime('ss,zzz', Now-timer) + '���');
//Form1.sMemo1.Lines.Add('���������� ���� = ' + inttostr(a));
//Form1.sMemo1.Lines.Add('��������� ���� = ' + inttostr(x));
//Form1.sMemo1.Lines.Add('������������� �����: ' + bufs2);
SendMes('$'+bufs2 + ' $'+inttostr(a)+'$'+inttostr(p)+'$');
end;



function GamalDecrypt():string;
var i,j, len:integer;   M,buf:int64; Text, key, chislo, hash, hash0, bbuf:string;
Shifr: array of integer;
begin
Form1.sTabSheet3.Visible:=true;
hash:=''; hash0:=''; bbuf:='';
//Form1.sMemo1.Text:=Form1.sMemo1.Text+#13#10;
 Text:=Form1.box.Text; len:=1;
 for j:=1 to Length(Text) do begin
     if Text[j]=' ' then inc(len);
 end;
 len:=len-2;  //Text:=Text+' ';
 SetLength(Shifr,len); j:=1; i:=0;
 //while (j<Length(Text)) or (j= Length(Text))
 while (i<len)
 do begin
   chislo:='';
   while (Text[j]<>' ') do begin chislo:=chislo+Text[j]; inc(j); end;
   if Text[j]=' ' then begin
   Shifr[i]:=StrToInt(chislo);
   inc(j); inc(i);
   end;
 end;
j:=j+2;
 //ShowMessage(Text[j]);
 chislo:='';
 while(Text[j]<>'$') do begin chislo:=chislo+Text[j]; inc(j); end;
 a:=StrToInt(chislo); inc(j);
  chislo:='';
 while(Text[j]<>'$') do begin chislo:=chislo+Text[j]; inc(j); end;
 p:=StrToInt(chislo);
   chislo:='';  j:=1;
 for i:=0 to len-1 do bbuf:=bbuf+ IntToStr(a) + ' '+ IntToStr(Shifr[i]);
 Form1.dec.Lines.Add('���������� ��� ���������:');
 Form1.dec.Lines.Add(bbuf);
 key:= Form1.sPanel1.Caption;
    Form1.dec.Lines.Add(key);
 while(key[j]<>':') do inc(j);
 inc(j);
 while (j<Length(key)+1) do begin  chislo:=chislo+key[j]; inc(j); end;
 x:=StrToInt(chislo);
 Form1.dec.Lines.Add('');
 Form1.dec.Lines.Add('---------------������ ������������� ���:---------------');
 timer:=Now;
 Form1.dec.Lines.Add('C[i] = b[i]*a^(p-y-1) mod p '+ #13#10);
for i:=0 to len-1 do  begin
buf:=p-x-1;   // ������� ����� a
Form1.dec.Lines.Add('����������� ������ ���� ���:');
M:=stdown(a,buf, p, Shifr[i]);
Form1.dec.Lines.Add('C['+ IntToStr(i) + '] = b['+IntToStr(i)+']*' +IntToStr(a)+ '^'+
IntToStr(buf)+ ' mod ' + IntToStr(p) + ' = ' + inttostr(M));
//buf:=stepen(a,buf); // �������� ����� a � �������
//M:=Shifr[i]*buf;
//M:=M mod p;
//Form1.sMemo1.Text:=Form1.sMemo1.Text+chr(M);
hash:=hash+chr(M);
hash0:=hash0+IntToStr(M);
end;
Form1.dec.Lines.Add('');
   Form1.dec.Lines.Add('��������������� ���:');
   Form1.dec.Lines.Add(hash0);
   Form1.dec.Lines.Add('');
   Form1.dec.Lines.Add('��������� ������ ������������������ � ���������� ������:') ;
   Form1.dec.Lines.Add(hash);
   Form1.dec.Lines.Add('---------------������������� ��� ���������---------------');
   Form1.dec.Lines.Add('');
   Form1.create.Lines.Add('����� �������� ���: ' + FormatDateTime('ss,zzz', Now-timer) + '���');
   ShowMessage('����� �������� ���: ' + FormatDateTime('ss,zzz', Now-timer) + '���');
Result:=hash;
end;

procedure OpenElGamalKey(key:string; l: integer);
var chislo:String; j:integer;
begin
 if l=0 then
  if not TryStrToInt64(key,x) then begin
 ShowMessage('������������ ����'); exit;end; //x:=StrToInt64(key);
 if l=1 then  if not TryStrToInt64(key,y) then begin
 ShowMessage('������������ ����'); exit;end; //y:=StrToInt64(key);
end;

function SaveElGamalKey(l:integer):string;
   begin
   if l=0 then Result:=IntToStr(x);
   if l=1 then Result:=IntToStr(y);
   end;


end.
