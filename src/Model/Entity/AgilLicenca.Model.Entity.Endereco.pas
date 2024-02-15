unit AgilLicenca.Model.Entity.Endereco;

interface

uses
  System.SysUtils,
  System.Math,
  SimpleAttributes;

type
  [Tabela('TAB_CLIENTES_ENDERECOS')]
  TEnderecoCliente = class
    private
      FLogradouro: String;
      FBairro: String;
      FAtivo: Smallint;
      FUF: String;
      FCep: String;
      FId: Int64;
      FNumero: String;
      FComplemento: String;
      FCidade: Int64;
      FCliente: Int64;
      FTipo: Smallint;
      procedure SetAtivo(const Value: Smallint);
      procedure SetBairro(const Value: String);
      procedure SetCep(const Value: String);
      procedure SetCidade(const Value: Int64);
      procedure SetComplemento(const Value: String);
      procedure SetId(const Value: Int64);
      procedure SetLogradouro(const Value: String);
      procedure SetNumero(const Value: String);
      procedure SetUF(const Value: String);
      procedure SetCliente(const Value: Int64);
      procedure SetTipo(const Value: Smallint);
    public
      [Campo('id_endereco'), Pk, AutoInc]
      property Id : Int64 read FId write SetId;
      [Campo('id_cliente'), Fk, NotNull]
      property Cliente : Int64 read FCliente write SetCliente;
      [Campo('tp_endereco'), NotNull]
      property Tipo : Smallint read FTipo write SetTipo;
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


{ TEnderecoCliente }

procedure TEnderecoCliente.SetAtivo(const Value: Smallint);
begin
  FAtivo := IfThen(Value = 1, 1, 0);
end;

procedure TEnderecoCliente.SetBairro(const Value: String);
begin
  FBairro := Value.Trim;
end;

procedure TEnderecoCliente.SetCep(const Value: String);
begin
  FCep := Value;
end;

procedure TEnderecoCliente.SetCidade(const Value: Int64);
begin
  FCidade := Value;
end;

procedure TEnderecoCliente.SetCliente(const Value: Int64);
begin
  FCliente := Value;
end;

procedure TEnderecoCliente.SetComplemento(const Value: String);
begin
  FComplemento := Value.Trim;
end;

procedure TEnderecoCliente.SetId(const Value: Int64);
begin
  FId := Value;
end;

procedure TEnderecoCliente.SetLogradouro(const Value: String);
begin
  FLogradouro := Value.Trim;
end;

procedure TEnderecoCliente.SetNumero(const Value: String);
begin
  FNumero := Value.Trim;
end;

procedure TEnderecoCliente.SetTipo(const Value: Smallint);
begin
  FTipo := Value;
end;

procedure TEnderecoCliente.SetUF(const Value: String);
begin
  FUF := Copy(Value.Trim.ToUpper, 1, 2);
end;

end.
