unit UMathServices;
{����� Vit}

interface

type
  TProgress = procedure(Done: real);

  {���������� ���������� �������}
function ulFact(First: string): string;
function ulSum(First, Second: string): string;
function ulSub(First, Second: string): string;
function ulMPL(First, Second: string): string;
function ulPower(First, Second: string): string;
function UlDiv(First, Second: string; Precision: integer): string;
  {Precision - �� �������� �������� � ���������� ������ �����������
  ����� ������� ����� ��� ������� �������. ��� ����� ��� ������������ �
  ������� � �������� � ����� ������ �����������}

{Call back function for long operations}
var
  OnProgress: TProgress;

implementation

uses SysUtils;

type
  TMathArray = array of integer;

type
  TNumber = record
    int, frac: TMathArray;
    sign: boolean;
  end;

var
  n1, n2: TNumber;

procedure Str2Number(s: string; var n: TNumber);
var
  i, j, l: integer;
begin
  if s = '' then
  begin
    setlength(n.int, 0);
    setlength(n.frac, 0);
    exit;
  end;
  l := length(s);
  if s[1] = '-' then
  begin
    s := copy(s, 2, l);
    l := l - 1;
    n.sign := false;
  end
  else
    n.sign := true;
  j := pos('.', s);
  if j > 0 then
  begin
    setlength(n.int, j - 1);
    for i := 1 to j - 1 do
      n.int[i - 1] := strtoint(s[j - i]);
    setlength(n.frac, l - j);
    for i := 1 to l - j do
      n.frac[i - 1] := strtoint(s[l - i + 1]);
  end
  else
  begin
    setlength(n.int, l);
    for i := 1 to l do
      n.int[i - 1] := strtoint(s[l - i + 1]);
    setlength(n.frac, 0);
  end;
end;

function Num2Array(var n: TNumber; var a: TMathArray): integer;
var
  i: integer;
begin
  result := length(n.frac);
  setlength(a, length(n.int) + result);
  for i := 0 to length(a) - 1 do
    if i < result then
      a[i] := n.frac[i]
    else
      a[i] := n.int[i - result];
end;

procedure MultiplyArray(var a1, a2, a: TMathArray);
var
  i, j: integer;
  b: boolean;
begin
  {checking for zero, 1}
  for i := length(a2) - 1 downto 0 do
  begin
    for j := length(a1) - 1 downto 0 do
    begin
      a[j + i] := a[j + i] + (a2[i] * a1[j]);
    end;
  end;
  repeat
    b := true;
    for i := 0 to length(a) - 1 do
      if a[i] > 9 then
      begin
        b := false;
        try
          a[i + 1] := a[i + 1] + 1;
        except
          setlength(a, length(a) + 1);
          a[i + 1] := a[i + 1] + 1;
        end;
        a[i] := a[i] - 10;
      end;
  until b;
end;

procedure Array2Num(var n: TNumber; var a: TMathArray; frac: integer; sign:
  boolean);
var
  i: integer;
begin
  setlength(n.frac, frac);
  setlength(n.int, length(a) - frac);
  for i := 0 to length(a) - 1 do
  begin
    if i < frac then
      n.frac[i] := a[i]
    else
      n.int[i - frac] := a[i];
  end;
  n.sign := sign;
end;

function Number2Str(var n: TNumber): string;
var
  i: integer;
  s: string;
begin
  result := '';
  for i := 0 to high(n.int) do
    result := inttostr(n.int[i]) + result;
  if length(n.frac) <> 0 then
  begin
    for i := 0 to high(n.frac) do
      s := inttostr(n.frac[i]) + s;
    result := result + '.' + s;
  end;
  while (length(result) > 1) and (result[1] = '0') do
    delete(result, 1, 1);
  if pos('.', result) > 0 then
    while (length(result) > 1) and (result[length(result)] = '0') do
      delete(result, length(result), 1);
  if not n.sign then
    result := '-' + result;
  setlength(n.int, 0);
  setlength(n.frac, 0);
end;

procedure DisposeNumber(var n: TNumber);
begin
  setlength(n.int, 0);
  setlength(n.frac, 0);
end;

function ulFact(First: string): string;
var
  n1, n2: TNumber;
  i: integer;
  a, a1, a2: TMathArray;
  max: integer;
begin
  Str2Number('1', n1);
  Str2Number('1', n2);
  Num2Array(n1, a1);
  Num2Array(n2, a2);
  max := strtoint(First);
  for i := 1 to strtoint(First) do
  begin
    if Assigned(OnProgress) then
      OnProgress((i / max) * 100);
    setlength(a, length(a1) + length(a2) + 1);
    MultiplyArray(a1, a2, a);
    setlength(a1, 0);
    setlength(a2, 0);
    a1 := a;
    Str2Number(inttostr(i), n2);
    Num2Array(n2, a2);
  end;
  Array2Num(n1, a1, 0, true);
  result := Number2Str(n1);
  DisposeNumber(n1);
end;

function ulPower(First, Second: string): string;
var
  i, j, c: integer;
  a, a1, a2: TMathArray;
var
  n1: TNumber;
  max: integer;
begin
  j := strtoint(Second);
  if j = 0 then
  begin
    result := '1';
    exit;
  end
  else if j = 1 then
  begin
    result := First;
    exit;
  end;

  max := j - 1;
  Str2Number(First, n1);
  c := Num2Array(n1, a1);
  setlength(a, 0);
  setlength(a2, 0);
  a2 := a1;
  for i := 1 to j - 1 do
  begin
    if Assigned(OnProgress) then
      OnProgress((i / max) * 100);
    setlength(a, 0);
    setlength(a, length(a1) + length(a2) + 1);
    MultiplyArray(a1, a2, a);
    setlength(a2, 0);
    a2 := a;
  end;
  setlength(a1, 0);
  setlength(a2, 0);
  c := c * j;
  if n1.sign then
    Array2Num(n1, a, c, true)
  else if odd(j) then
    Array2Num(n1, a, c, false)
  else
    Array2Num(n1, a, c, true);
  setlength(a, 0);
  result := Number2Str(n1);
  DisposeNumber(n1);
end;

procedure MultiplyNumbers(var n1, n2: TNumber);
var
  i: integer;
  a, a1, a2: TMathArray;
begin
  i := Num2Array(n1, a1) + Num2Array(n2, a2);
  setlength(a, length(a1) + length(a2) + 1);
  MultiplyArray(a1, a2, a);
  setlength(a1, 0);
  setlength(a2, 0);
  Array2Num(n1, a, i, n1.sign = n2.sign);
  DisposeNumber(n2);
  setlength(a, 0);
end;

function ulMPL(First, Second: string): string;
var
  n1, n2: TNumber;
begin
  Str2Number(First, n1);
  Str2Number(Second, n2);
  MultiplyNumbers(n1, n2);
  result := Number2Str(n1);
  DisposeNumber(n1);
end;

procedure AlignNumbers(var n1, n2: TNumber);
var
  i1, i2, i: integer;
begin
  i1 := length(n1.int);
  i2 := length(n2.int);
  if i1 > i2 then
    setlength(n2.int, i1);
  if i2 > i1 then
    setlength(n1.int, i2);

  i1 := length(n1.frac);
  i2 := length(n2.frac);

  if i1 > i2 then
  begin
    setlength(n2.frac, i1);
    for i := i1 - 1 downto 0 do
    begin
      if i - (i1 - i2) > 0 then
        n2.frac[i] := n2.frac[i - (i1 - i2)]
      else
        n2.frac[i] := 0;
    end;
  end;
  if i2 > i1 then
  begin
    setlength(n1.frac, i2);
    for i := i2 - 1 downto 0 do
    begin
      if i - (i2 - i1) > 0 then
        n1.frac[i] := n1.frac[i - (i2 - i1)]
      else
        n1.frac[i] := 0;
    end;
  end;
end;

function SubInteger(a1, a2: TMathArray): integer;
var
  i: integer;
  b: boolean;
begin
  result := 0;
  if length(a1) = 0 then
    exit;
  for i := 0 to length(a1) - 1 do
    a1[i] := a1[i] - a2[i];
  repeat
    b := true;
    for i := 0 to length(a1) - 1 do
      if a1[i] < 0 then
      begin
        b := false;
        if i = length(a1) - 1 then
        begin
          result := -1;
          a1[i] := a1[i] + 10;
          b := true;
        end
        else
        begin
          a1[i + 1] := a1[i + 1] - 1;
          a1[i] := a1[i] + 10;
        end;
      end;
  until b;
end;

procedure AssignNumber(out n1: TNumber; const n2: TNumber);
var
  i: integer;
begin
  Setlength(n1.int, length(n2.int));
  for i := 0 to length(n2.int) - 1 do
    n1.int[i] := n2.int[i];
  Setlength(n1.frac, length(n2.frac));
  for i := 0 to length(n2.frac) - 1 do
    n1.frac[i] := n2.frac[i];
  n1.sign := n2.sign;
end;

procedure SubNumber(var n1, n2: TNumber);
var
  i: integer;
  n: TNumber;
begin
  AlignNumbers(n1, n2);
  i := subInteger(n1.frac, n2.frac);
  n1.int[0] := n1.int[0] + i;
  DisposeNumber(n);
  AssignNumber(n, n1);
  i := subInteger(n1.int, n2.int);
  if i < 0 then
  begin
    subInteger(n2.int, n.int);
    AssignNumber(n1, n2);
  end
  else
  begin
    DisposeNumber(n2);
  end;
end;

function SumInteger(a1, a2: TMathArray): integer;
var
  i: integer;
  b: boolean;
begin
  result := 0;
  if length(a1) = 0 then
    exit;
  for i := 0 to length(a1) - 1 do
    a1[i] := a1[i] + a2[i];
  repeat
    b := true;
    for i := 0 to length(a1) - 1 do
      if a1[i] > 9 then
      begin
        b := false;
        if i = length(a1) - 1 then
        begin
          result := 1;
          a1[i] := a1[i] - 10;
          b := true;
        end
        else
        begin
          a1[i + 1] := a1[i + 1] + 1;
          a1[i] := a1[i] - 10;
        end;
      end;
  until b;
end;

procedure SumNumber(var n1, n2: TNumber);
var
  i: integer;
begin
  AlignNumbers(n1, n2);
  i := sumInteger(n1.frac, n2.frac);
  n1.int[0] := n1.int[0] + i;
  i := sumInteger(n1.int, n2.int);
  if i > 0 then
  begin
    setlength(n1.int, length(n1.int) + 1);
    n1.int[length(n1.int) - 1] := i;
  end;
  DisposeNumber(n2);
end;

procedure SumNumbers(var n1, n2: TNumber);
begin
  if n1.sign and n2.sign then
  begin
    SumNumber(n1, n2);
    n1.sign := true;
  end
  else if (not n1.sign) and (not n2.sign) then
  begin
    SumNumber(n1, n2);
    n1.sign := False;
  end
  else if (not n1.sign) and n2.sign then
  begin
    SubNumber(n2, n1);
    AssignNumber(n1, n2);
  end
  else
  begin
    SubNumber(n1, n2);
  end;
end;

function ulSum(First, Second: string): string;
begin
  Str2Number(First, n1);
  Str2Number(Second, n2);
  SumNumbers(n1, n2);
  result := Number2Str(n1);
  DisposeNumber(n1);
end;

function ulSub(First, Second: string): string;
begin
  Str2Number(First, n1);
  Str2Number(Second, n2);
  n2.sign := not n2.sign;
  SumNumbers(n1, n2);
  result := Number2Str(n1);
  DisposeNumber(n1);
end;

function DupChr(const X: Char; Count: Integer): AnsiString;
begin
  if Count > 0 then
  begin
    SetLength(Result, Count);
    if Length(Result) = Count then
      FillChar(Result[1], Count, X);
  end;
end;

function StrCmp(X, Y: AnsiString): Integer;
var
  I, J: Integer;
begin
  I := Length(X);
  J := Length(Y);
  if I = 0 then
  begin
    Result := J;
    Exit;
  end;
  if J = 0 then
  begin
    Result := I;
    Exit;
  end;
  if X[1] = '-' then
  begin
    if Y[1] = '-' then
    begin
      X := Copy(X, 2, I);
      Y := Copy(Y, 2, J);
    end
    else
    begin
      Result := -1;
      Exit;
    end;
  end
  else if Y[1] = '-' then
  begin
    Result := 1;
    Exit;
  end;
  Result := I - J;
  if Result = 0 then
    Result := CompareStr(X, Y);
end;

function StrDiv(X, Y: AnsiString): AnsiString;
var
  I, J: Integer;
  S, V: Boolean;
  T1, T2: AnsiString;
  R: string;
  max: integer;

begin
  Result := '0';
  R := '0';
  I := Length(X);
  J := Length(Y);
  S := False;
  V := False;
  if I = 0 then
    Exit;
  if (J = 0) or (Y[1] = '0') then
  begin
    Result := '';
    R := '';
    Exit;
  end;
  if X[1] = '-' then
  begin
    Dec(I);
    V := True;
    X := Copy(X, 2, I);
    if Y[1] = '-' then
    begin
      Dec(J);
      Y := Copy(Y, 2, J)
    end
    else
      S := True;
  end
  else if Y[1] = '-' then
  begin
    Dec(J);
    Y := Copy(Y, 2, J);
    S := True;
  end;
  Dec(I, J);
  if I < 0 then
  begin
    R := X;
    Exit;
  end;
  T2 := DupChr('0', I);
  T1 := Y + T2;
  T2 := '1' + T2;
  max := Length(T1);
  while Length(T1) >= J do
  begin
    while StrCmp(X, T1) >= 0 do
    begin
      X := UlSub(X, T1);
      Result := UlSum(Result, T2);
    end;
    SetLength(T1, Length(T1) - 1);
    SetLength(T2, Length(T2) - 1);
    if Assigned(OnProgress) then
      OnProgress(100 - (Length(T1) / max) * 100);
  end;
  R := X;
  if S then
    if Result[1] <> '0' then
      Result := '-' + Result;
  if V then
    if R[1] <> '0' then
      R := '-' + R;
end;

function Mul10(First: string; Second: integer): string;
var
  s: string;
  i, j: integer;
begin
  if pos('.', First) = 0 then
  begin
    s := '';
    for i := 0 to Second - 1 do
      s := s + '0';
    Result := First + s;
  end
  else
  begin
    s := '';
    j := length(First) - pos('.', First);
    if (second - j) > 0 then
      for i := 0 to Second - j - 1 do
        s := s + '0';
    First := First + s;
    j := pos('.', First);
    First := StringReplace(First, '.', '', []);
    insert('.', First, j + second);
    while (length(First) > 0) and (First[length(First)] = '0') do
      delete(First, length(First), 1);
    while (length(First) > 0) and (First[length(First)] = '.') do
      delete(First, length(First), 1);
    Result := First;
  end;
end;

function Div10(First: string; Second: integer): string;
var
  s: string;
  i: integer;
begin
  s := '';
  for i := 0 to Second do
    s := s + '0';
  s := s + First;
  Insert('.', s, length(s) - Second + 1);
  while (length(s) > 0) and (s[1] = '0') do
    delete(s, 1, 1);
  if pos('.', s) > 0 then
    while (length(s) > 0) and (s[length(s)] = '0') do
      delete(s, length(s), 1);
  if (length(s) > 0) and (s[length(s)] = '.') then
    delete(s, length(s), 1);
  Result := s;
end;

function UlDiv(First, Second: string; Precision: integer): string;
begin
  First := Mul10(First, Precision);
  result := Div10(StrDiv(First, Second), Precision);
end;

end.


 