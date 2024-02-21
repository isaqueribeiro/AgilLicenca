unit AgilLicenca.Model.Entity.Cliente;

interface

uses
  System.SysUtils,
  SimpleAttributes;

type
  [Tabela('TAB_CLIENTES')]
  TCliente = class
    private
      FCpfCnpj: String;
      FFantasia: String;
      FId: Int64;
      FRazao: String;
      FAtivo: Smallint;

      procedure SetCpfCnpj(const Value: String);
      procedure SetFantasia(const Value: String);
      procedure SetId(const Value: Int64);
      procedure SetRazao(const Value: String);
      procedure SetAtivo(const Value: Smallint);
    public
      [Campo('id_cliente'), Pk, AutoInc]
      property Id : Int64 read FId write SetId;
      [Campo('nm_razao'), NotNull]
      property Razao : String read FRazao write SetRazao;
      [Campo('nm_fantasia')]
      property Fantasia : String read FFantasia write SetFantasia;
      [Campo('nr_cpfcnpj'), NotNull]
      property CpfCnpj : String read FCpfCnpj write SetCpfCnpj;
      [Campo('sn_ativo'), NotNull]
      property Ativo : Smallint read FAtivo write SetAtivo;
  end;

implementation

uses
  AgilLicenca.Classe.ServiceUtils,
  AgilLicenca.Classe.ServiceFormat,
  AgilLicenca.Classe.ServiceValidate;

{ TCliente }

procedure TCliente.SetAtivo(const Value: Smallint);
begin
  if (Value >= 0) and (Value <= 1) then
    FAtivo := Value
  else
    FAtivo := 0;
end;

procedure TCliente.SetCpfCnpj(const Value: String);
begin
  if TServiceValidate.IsCpf(Value) then
    FCpfCnpj := TServiceFormat.FormatCpf(Value)
  else
  if TServiceValidate.IsCnpj(Value) then
    FCpfCnpj := TServiceFormat.FormatCnpj(Value)
  else
    FCpfCnpj := TServiceUtils.OnlyNumbers(Value);
end;

procedure TCliente.SetFantasia(const Value: String);
begin
  FFantasia := TServiceUtils.SanitizeString(Value.Trim.ToUpper, false);
end;

procedure TCliente.SetId(const Value: Int64);
begin
  FId := Value;
end;

procedure TCliente.SetRazao(const Value: String);
begin
  FRazao := TServiceUtils.SanitizeString(Value.Trim.ToUpper, false);
end;

end.
