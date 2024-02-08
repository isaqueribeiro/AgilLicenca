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
      FLogradouro: String;
      FBairro: String;
      FUF: String;
      FCep: String;
      FNumero: String;
      FComplemento: String;
      FCidade: Int64;

      procedure SetCnpj(const Value: String);
      procedure SetFantasia(const Value: String);
      procedure SetId(const Value: Int64);
      procedure SetRazao(const Value: String);
      procedure SetAtivo(const Value: Smallint);
      procedure SetBairro(const Value: String);
      procedure SetCep(const Value: String);
      procedure SetCidade(const Value: Int64);
      procedure SetComplemento(const Value: String);
      procedure SetLogradouro(const Value: String);
      procedure SetNumero(const Value: String);
      procedure SetUF(const Value: String);
    public
      [Campo('id_cliente'), Pk, AutoInc]
      property Id : Int64 read FId write SetId;
      [Campo('nm_razao'), NotNull]
      property Razao : String read FRazao write SetRazao;
      [Campo('nm_fantasia')]
      property Fantasia : String read FFantasia write SetFantasia;
      [Campo('nr_cnpj'), NotNull]
      property Cnpj : String read FCnpj write SetCnpj;
      [Campo('ds_endereco')]
      property Logradouro : String read FLogradouro write SetLogradouro;
      [Campo('nr_endereco')]
      property Numero : String read FNumero write SetNumero;
      [Campo('ds_complemento')]
      property Complemento : String read FComplemento write SetComplemento;
      [Campo('nm_bairro')]
      property Bairro : String read FBairro write SetBairro;
      [Campo('nr_cep')]
      property Cep : String read FCep write SetCep;
      [Campo('cd_cidade'), NotNull]
      property Cidade : Int64 read FCidade write SetCidade;
      [Campo('cd_uf'), NotNull]
      property UF : String read FUF write SetUF;
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

procedure TCliente.SetBairro(const Value: String);
begin
  FBairro := Value;
end;

procedure TCliente.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TCliente.SetCidade(const Value: Int64);
begin
  FCidade := Value;
end;

procedure TCliente.SetCnpj(const Value: String);
begin
  FCnpj := Value;
end;

procedure TCliente.SetComplemento(const Value: String);
begin
  FComplemento := Value;
end;

procedure TCliente.SetFantasia(const Value: String);
begin
  FFantasia := Value.Trim.ToUpper;
end;

procedure TCliente.SetId(const Value: Int64);
begin
  FId := Value;
end;

procedure TCliente.SetLogradouro(const Value: String);
begin
  FLogradouro := Value;
end;

procedure TCliente.SetNumero(const Value: String);
begin
  FNumero := Value;
end;

procedure TCliente.SetRazao(const Value: String);
begin
  FRazao := Value.Trim.ToUpper;
end;

procedure TCliente.SetUF(const Value: String);
begin
  FUF := Value;
end;

end.
