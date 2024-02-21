unit AgilLicenca.Classe.ServiceUtils;

interface

uses
  System.SysUtils,
  System.StrUtils;

type
  TServiceUtils = class
    class function NewGuid(const Adjusted : Boolean = True) : String;
    class function OnlyNumbers(Value : String) : String;
    class function RemoveAccents(Value : String) : String;
    class function RemoveSpecialCharacter(Value : Char) : Char;
    class function RemoveAllSpecialCharacters(Value : String) : String;
    class function SanitizeString(Value : String; const RemoveAccents : Boolean = False) : String;
    class function StringToCurrency(Value : String; const DecimalPlace : Word = 2) : Currency;
  end;

implementation

{ TServiceUtils }

class function TServiceUtils.NewGuid(const Adjusted: Boolean): String;
begin
  Result := TGUID.NewGuid.ToString;
  if Adjusted then
    Result := Result.Replace('{', '').Replace('}', '');
end;

class function TServiceUtils.OnlyNumbers(Value: String): String;
var
  I : Byte;
  Valor : String;
begin
  Valor := Value.Trim;

  for I := 1 to Length(Valor) do
    if not (Valor[I] in ['0'..'9']) then
      Delete(Valor, I, 1);

  Result := Valor;
end;

class function TServiceUtils.RemoveAccents(Value: String): String;
var
  x : Integer;
const
  COM_ACENTO = 'ñàâêôûãõáéíóúçüÑÀÂÊÔÛÃÕÁÉÍÓÚÇÜªº';
  SEM_ACENTO = 'naaeouaoaeioucuNAAEOUAOAEIOUCUao';
begin
  for x := 1 to Value.Length do
    if (Pos(Value[x], COM_ACENTO) <> 0) then
      Value[x] := SEM_ACENTO[Pos(Value[x], COM_ACENTO)];

  Result := Value;
end;

class function TServiceUtils.RemoveAllSpecialCharacters(Value: String): String;
var
  I : Integer;
begin
  Result := Value;
  for I := 1 to Result.Length do
    Result[I] := TServiceUtils.RemoveSpecialCharacter(Result[I]);
end;

class function TServiceUtils.RemoveSpecialCharacter(Value: Char): Char;
const
  BadMaiSChar = ['"', '!', '@', '#', '$', '%', '¨', '&', '*', '(', ')', '-', '+', '=',
                 '|', '\', '<', ',', '>', '.', ':', ';', '?', '/', '´', '`', '{', '[',
                 '^', '^', '}', ']', '§'];
  BadMaiAChar = ['Á', 'À', 'Ä', 'Ã', 'Â'];
  BadMinAChar = ['á', 'à', 'ä', 'ã', 'â'];
  BadMaiEChar = ['É', 'È', 'Ë', 'Ê'];
  BadMinEChar = ['é', 'è', 'ë', 'ê'];
  BadMaiIChar = ['Í', 'Ì', 'Ï', 'Î'];
  BadMinIChar = ['í', 'ì', 'ï', 'î'];
  BadMaiOChar = ['Ó', 'Ò', 'Ö', 'Õ', 'Ô'];
  BadMinOChar = ['ó', 'ò', 'ö', 'õ', 'ô'];
  BadMaiUChar = ['Ú', 'Ù', 'Ü', 'Û'];
  BadMinUChar = ['ú', 'ù', 'ü', 'û'];
  BadMaiCChar = ['Ç'];
  BadMinCChar = ['ç'];
  BadNumOChar = ['º'];
  BadNumAChar = ['ª'];
  BadMaiNChar = ['Ñ'];
  BadMinNChar = ['ñ'];
  BadChar = ['´', '"', '`', '~', '^','¨'];
var
  U : Char;
begin
  U := Value;
  if (U in BadMaiSChar) then U := ' ';
  if (U in BadMaiAChar) then U := 'A';
  if (U in BadMinAChar) then U := 'a';
  if (U in BadMaiEChar) then U := 'E';
  if (U in BadMinEChar) then U := 'e';
  if (U in BadMaiIChar) then U := 'I';
  if (U in BadMinIChar) then U := 'i';
  if (U in BadMaiOChar) then U := 'O';
  if (U in BadMinOChar) then U := 'o';
  if (U in BadMaiUChar) then U := 'U';
  if (U in BadMinUChar) then U := 'u';
  if (U in BadMaiCChar) then U := 'C';
  if (U in BadMinCChar) then U := 'c';
  if (U in BadMaiNChar) then U := 'N';
  if (U in BadMinNChar) then U := 'n';
  if (U in BadChar) then U := #0;
  Result := U;
end;

class function TServiceUtils.SanitizeString(Value: String; const RemoveAccents : Boolean): String;
begin
  Result := Value.Trim;
  if (Value <> StringOfChar(#32, Value.Length)) then
  begin
    if RemoveAccents then
      Result := TServiceUtils.RemoveAccents(Value);

    Result := StringReplace(Result, '.', '',      [rfReplaceAll]);
    Result := StringReplace(Result, Chr(39), ' ', [rfReplaceAll]);  // Apostrofo
    Result := StringReplace(Result, '-', ' ',     [rfReplaceAll]);  // Hifén
    Result := StringReplace(Result, '  ', ' ',    [rfReplaceAll]);  // Espaco duplo
  end;
end;

class function TServiceUtils.StringToCurrency(Value: String; const DecimalPlace : Word): Currency;
begin
  if (DecimalPlace = 3) then
    Result := StrToCurrDef(Value.Trim.Replace('.', '').Replace(',', ''), 0) / 1000.0
  else
    Result := StrToCurrDef(Value.Trim.Replace('.', '').Replace(',', ''), 0) / 100.0;
end;

end.
