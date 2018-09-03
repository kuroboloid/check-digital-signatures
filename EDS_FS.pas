unit EDS_FS;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;
  procedure KeyFormirovanieFS();
  procedure FSEncrypt();
  procedure FSDecrypt(m:String);
  function SaveFSKey(l:integer):string;
  procedure OpenFSKey(key:string; l: integer);
var
  p,q,n,d,e:int64;
  s,v: array [0..31] of int64;
  Sstr, Vstr:String;
   Timer:TDateTime=0;
implementation
uses Unit1, BaseOperationLib, InternetLib, UMathServices;

procedure KeyFormirovanieFS();
var k,i:integer;   y: string;
   //v : array [0..31] of int64;
  begin
if not TryStrToInt64(Form1.peditrsa.Text, p) then begin
ShowMessage('Значение p должно быть целым числом!!');  exit; end;
if not TryStrToInt64(Form1.qEdit.Text, q) then begin
ShowMessage('Значение q должно быть целым числом!!');  exit; end;

 if not CanonDec(p) then begin
 ShowMessage('Число p - не простое!');  exit;
 end;
 if not CanonDec(q) then begin
 ShowMessage('Число q - не простое!');     exit;
 end;
 if (p>1000) or (q>1000) then begin ShowMessage('Для лучшего быстродействия выберете p и q меньше 10 000!');  exit; end;
 Form1.proc2.Text:=Form1.proc2.Text  + '-------------Начнем процедуру формирования ключей:-------------' + #13#10 + #13#10;
 n:=p*q; Form1.proc2.Text:= Form1.proc2.Text + 'n = p*q = ' + IntToStr(p) +'*' + IntToStr(q) + ' = '+ IntToStr(n) +  #13#10;
 randomize;
 k:=32;
 Form1.proc2.Text:= Form1.proc2.Text + 'Длина ключевой последовательности: k = 32' + #13#10 +#13#10 +
 'Генерация секретного ключа:' +#13#10 + 'S = ( ';
 Sstr:='( '; Vstr:='(';
 for i:=0 to 31 do begin
  s[i]:=Random(n-1);
  while (GetNOD(s[i],n)<>1) or (s[i]<0) do s[i]:=Random(n-1);
  if i<>31 then begin Form1.proc2.Text:= Form1.proc2.Text + IntToStr(s[i]) +', ';
  Sstr:=Sstr+IntToStr(s[i]) +', ' ;
   end
   else begin Form1.proc2.Text:= Form1.proc2.Text + IntToStr(s[i]);
  Sstr:=Sstr+IntToStr(s[i]);
   end;
 end;
  Sstr:=Sstr + ')';
  Form1.proc2.Text:= Form1.proc2.Text +')' + #13#10+#13#10 +
  'Сформируем открытый ключ : (s[i])^2*v[i] = 1 mod n;' + #13#10 + 'V = (';
   for i:=0 to 31 do begin
   v[i]:=linsr(StrToInt64(ulPower(IntToStr(s[i]),'2')),1,n);
   if i<>31 then begin Vstr:=Vstr + IntToStr(v[i]) + ', ';
   Form1.proc2.Text:= Form1.proc2.Text + IntToStr(v[i]) +', ';
   end
   else begin Vstr:=Vstr + IntToStr(v[i]);
   Form1.proc2.Text:= Form1.proc2.Text + IntToStr(v[i]);
   end;
  end;
  Vstr:=Vstr +')';
  Form1.proc2.Text:= Form1.proc2.Text +')' + #13#10 ;
   Form1.sPanel1.Caption:=' Закрытый ключ: '+ Sstr;
   Form1.sPanel1.Font.Size:=6;
 if Form1.sCheckBox1.Checked=true then
 SendMes('*Открытый ключ: ' +Vstr)
 else Form1.box.Text:= '*Открытый ключ: ' + Vstr ;
 Form1.proc2.Text:= Form1.proc2.Text + #13#10 + '-------------Процедура формирования ключей завершена:-------------' + #13#10 + #13#10;
  end;

 procedure FSEncrypt();
 var r:int64; estr, y,x,m, y1, z,z1:string; i:integer;
 e : array [0..31] of int64;
 begin
   randomize;
   r:=Random(n-1);
   while r<2 do r:=Random(n-1);
   x:=ulPower(IntToStr(r),'2');
   x:= ulSub(x, ulMPL(IntToStr(n), ulDiv(x,IntToStr(n),0)));
   m:=md5('> '+Form1.nikname.Text+'('+GetLocalIP+'): ' +Form1.sEdit2.Text);
   Form1.create.Text:= 'Хэш отправляемого сообщения: '+m + #13#10 + #13#10;
    //Form1.sMemo1.Text:=Form1.sMemo1.Text +#13#10;
   Form1.create.Lines.Add('---------------Начнем шифрование формирование ЭЦП:---------------');
   timer:=Now;
   Form1.create.Lines.Add('');
   Form1.create.Lines.Add('Случайное число r = '+IntToStr(r) + ' (r < n)');
   Form1.create.Lines.Add('Вычисляем x = r^2 mod n :' +#13#10 + 'x = ' + IntToStr(r) +'^2 mod ' + IntToStr(n)+ ' = ' + x);
   Form1.create.Lines.Add('');
   Form1.create.Lines.Add('Вычисляем e = (e1, e2, ..., ek) = H(m,x) :' +#13#10);
   estr:=md5(m+x);
   Form1.create.Lines.Add('H('+m+', '+x+') = ' + estr);
   for i:=0 to 31 do begin
    //e[i]:=ord(m[i+1])*x mod 33;
    e[i]:=ord(estr[i+1]) mod 33;
    Form1.create.Lines.Add('e['+IntToStr(i)+'] =' + IntToStr(e[i]));
   end;
    y:='1';
     Form1.create.Lines.Add('');
     Form1.create.Lines.Add('Вычисляем y = r*((s1^e1)(s2^e2)...(sk^ek) mod n) :');
    for i:=0 to 31 do begin
    y1:= ulPower(IntToStr(s[i]),IntToStr(e[i]));
    //y1:= ulSub(y1, ulMPL(IntToStr(n), ulDiv(y1,IntToStr(n),0)));
    Form1.create.Lines.Add('s['+IntToStr(i)+']^e['+IntToStr(i)+'] = ' + y1);
    y:=ulMPL(y,y1);
    //y:= ulSub(y, ulMPL(IntToStr(n), ulDiv(y,IntToStr(n),0)));
    end;
    Form1.create.Text:= Form1.create.Text + 'y = ' + IntToStr(r) +' * '+y + ' mod ' +
    IntToStr(n);
    y:= ulMPL(IntToStr(r),y);
    y:= ulSub(y, ulMPL(IntToStr(n), ulDiv(y,IntToStr(n),0)));
    Form1.create.Text:= Form1.create.Text + ' = ' +y +#13#10;
    //y:= ulSub(y, ulMPL(IntToStr(n), ulDiv(y,IntToStr(n),0)));
    Form1.create.Lines.Add('');
    Form1.create.Lines.Add('Полученная ЭЦП: ( '+ estr +', ' + y +' )' + #13#10);
    SendMes('$'+ estr+'$'+y+'$'+IntToStr(n)+'$');
     Form1.create.Lines.Add('');
    Form1.create.Lines.Add('---------------Формирование ЭЦП завершено:---------------' +#13#10);
    Form1.create.Lines.Add('Время формирования ЭЦП: ' + FormatDateTime('ss,zzz', Now-timer) + 'сек');
   ShowMessage('Время формирования ЭЦП: ' + FormatDateTime('ss,zzz', Now-timer) + 'сек');

  end;

  procedure FSDecrypt(m:String);
  var str, chislo, key, z, z1, estr, y, h:string; i,j:integer;
  e: array [0..31] of int64;
  begin
  str:=Form1.box.Text;
 // Form1.dec.Lines.Add(str);
  key:= Form1.sPanel1.Caption;
  Form1.dec.Lines.Add(key + #13#10);
  Form1.dec.Lines.Add('---------------Начнем проверку ЭЦП:---------------' +#13#10);
  timer:=Now;
  j:=2;  chislo:='';
   while (str[j]<>'$') do begin
   chislo:=chislo+str[j]; inc(j);
   end;
   inc(j);
   estr:=chislo;     chislo:='';
   while (str[j]<>'$') do begin
   chislo:=chislo+str[j]; inc(j);
   end;
   inc(j);
   y:=chislo;  chislo:='';
   while (str[j]<>'$') do begin
   chislo:=chislo+str[j]; inc(j);
   end;
   inc(j);
   n:=StrToInt64(chislo);  chislo:='';
   Form1.dec.Lines.Add('Полученная ЭЦП сервера:');
  j:=1; i:=0;
 while(key[j]<>'(') do inc(j);
 inc(j);
 while (j<Length(key)) do begin
 chislo:='';
  while (key[j]<>',') do begin
  chislo:=chislo+key[j];
  inc(j);
  if key[j]=')' then break;
  end;
  v[i]:= StrToInt64(chislo);
  j:=j+2; inc(i);
  end;
  for i:=0 to 31 do begin
    //e[i]:=ord(m[i+1])*x mod 33;
    e[i]:=ord(estr[i+1]) mod 33;
    Form1.dec.Lines.Add('e['+IntToStr(i)+'] =' + IntToStr(e[i]));
   end;
     z:='1';
     for i:=0 to 31 do begin
    z1:= ulPower(IntToStr(v[i]),IntToStr(e[i]));
    //z1:= ulSub(z1, ulMPL(IntToStr(n), ulDiv(z1,IntToStr(n),0)));
    Form1.dec.Lines.Add('v['+IntToStr(i)+']^e['+IntToStr(i)+'] = ' + z1);
    z:=ulMPL(z,z1);
    //z:= ulSub(z, ulMPL(IntToStr(n), ulDiv(z,IntToStr(n),0)));
    end;
    //z:= ulSub(z, ulMPL(IntToStr(n), ulDiv(z,IntToStr(n),0)));
    Form1.dec.Text:= Form1.dec.Text + 'z = ' + y +'^2 * '+z;
    z:= ulMPL(ulPower(y,'2'),z);
    z:= ulSub(z, ulMPL(IntToStr(n), ulDiv(z,IntToStr(n),0)));
    Form1.dec.Text:= Form1.dec.Text + ' = ' +z +#13#10;
    h:=md5(m+z);
    Form1.dec.Lines.Add('Проверка, что e = H(m,z):' +#13#10 + 'H(m,z) = ' +h);
    if estr=h then begin
     Form1.dec.Lines.Add(estr + ' = ' + h + #13#10 + 'Проверка пройдена!');
     Form1.yes.Visible:=true;
     Form1.no.Visible:=false;
     end;
    if estr<>h then  begin
     Form1.dec.Lines.Add(estr + ' <> ' + h + #13#10 + 'Проверка не пройдена!');
     Form1.no.Visible:=true;
     Form1.yes.Visible:=false;
     end;
     Form1.dec.Lines.Add('');
    Form1.dec.Lines.Add('---------------Проверка ЭЦП завершена:---------------' +#13#10);
    Form1.create.Lines.Add('Время проверки ЭЦП: ' + FormatDateTime('ss,zzz', Now-timer) + 'сек');
   ShowMessage('Время проверки ЭЦП: ' + FormatDateTime('ss,zzz', Now-timer) + 'сек');
  end;

  procedure OpenFSKey(key:string; l: integer);
var chislo:String; i,j:integer;
begin
 j:=2; i:=0;
 while (j<Length(key)) do begin
 chislo:='';
  while (key[j]<>',') do begin
  chislo:=chislo+key[j];
  inc(j);
  if key[j]=')' then break;
  end;
  if l=0 then
   if not TryStrToInt64(chislo,v[i]) then begin
 ShowMessage('Неккоректный ключ'); exit;end; //v[i]:= StrToInt64(chislo);
  if l=1 then  if not TryStrToInt64(chislo,s[i]) then begin
 ShowMessage('Неккоректный ключ'); exit;end; //s[i]:= StrToInt64(chislo);
  j:=j+2; inc(i);
  end;
end;

function SaveFSKey(l:integer):string;
   begin
   if l=0 then Result:=Vstr;
   if l=1 then Result:=Sstr;
   end;

end.
 