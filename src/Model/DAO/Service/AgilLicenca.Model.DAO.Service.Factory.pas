unit AgilLicenca.Model.DAO.Service.Factory;

interface

uses
  AgilLicenca.Model.DAO.Service.Interfaces;

type
  TFactoryServices = class(TInterfacedObject, IFactoryServices)
    strict private
      class var _instance : IFactoryServices;
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function GetInstance() : IFactoryServices;

      function Cliente : IClienteService;
  end;

implementation

{ TFactoryServices }

uses
  AgilLicenca.Model.DAO.Service.Cliente;

function TFactoryServices.Cliente: IClienteService;
begin
  Result := TClienteService.New;
end;

constructor TFactoryServices.Create;
begin
  ;
end;

destructor TFactoryServices.Destroy;
begin
  inherited;
end;

class function TFactoryServices.GetInstance: IFactoryServices;
begin
  if (not Assigned(_instance)) then
    _instance := TFactoryServices.Create;

  Result := _instance;
end;

end.
