unit BaseOperationLib;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdHTTP, IdHashMessageDigest, Math;

function md5(s:string): string;
function GetNOD(a:int64; b:int64):int64;
function CanonDec (n:Int64):boolean;
function stdown(a,l,p:Int64; sh:integer):Int64;
function FoundN(a,b:Int64):Int64;
function GetMod(n:Int64; b:Int64; m:Int64):Int64;
function linsr(a,b,m:Int64):Int64;

var qn, ck, mk: array of Int64;
Pn: array of string;

implementation
uses Unit1, UMathServices;

function FoundN(a,b:Int64):Int64;
var c,nn,a1, b1:Int64; i:Integer;
begin
nn:=0; a1:=a; b1:=b;
while b>0 do begin   //1
c:=b;
b:= a mod b;
a:= c;
inc(nn);
end;
SetLength (Pn, nn+1);
for i:=0 to nn do Pn[i]:='';
SetLength (qn, nn+1);
for i:=0 to nn do qn[i]:=0;
qn[0]:=0; a:=a1; b:=b1;
for i:=1 to nn do begin   //2
qn[i]:= a div b;
c:=b; b:= a mod b;  a:= c;
end;   //-2
Pn[1]:=IntToStr(qn[1]); Pn[0]:= '1';
for i:=2  to nn do  //3
Pn[i]:=ulSum(ulMPL(IntToStr(qn[i]),Pn[i-1]),Pn[i-2]);
Result:=nn;
end;

function CanonDec (n:Int64):boolean;      //������������ ���������� �����
var n2, i, k,sq,d:Integer;
down, up: array [0..9] of Integer;
begin
for i:=0 to 9 do begin
 down[i]:=0; up[i]:=0;
 end;
i:=0;
n2:=n;
d:=2;
i:=0;
while (d<sqrt(n2)) or (d=sqrt(n2)) do begin             //2
k:=0;
  if (n mod d = 0) then begin     //3
  while n mod d = 0 do begin      //4
       n:= n div d;
       inc(k);
       end;                       //-4
  up[i]:= k;
  down[i]:= d;
  inc(i);
end;                   //-3
inc(d);
end;   //-2
if (n<>0) and (n<>1) then begin
up[i]:= 1;
down[i]:= n;
end;
 if (up[0]=1) and (down[1]=0) then Result:=true
 else Result:=false;
end;

function GetNOD(a:int64; b:int64):int64;   //���������� ���
var c:int64;
begin
if (b>a) then begin
c:=b;
b:=a;
a:=c;
end;
while (b<>0) do
begin
c:=a mod b;
a:=b;
b:=c;
end;
Result:=a;
end;

function md5(s:string): string;
begin;
with Form1 do begin
Result :='';
  with TIdHashMessageDigest5.Create do
    try Result:= AnsiLowerCase(AsHex(HashValue(s)));
  finally
  Free;
  end; end;
end;

//----------------��������� �������--------------------------//
function stdown(a,l,p:Int64; sh:integer):Int64; //�-�����, l - �������, p - mod, sh - ��������� (sh*a^l mod p)
var i,j:Integer;
bin, str:String;    st: array of Int64;
begin
if l=0 then begin
Result:= 1 mod p;
exit;
end;
bin:='';
 while l<>0 do begin     //������� ������� � �������� ����� (bin)
  bin:=IntToStr(l mod 2)+bin;
  l:=l div 2;
end;
   SetLength(st,Length(bin));
 for i:=0 to Length(bin)-1 do st[i]:=0;

for i:=1 to Length(bin) do begin    //����� ������ �������
if StrToInt(bin[(Length(bin)+1)-i])=1 then j:=(Length(bin)+1)-i;
end;

j:=j-1;
st[j]:=a;

 for i:=j+1 to Length(bin)-1 do begin
if StrToInt(bin[i+1])=0 then begin    //���� ����
//st[i]:= (st[i-1]*st[i-1]) mod p;
str:= ulPower(IntToStr(st[i-1]),'2');
st[i]:=StrToInt64(ulSub(str,ulMPL(IntToStr(p),UlDiv(str,IntToStr(p),0))));
if st[i]<0 then st[i]:= st[i]+p;
end;
if StrToInt(bin[i+1])=1 then begin
//st[i]:= (st[j]* st[i-1]) mod p;   //���� �������
str:= ulPower(IntToStr(st[i-1]),'2');
st[i]:=StrToInt64(ulSub(str,ulMPL(IntToStr(p),UlDiv(str,IntToStr(p),0))));
str:=ulMPL(IntToStr(st[i]),IntToStr(st[j]));
st[i]:=StrToInt64(ulSub(str,ulMPL(IntToStr(p),UlDiv(str,IntToStr(p),0))));
//st[i]:= st[i]*st[i-1] mod p;
if st[i]<0 then st[i]:= st[i]+p;
end;
end;
Result:=(Sh*st[Length(bin)-1]) mod p;
end;

function GetMod(n:Int64; b:Int64; m:Int64):Int64;
var //sun:Integer;
pp:Real;
sun:string;
begin
pp:=Power(-1,n-1);
if pp>0 then sun:= ulMPL(Pn[n-1],IntToStr(b))//sun:= Pn[n-1]*b
else sun:=ulMPL(Pn[n-1],IntToStr(-1*b));//sun:= (-1)*Pn[n-1]*b;
//sun:= sun mod m;
sun:=ulSub(sun,ulMPL(UlDiv(sun,IntToStr(m),0),IntToStr(m)));
if StrToInt64(sun)<0 then sun:=IntToStr(StrToInt64(sun)+m);
Result:=StrToInt64(sun);
end;

function linsr(a,b,m:Int64):Int64;
var n, x1, i, NOD:Integer;
xn:array of Integer;
begin
NOD:=GetNOD(a,m);
if NOD=1 then begin
n:=FoundN(m,a);
Result:=GetMod(n,b,m);
//Label2.Caption:= 'x = ' + IntToStr(GetMod(n,b,m));
end
else Result:=-1;
end;

 end.




