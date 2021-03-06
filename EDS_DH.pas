unit EDS_DH;

interface
 uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, IdHTTP, IdHashMessageDigest, Math;
  procedure DHKeyFormirovanie();
   procedure DHEncrypt();
   procedure DHDecrypt(m:string);
     function SaveDHKey(l:integer):string;
  procedure OpenDHKey(key:string; l: integer);
implementation
 Uses Unit1, BaseOperationLib, InternetLib, UMathServices;

 var q,g,x:int64;
 y:string;
  Timer:TDateTime=0;

 procedure DHKeyFormirovanie();
 var i:integer;
 begin
 randomize;
if not TryStrToInt64(Form1.qDHEdit.Text, q) then begin
ShowMessage('�������� q ������ ���� ����� ������!!');  exit; end;
if not TryStrToInt64(Form1.gDHEdit.Text, g) then begin
ShowMessage('�������� g ������ ����  ����� ������!');  exit; end;
if not TryStrToInt64(Form1.xDHEdit.Text, x) then begin
ShowMessage('�������� x ������ ����  ����� ������!');  exit; end;
if not CanonDec(q) then begin  ShowMessage('����� q - �� �������!' ); exit;  end;
//if q<300 then begin  ShowMessage('����� q ������� ����!' ); exit;  end;
if not CanonDec(g) then begin  ShowMessage('����� g - �� �������!'); exit;  end;
if g>q then  begin  ShowMessage('����� g ������ ���� ������ q! '); exit;  end;
Form1.proc.Caption:= Form1.proc.Caption + '-------------������ ��������� ������������ ������:-------------' + #13#10 + #13#10;
Form1.proc.Caption:= Form1.proc.Caption + 'q = ' + IntToStr(q) +#13#10 +
'q = ' + IntToStr(g) +#13#10 +
'x = ' + IntToStr(x) + #13#10+#13#10;
 Form1.proc.Caption:= Form1.proc.Caption + '������ �������� ����:';
//y:= stdown(g,x,q,1);
y:=ulPower(IntToStr(g),IntToStr(x));
Form1.proc.Caption:= Form1.proc.Caption + 'y = g^x mod q = '+ IntToStr(g)+'^'+
IntToStr(x) +' mod ' +IntToStr(q) +' = '+y+#13#10;
Form1.sPanel1.Caption:='�������� ����:' + y+ #13#10 +
                        '�������� ����:' + IntToStr(x);
Form1.proc.Caption:=Form1.proc.Caption + '�������� ����:' + y+ #13#10 +
                        '�������� ����:' + IntToStr(x)+#13#10;
Form1.proc.Caption:= Form1.proc.Caption + '-------------��������� ������������ ������ ���������:-------------' + #13#10 + #13#10;

if Form1.sCheckBox1.Checked=true then
 SendMes('*�������� ����:' + y)
 else Form1.box.Text:= '*�������� ����:' + y;
 end;

 procedure DHEncrypt();
 var hash,u, m, s1, s2,s3,s4,s5,v,v2: string; h,n,r, r2, s,bm,k:int64;  i:integer;
 begin
 randomize;
 Form1.create.Lines.Add('---------------������ ������������ ���:---------------');
 timer:=Now;
 m:= '> '+Form1.nikname.Text+'('+GetLocalIP+'): ' +Form1.sEdit2.Text;
 Form1.create.Lines.Add('������������ ��������� m = ' +Form1.sEdit2.Text );
 bm:=Random(q-1);  //k=1
 Form1.create.Lines.Add('���������� ��� bm =' + IntToSTr(bm)) ;
 h:=0;  n:=0; v:=''; r:=0; s:=0; r2:=0;
 hash:=md5(m+IntToStr(bm));
  for i:=1 to Length(hash) do h:=h+ord(hash[i]);
 h:=h mod 33;
 Form1.create.Lines.Add('���-������� h = H(m, bm) = ' + IntToStr(h) );
 Form1.create.Lines.Add('');
 hash:='';
 //u:= stdown(h,x,q,1);
 u:=UlPower(IntToStr(h), IntToStr(x));
 Form1.create.Lines.Add('u = h^x = ' + IntToStr(h) + '^' + IntToStr(x) + ' = '+ u);
 hash:= md5(m+IntToStr(g)+IntToStr(h)+y+u);
 for i:=1 to Length(hash)do n:=n+ord(hash[i]);
 n:=n mod 33;
 Form1.create.Lines.Add('���-������� n = L(m, g, h, y, u) = ' + IntToStr(n) );
 Form1.create.Lines.Add('');
 hash:='';
 k:=random(330);
 while k<(x*33) do k:=random(330);
 Form1.create.Lines.Add('��������� ����� k = ' + IntToStr(k) );
 //v:= stdown(g,n,q,h);
 v:=ulMPL(IntToStr(h),ulPower(IntToStr(g),IntToStr(n)));
 v2:=ulPower(v,IntToStr(k));
 Form1.create.Lines.Add('v = (g^n * h)^k = (' + IntToStr(g)+'^'+
 IntToStr(n) + ' * ' + IntToStr(h)+')^' + IntToStr(k) +' = '+
 v2 );
 Form1.create.Lines.Add('');
 hash:= md5(m+IntToStr(g)+IntToStr(h)+y+u+v2);
 for i:=1 to Length(hash)do r:=r+ord(hash[i]);
 r:=r mod 33;
 Form1.create.Lines.Add('���-������� r = G(m, g, h, y, u, v) = ' + IntToStr(r) );
 Form1.create.Lines.Add('');
 //s:=(1-x*r) mod q;
 //s1:= ulMPL(IntToStr(x), IntToStr(r));
 //s2:= ulDiv(s1,IntToStr(q),0);
 //s:=stdown(r,1,q,x);
// if s<0 then s:=s+q;
 s:=k-x*r;
 s1:=IntToStr(s);
 Form1.create.Lines.Add('S = k - x*r = '+ IntToStr(k) + ' - ' +
 IntToStr(x)+'*'+ IntToStr(r)+' = ' + s1);
  //s3:= ulMPL(IntToStr(q),s2) ;
 //s4:= ulSub(s1,s3);
 //if StrToInt64(s1)<1 then
 //s1:=ulSum(1,IntToStr(q));
 //s:= StrToInt64(s1);
 //Form1.create.Text:=IntToStr(s);
 Form1.create.Lines.Add('');
 Form1.create.Lines.Add('���������� ���: ( '+u+', ' +IntToStr(r)+', '+s1+', '+
 IntToStr(bm)+' )' + #13#10);
  Form1.create.Lines.Add('---------------������������ ��� ���������:---------------' + #13#10);
  Form1.create.Lines.Add('����� ������������ ���: ' + FormatDateTime('ss,zzz', Now-timer) + '���');
   ShowMessage('����� ������������ ���: ' + FormatDateTime('ss,zzz', Now-timer) + '���');
  //s2:=''; s3:='';s4:='';s5:='';
 //s2:= ulMPL(IntToStr(h),ulPower(IntToStr(g),IntToStr(n)));
 //s5:=ulPower(s2,s1);  //(g^n*h)^S
 //s3:= ulMPL(u,ulPower(y,IntToStr(n)));
 //s4:= ulPower(s3,IntToStr(r)); //(y^n*u )^r
 //s1:=ulMPL(s5,s4);
 //hash:= md5(m+IntToStr(g)+IntToStr(h)+y+u+s1);
 //for i:=1 to Length(hash)do r2:=r2+ord(hash[i]);
 //r2:=r2 mod 33;
  //Form1.create.Lines.Add('���������� ���: ( '+u+', ' +IntToStr(r)+', '+s1+', '+
 //IntToStr(bm)+' )');
 SendMes('$'+u+'$'+IntToStr(r)+'$'+s1+'$'+IntToStr(bm)+'$'+IntToStr(g)+'$');
 end;

 procedure DHDecrypt(m:string);
 var j, i:integer; Text, chislo,u,s,v, s1, s2,s3,s4, s5, key, hash:string;
 h,n,r, r2, bm,k:int64;
 begin
  s2:=''; s3:='';s4:='';s5:='';
  Text:=Form1.box.Text;
    j:=2;
  chislo:='';
 while(Text[j]<>'$') do begin chislo:=chislo+Text[j]; inc(j); end;
 u:=chislo; inc(j);
     chislo:='';
 while(Text[j]<>'$') do begin chislo:=chislo+Text[j]; inc(j); end;
 r:=StrToInt64(chislo); inc(j);
   chislo:='';
 while(Text[j]<>'$') do begin chislo:=chislo+Text[j]; inc(j); end;
 s:=chislo; inc(j);
   chislo:='';
 while(Text[j]<>'$') do begin chislo:=chislo+Text[j]; inc(j); end;
 bm:=StrToInt64(chislo); inc(j);
 chislo:='';
 while(Text[j]<>'$') do begin chislo:=chislo+Text[j]; inc(j); end;
 g:=StrToInt64(chislo); inc(j);
 key:= Form1.sPanel1.Caption;
    Form1.dec.Lines.Add(key);
    j:=1;
 while(key[j]<>':') do inc(j);
 inc(j);chislo:='';
 while (j<Length(key)+1) do begin  chislo:=chislo+key[j]; inc(j); end;
 y:=chislo;
 Form1.dec.Lines.Add('---------------������ �������� ���:---------------');
 timer:=Now;
 Form1.dec.Lines.Add('��� �������: ( '+u+', ' +IntToStr(r)+', '+s+', '+
 IntToStr(bm)+' )');
 Form1.dec.Lines.Add('u = ' + u);
 Form1.dec.Lines.Add('r = ' + IntToStr(r));
 Form1.dec.Lines.Add('S = ' +s);
 Form1.dec.Lines.Add('bm = ' + IntToStr(bm));
 Form1.dec.Lines.Add('');
  hash:=md5(m+IntToStr(bm));
  for i:=1 to Length(hash) do h:=h+ord(hash[i]);
  h:=h mod 33;
 Form1.dec.Lines.Add('���-������� h = H(m, bm) = ' + IntToStr(h) );
 Form1.dec.Lines.Add('');
 hash:='';
 //u:= stdown(h,x,q,1);
 hash:= md5(m+IntToStr(g)+IntToStr(h)+y+u);
 for i:=1 to Length(hash)do n:=n+ord(hash[i]);
 n:=n mod 33;
 Form1.dec.Lines.Add('���-������� n = L(m, g, h, y, u) = ' + IntToStr(n) );
 Form1.dec.Lines.Add('');
 hash:='';
 s2:= ulMPL(IntToStr(h),ulPower(IntToStr(g),IntToStr(n)));
 s5:=ulPower(s2,s);  //(g^n*h)^S
 s3:= ulMPL(u,ulPower(y,IntToStr(n)));
 s4:= ulPower(s3,IntToStr(r)); //(y^n*u )^r
 v:=ulMPL(s5,s4);
 Form1.dec.Lines.Add('v2 = (g^n * h)^S * (y^n * u)^r = (' +
 IntToStr(g)+'^'+IntToStr(n)+' * '+IntToStr(h)+')^' + s+ ' * ('+ y+'^'+
 IntToStr(n)+' * ' + u +')^' + IntToStr(r) + ' = ' + v);
 hash:= md5(m+IntToStr(g)+IntToStr(h)+y+u+v);
 for i:=1 to Length(hash)do r2:=r2+ord(hash[i]);
 r2:=r2 mod 33;
 Form1.create.Lines.Add('');
 Form1.create.Lines.Add('�������� ��������:' +#13#10 + 'r2 = G(m, g, h, y, u, v2) = ' + IntToStr(r2) );
 if r= r2 then begin
 Form1.dec.Lines.Add('r = r2' + #13#10 + '������� ������ ��������!' );
 Form1.yes.Visible:=true;
 Form1.no.Visible:=false;
 end
 else begin
 Form1.dec.Lines.Add('r <> r2' + #13#10 + '������� �� ������ ��������!' );
 Form1.no.Visible:=true;
 Form1.yes.Visible:=false;
 end;
 Form1.dec.Lines.Add('');
 Form1.dec.Lines.Add('---------------�������� ��� ���������:---------------' +#13#10);
 Form1.create.Lines.Add('����� �������� ���: ' + FormatDateTime('ss,zzz', Now-timer) + '���');
 ShowMessage('����� �������� ���: ' + FormatDateTime('ss,zzz', Now-timer) + '���');
 end;

 procedure OpenDHKey(key:string; l: integer);
var chislo:String; j:integer;
begin
 if l=0 then y:=key;
 if l=1 then  if not TryStrToInt64(key,x) then begin
 ShowMessage('������������ ����'); exit;end;
 //x:=StrToInt64(key);
end;

function SaveDHKey(l:integer):string;
   begin
   if l=0 then Result:=y;
   if l=1 then Result:=IntToStr(x);
   end;

end.
 