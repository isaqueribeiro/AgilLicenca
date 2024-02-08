unit AgilLicenca.Model.DAO.Resource.Factory;

interface

uses
  System.SysUtils,
  AgilLicenca.Model.DAO.Resource.Interfaces,
  AgilLicenca.Model.DAO.Resource.Configuracao,
  AgilLicenca.Model.DAO.Resource.ConexaoFireDAC;

type
  TFactory = class(TInterfacedObject, IFactory)
    strict private
      class var _instance : IFactory;
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function GetInstance() : IFactory;

      function Configuracao : IConfiguracao;
      function Conexao(aConfiguracao : IConfiguracao) : IConexao;
  end;

implementation

{ TFactory }

function TFactory.Conexao(aConfiguracao : IConfiguracao) : IConexao;
begin
  Result := TConexaoFireDAC.New(aConfiguracao);
end;

function TFactory.Configuracao: IConfiguracao;
begin
  Result := TConfiguracao.New;
end;

constructor TFactory.Create;
begin
  ;
end;

destructor TFactory.Destroy;
begin
  inherited;
end;

class function TFactory.GetInstance: IFactory;
begin
  if (not Assigned(_instance)) then
    _instance := TFactory.Create;

  Result := _instance;
end;

end.
