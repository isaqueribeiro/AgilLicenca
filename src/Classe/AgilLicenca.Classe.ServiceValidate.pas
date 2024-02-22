unit AgilLicenca.Classe.ServiceValidate;

interface

uses
  System.SysUtils,
  System.RegularExpressions;

type
  TServiceValidate = class
    class function IsCnpj(Value : String) : Boolean;
    class function IsCpf(Value : String) : Boolean;
    class function IsEmail(Value : String): Boolean;
  end;

implementation

uses
  AgilLicenca.Classe.ServiceUtils;

{ TServiceValidate }

class function TServiceValidate.IsCnpj(Value: String): Boolean;
var
  Dig : array [1..14] of Byte;
  I, Resto: Byte;
  Dv1, Dv2: Byte;
  Total1, Total2: Integer;
  Valor: string;
begin
  Result := False;
  Valor  := TServiceUtils.OnlyNumbers(Value);

  if (Valor.Length = 14) then
  begin
    for I := 1 to 14 do
      try
        Dig[I] := StrToInt(Valor[I]);
      except
        Dig[i] := 0;
      end;

    Total1 := Dig[1]  * 5 + Dig[2]  * 4 + Dig[3]  * 3 +
              Dig[4]  * 2 + Dig[5]  * 9 + Dig[6]  * 8 +
              Dig[7]  * 7 + Dig[8]  * 6 + Dig[9]  * 5 +
              Dig[10] * 4 + Dig[11] * 3 + Dig[12] * 2 ;

    Resto := Total1 mod 11;

    if (Resto > 1) then
      Dv1 := 11 - Resto
    else
      Dv1 := 0;

    Total2 := Dig[1]  * 6 + Dig[2]  * 5 + Dig[3]  * 4 +
              Dig[4]  * 3 + Dig[5]  * 2 + Dig[6]  * 9 +
              Dig[7]  * 8 + Dig[8]  * 7 + Dig[9]  * 6 +
              Dig[10] * 5 + Dig[11] * 4 + Dig[12] * 3 + Dv1 * 2 ;

    Resto := Total2 mod 11;

    if (Resto > 1) then
      Dv2 := 11 - Resto
    else
      Dv2 := 0;

    Result := (Dv1 = Dig[13]) and (Dv2 = Dig[14]);
  end;
end;

class function TServiceValidate.IsCpf(Value: String): Boolean;
var
  I, Numero, Resto: Byte ;
  Dv1, Dv2: Byte ;
  Total, Soma: Integer ;
  Valor: string;
begin
  Result := False;
  Valor  := TServiceUtils.OnlyNumbers(Value);

  if (Valor.Length = 11) then
  begin
    Total := 0 ;
    Soma  := 0 ;

    for I := 1 to 9 do
    begin
      try
        Numero := StrToInt (Valor[I]);
      except
        Numero := 0;
      end;

      Total := Total + (Numero * (11 - I)) ;
      Soma  := Soma + Numero;
    end;

    Resto := Total mod 11;

    if (Resto > 1) then
      Dv1 := 11 - Resto
    else
      Dv1 := 0;

    Total := Total + Soma + 2 * Dv1;
    Resto := Total mod 11;

    if (Resto > 1) then
      Dv2 := 11 - Resto
    else
      Dv2 := 0;

    Result := (IntToStr (Dv1) = Valor[10]) and (IntToStr (Dv2) = Valor[11]);
  end;
end;

class function TServiceValidate.IsEmail(Value: String): Boolean;
var
  aExpressao : TRegEx;
begin
  Result := False;

  if not Result then
    Result := aExpressao.IsMatch(Value, '(^[^@]+@[^.]+.com$|^[^@]+@[^.]+.com.br$)');

  if not Result then
    Result := aExpressao.IsMatch(Value, '(^[^@]+@[^.]+.org$)');

  if not Result then
    Result := aExpressao.IsMatch(Value, '(^[^@]+@[^.]+.net$)');

  if not Result then
    Result := aExpressao.IsMatch(Value, '(^[^@]+@[^.]+.site$)');

  if not Result then
    Result := aExpressao.IsMatch(Value, '(^[^@]+@[^.]+.online$)');

  if not Result then
    Result := aExpressao.IsMatch(Value, '(^[^@]+@[^.]+.store$)');

  if not Result then
    Result := aExpressao.IsMatch(Value, '(^[^@]+@[^.]+.tech$)');

  if not Result then
    Result := aExpressao.IsMatch(Value, '(^[^@]+@[^.]+.edu$)');
end;

end.
