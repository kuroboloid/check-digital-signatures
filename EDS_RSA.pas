unit EDS_RSA;

interface
uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Math;
  procedure KeyFormirovanieRSA() ;
  procedure RSAEncrypt();
  function RSADecrypt():string;
  function SaveRSAKey(l:integer):string;
  procedure OpenRSAKey(key:string; l: integer);
  var
  p,q,n,d,e:int64;
  Timer:TDateTime=0;
  implementation

uses Unit1, BaseOperationLib, InternetLib, UMathServices;

procedure KeyFormirovanieRSA();
var  elr:int64;
begin
if not TryStrToInt64(Form1.peditrsa.Text, p) then begin
ShowMessage('Значение p должно быть большим целым числом!');  exit; end;
if not TryStrToInt64(Form1.qEdit.Text, q) then begin
ShowMessage('Значение q должно быть большим целым числом!');  exit; end;

 if not CanonDec(p) then begin
 ShowMessage('Число p - не простое!');  exit;
 end;
 if not CanonDec(q) then begin
 ShowMessage('Число q - не простое!');     exit;
 end;

 if p<1000 then begin
 ShowMessage('Число p слишком мало!');  exit;
 end;
 if q<1000 then begin
 ShowMessage('Число q слишком мало!');     exit;
 end;

  Form1.proc.Caption:= Form1.proc.Caption + '-------------Начнем процедуру формирования ключей:-------------' + #13#10 + #13#10;
 n:=p*q; Form1.proc.Caption:= Form1.proc.Caption + 'n = p*q = ' + IntToStr(p) +'*' + IntToStr(q) + ' = '+ IntToStr(n) +  #13#10;
 elr:=(p-1)*(q-1); Form1.proc.Caption:= Form1.proc.Caption + 'Функция Эйлера: f(n) = (p-1)*(q-1) = ' + IntToStr (elr) +  #13#10;
 randomize;
 e:=random(n-1);
 while (GetNOD(elr,e)<>1) or (e<0) do e:=random(n-1);
 //e:=3;
 Form1.proc.Caption:= Form1.proc.Caption + 'Случайная компонента: e = ' + IntToStr (e) +  #13#10;
 //d:= stdown(e,elr-1,elr,1);
 d:=linsr(e,1,elr);
 Form1.proc.Caption:= Form1.proc.Caption + 'Решение уравнения: e*d = 1 mod f(n) = ' +
 IntToStr(e)+'*d = 1 mod ' + IntToStr(elr) + #13#10+ 'd = ' +IntTostr(d) +  #13#10+  #13#10;
 Form1.sPanel1.Caption:='Открытый ключ: {'+IntToStr(d)+','+IntToStr(n)+'}' + #13#10 +
 'Закрытый ключ: {'+IntToStr(e)+','+IntToStr(n)+'}';
  Form1.proc.Caption:= Form1.proc.Caption + 'Открытый ключ: {d,n} =  {'+IntToStr(d)+','+IntToStr(n)+'}' + #13#10 +
 'Закрытый ключ: {e,n} = {'+IntToStr(e)+','+IntToStr(n)+'}'+#13#10;
 if Form1.sCheckBox1.Checked=true then
 SendMes('*Открытый ключ: {' + IntToStr(d)+','+IntToStr(n)+'}')
 else Form1.box.Text:= '*Открытый ключ: {' + IntToStr(d)+','+IntToStr(n)+'}';
 Form1.proc.Caption:= Form1.proc.Caption + '-------------Процедура формирования ключей завершена:-------------' + #13#10 + #13#10;
end;

procedure RSAEncrypt();
var shifr_text, str, buf, buf2:String; i,j,b:integer;
block: array of string;  M,n:int64;
begin
 shifr_text:='g'+ md5('> '+Form1.nikname.Text+'('+GetLocalIP+'): ' +Form1.sEdit2.Text);
 Form1.create.Text:= 'Хэш отправляемого сообщения: '+shifr_text + #13#10 + #13#10;
 str:=''; buf:=''; buf2:='';
  //Form1.sMemo1.Text:=Form1.sMemo1.Text +#13#10;
Form1.create.Lines.Add('---------------Начнем шифрование хэша сообщения:---------------');
timer:=Now;
for i:=1 to Length(shifr_text) do begin
if ord(shifr_text[i])<100 then
str:=str+'0'+IntToStr(ord(shifr_text[i]))
else str:=str+IntToStr(ord(shifr_text[i]));
end;
Form1.create.Lines.Add('Заменим каждый символ его ascii-кодом:');
Form1.create.Lines.Add(str);
n:=p*q;
SetLength(block, Length(str)+1);
j:=1; i:=1;
 while j<length(str)+1 do begin
 if (str[j]='0') and (j<>1) then begin
 b:= Length(block[i-1]);
 while block[i-1][b]='0' do begin
 Delete(block[i-1],b,1);
 b:=b-1;
 j:=j-1;
 end;
 Delete(block[i-1],b,1);
 b:=b-1;
 j:=j-1;
 block[i]:=str[j];
 end
 else  block[i]:=str[j];
 inc(j);
  while ((StrToInt64(block[i]+str[j]))<n) and (j<length(str)+1) do
   begin
     block[i]:=block[i]+str[j];
     inc(j);
   end;
  // Form1.proc.Caption:= Form1.proc.Caption + 'Блок ' + IntToStr(i)+ ' : '+ block[i] + #13#10;
   {M:= stdown(StrToInt64(block[i]),d,p*q);
   Form1.sMemo2.Text:=Form1.sMemo2.Text+IntToStr(M)+'-';
   Form1.proc.Caption:= Form1.proc.Caption + 'M[' + IntToStr(i)+ '] = '+ IntToStr(M) + #13#10;
   } inc(i);
   end;
   i:=1;
   while block[i]<>'' do begin
   buf2:=buf2+ block[i]+'-'; inc(i); end;
   Form1.create.Lines.Add('Разделим получившуюся последовательность на блоки, каждый из которых меньше n:');
   Form1.create.Lines.Add(buf2);
   Form1.create.Lines.Add('');
   Form1.create.Lines.Add('Преобразуем каждый блок сообщения:');
   i:=1; //Form1.proc.Caption:= Form1.proc.Caption + #13#10;
   while block[i]<>'' do begin
   M:= stdown(StrToInt64(block[i]),e,n,1);
   Form1.create.Lines.Add('M['+IntToStr(i)+'] = ' + block[i]+'^'+IntToStr(e)+' mod '+
   IntToStr(n)+' = '+IntToStr(M));
   //buf2:=buf2+ block[i]+'-';
   buf:= buf+IntToStr(M)+'-';
   //Form1.sMemo1.Text:=Form1.sMemo1.Text+IntToStr(M)+'-';
   //Form1.proc.Caption:= Form1.proc.Caption + 'M[' + IntToStr(i)+ '] = '+ IntToStr(M) + #13#10;
   inc(i);
   end;
   SendMes('$'+ buf);
   //Form1.sMemo1.Text:=Form1.sMemo1.Text+buf2+#13#10;
    //Form1.sMemo1.Text:=Form1.sMemo1.Text+buf+#13#10;
    Form1.create.Lines.Add('---------------Шифрование хэша сообщения завершено:---------------');
    Form1.create.Lines.Add('');
   Form1.create.Lines.Add('Полученная ЭЦП:');
   Form1.create.Lines.Add(buf);
   Form1.create.Lines.Add('');
   Form1.create.Lines.Add('Осуществлена передача ЭЦП.' +#13#10);
   Form1.box.Text:='$'+buf;
   Form1.create.Lines.Add('Время формирования ЭЦП: ' + FormatDateTime('ss,zzz', Now-timer) + 'сек');
   ShowMessage('Время формирования ЭЦП: ' + FormatDateTime('ss,zzz', Now-timer) + 'сек');
   //Form1.proc.Caption:= Form1.proc.Caption + '----------------------Процесс шифрования завершен----------------------';
end;

function RSADecrypt():string;
var shifr_text, str, hash0, hash, hash2, key, chislo:String;
i,j, l:integer;
block, sim:string;  M:int64;
begin

Form1.dec.Lines.Add('Полученная ЭЦП сообщения:');
 str:=Form1.box.Text;  hash:=''; hash0:=''; hash2:='';  l:=0;
 Form1.dec.Lines.Add(str);
 key:= Form1.sPanel1.Caption;
 Form1.dec.Lines.Add(key);
 chislo:=''; j:=1;
 while(key[j]<>'{') do inc(j);
 inc(j);
 while (key[j]<>',') do begin  chislo:=chislo+key[j]; inc(j); end;
 d:=StrToInt64(chislo);
 inc(j); chislo:='';
 while (key[j]<>'}') do begin  chislo:=chislo+key[j]; inc(j); end;
 n:=StrToInt64(chislo);
 Form1.dec.Lines.Add('');
 Form1.dec.Lines.Add('---------------Начнем расшифрование ЭЦП:---------------');
 timer:=Now;
  //Form1.sMemo3.Text:='';
 //Form1.proc.Caption:=  '----------------------Начнем расшифрование:----------------------' + #13#10 + #13#10;
for i:=1 to Length(str) do begin
//str:=str+IntToStr(ord(shifr_text[i]));
end;
j:=1; i:=1;
 while j<length(str) do begin
 block:=str[j];
 inc(j);
  while str[j]<>'-' do
   begin
     block:=block+str[j];
     inc(j);
   end;
   inc(j);
   //Form1.proc.Caption:= Form1.proc.Caption + 'Блок ' + IntToStr(i)+ ' : '+ block + #13#10;
   Form1.dec.Lines.Add('Преобразуем каждый блок ЭЦП:');
   M:= stdown(StrToInt64(block),d,n,1);
   Form1.dec.Lines.Add('С['+IntToStr(i)+'] = ' + block+'^'+IntToStr(d)+' mod '+
   IntToStr(n)+' = '+IntToStr(M));
   if (IntToStr(M)[1]='5') and (l=0) then hash0:=hash0+'0'+IntToStr(M)
   else    hash0:=hash0+IntToStr(M);
   inc(l);
   //Form1.sMemo3.Text:=Form1.sMemo3.Text+IntToStr(M);
   //Form1.proc.Caption:= Form1.proc.Caption + 'M[' + IntToStr(i)+ '] = '+ IntToStr(M) + #13#10+ #13#10;
   inc(i);
   end;
   i:=1;
   Form1.dec.Lines.Add('');
   Form1.dec.Lines.Add('Преобразованная ЭЦП:');
   Form1.dec.Lines.Add(hash0);
   Form1.dec.Lines.Add('');
   Form1.dec.Lines.Add('Переведем данную последовательность в символьный формат:') ;
    //Form1.sMemo1.Text:=Form1.sMemo1.Text+hash0+#13#10;
   while i<Length(hash0) do begin
    sim:='';
    for j:=i to i+2 do begin
    sim:= sim+hash0[j];
    end;
    hash:=hash+chr(StrToInt(sim));
    i:=i+3;
   end;
   Form1.dec.Lines.Add(hash);
   Form1.dec.Lines.Add('---------------Расшифрование ЭЦП завершено---------------');
   Form1.dec.Lines.Add('');
     Form1.create.Lines.Add('Время проверки ЭЦП: ' + FormatDateTime('ss,zzz', Now-timer) + 'сек');
   ShowMessage('Время проверки ЭЦП: ' + FormatDateTime('ss,zzz', Now-timer) + 'сек');
   //for i:=2 to Length(hash) do hash2:=hash2+hash[i];
   Result:=hash;
   //Form1.proc.Caption:= Form1.proc.Caption + '----------------------Процесс расшифрования завершен----------------------';
end;

procedure OpenRSAKey(key:string; l: integer);
var chislo:String; j:integer;
begin
 if l=0 then begin
  j:=2; chislo:='';
    while (key[j]<>',') do begin  chislo:=chislo+key[j]; inc(j); end;
 if not TryStrToInt64(chislo,d) then begin
 ShowMessage('Неккоректный ключ!'); exit;end;
 //d:=StrToInt64(chislo);
 inc(j); chislo:='';
 while (key[j]<>'}') do begin  chislo:=chislo+key[j]; inc(j); end;
  if not TryStrToInt64(chislo,n) then begin
 ShowMessage('Неккоректный ключ'); exit;end;
 //n:=StrToInt64(chislo);
   end;
   if l=1 then begin
   j:=2; chislo:='';
    while (key[j]<>',') do begin  chislo:=chislo+key[j]; inc(j); end;
 //e:=StrToInt64(chislo);
  if not TryStrToInt64(chislo,e) then begin
 ShowMessage('Неккоректный ключ'); exit;end;
 inc(j); chislo:='';
 while (key[j]<>'}') do begin  chislo:=chislo+key[j]; inc(j); end;
  if not TryStrToInt64(chislo,n) then begin
 ShowMessage('Неккоректный ключ'); exit;end;
 //n:=StrToInt64(chislo);
    end;
end;

function SaveRSAKey(l:integer):string;
   begin
   if l=0 then Result:='{'+IntToStr(d)+','+IntToStr(n)+'}';
   if l=1 then begin Result:='{'+IntToStr(e)+','+IntToStr(n)+'}';
   end;
   end;

end.
