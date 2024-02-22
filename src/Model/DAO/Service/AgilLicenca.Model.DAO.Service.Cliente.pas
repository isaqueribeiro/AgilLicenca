unit AgilLicenca.Model.DAO.Service.Cliente;

interface

uses
  AgilLicenca.Model.DAO.Service.Interfaces,
  AgilLicenca.Model.DAO.Resource.Interfaces,
  AgilLicenca.Model.DAO.Resource.ServicoFireDAC,
  AgilLicenca.Model.Entity.Cliente;

type
  TClienteService = class(TInterfacedObject, IClienteService)
    private
      FEntity  : TCliente;
      FService : IServico<TCliente>;
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function New : IClienteService;

      function Entity  : TCliente;
      function Service : IServico<TCliente>;
  end;

implementation

{ TClienteService }

constructor TClienteService.Create;
begin
  FEntity  := TCliente.Create;
  FService := TServicoFireDAC<TCliente>.New(FEntity);
end;

destructor TClienteService.Destroy;
begin
  FEntity.DisposeOf;
  inherited;
end;

function TClienteService.Entity: TCliente;
begin
  Result := FEntity;
end;

class function TClienteService.New: IClienteService;
begin
  Result := Self.Create;
end;

function TClienteService.Service: IServico<TCliente>;
begin
  Result := FService;
end;

end.
