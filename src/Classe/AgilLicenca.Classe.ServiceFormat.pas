unit AgilLicenca.Classe.ServiceFormat;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.MaskUtils;

type
  TServiceFormat = class
    class function FormatText(Mask, Value : String) : String;
    class function FormatCnpj(Value : String) : String;
    class function FormatCpf(Value : String) : String;
    class function FormatCep(Value : String) : String;
    class function FormatFone(Value : String) : String;
  end;

implementation

{ TServiceFormat }

uses
  AgilLicenca.Classe.ServiceUtils;

class function TServiceFormat.FormatCep(Value: String): String;
var
  aStr : String;
begin
  aStr   := TServiceUtils.OnlyNumbers(Value);
  Result := TServiceFormat.FormatText('99.999-999;0', aStr);
end;

class function TServiceFormat.FormatCnpj(Value: String): String;
var
  aStr  ,
  aMask : String;
begin
  aStr   := TServiceUtils.OnlyNumbers(Value);
  aMask  := IfThen(aStr.Length = 14, '99.999.999/9999-99;0', '999.999.999/9999-99;0');
  Result := TServiceFormat.FormatText(aMask, aStr);
end;

class function TServiceFormat.FormatCpf(Value: String): String;
var
  aStr : String;
begin
  aStr   := TServiceUtils.OnlyNumbers(Value);
  Result := TServiceFormat.FormatText('999.999.999-99;0', aStr);
end;

class function TServiceFormat.FormatFone(Value: String): String;
var
  aStr  ,
  aMask : String;
begin
  aStr   := TServiceUtils.OnlyNumbers(Value);
  aMask  := IfThen(aStr.Length = 10, '(99) 9999-9999;0', '(99) 99999-9999;0');
  Result := TServiceFormat.FormatText(aMask, aStr);
end;

class function TServiceFormat.FormatText(Mask, Value: String): String;
begin
  Result := IfThen((not Mask.Trim.IsEmpty) and (not Value.Trim.IsEmpty), FormatMaskText(Mask, Value), Value);
end;

end.
