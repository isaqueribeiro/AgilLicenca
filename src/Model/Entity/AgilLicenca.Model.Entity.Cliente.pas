unit AgilLicenca.Model.Entity.Cliente;

interface

uses
  System.SysUtils,
  SimpleAttributes;

type
  [Tabela('TAB_CLIENTES')]
  TCliente = class
    private
      FCnpj: String;
      FFantasia: String;
      FId: Int64;
      FRazao: String;
      FAtivo: Smallint;

      procedure SetCnpj(const Value: String);
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
      [Campo('nr_cnpj'), NotNull]
      property Cnpj : String read FCnpj write SetCnpj;
      [Campo('sn_ativo'), NotNull]
      property Ativo : Smallint read FAtivo write SetAtivo;
  end;

implementation

{ TCliente }

procedure TCliente.SetAtivo(const Value: Smallint);
begin
  if (Value >= 0) and (Value <= 1) then
    FAtivo := Value
  else
    FAtivo := 0;
end;

procedure TCliente.SetCnpj(const Value: String);
begin
  FCnpj := Value;
end;

procedure TCliente.SetFantasia(const Value: String);
begin
  FFantasia := Value.Trim.ToUpper;
end;

procedure TCliente.SetId(const Value: Int64);
begin
  FId := Value;
end;

procedure TCliente.SetRazao(const Value: String);
begin
  FRazao := Value.Trim.ToUpper;
end;

end.
