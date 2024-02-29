unit AgilLicenca.Controller.Cliente;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  AgilLicenca.Controller.Interfaces,
  AgilLicenca.Model.DAO.Service.Interfaces;

type
  TClienteController = class(TInterfacedObject, IClienteController)
    private
      FDAO : IClienteService;
    protected
      constructor Create;
    public
      destructor Destroy; override;

      function DAO : IClienteService;
      function JsonObjectToObject(Value : TJsonObject) : IClienteController;
      function ValidatedData : IClienteController;
  end;

implementation

{ TClienteController }

uses
  GBJSON.Helper,
  GBJSON.Interfaces,
  AgilLicenca.Model.DAO.Service.Factory,
  AgilLicenca.Classe.ServiceValidate,
  AgilLicenca.Model.Entity.Cliente;

constructor TClienteController.Create;
begin
  FDAO := TFactoryServices.GetInstance.Cliente;
  TGBJSONConfig.GetInstance.CaseDefinition(TCaseDefinition.cdLowerCamelCase);
end;

function TClienteController.DAO: IClienteService;
begin
  Result := FDAO;
end;

destructor TClienteController.Destroy;
begin
  inherited;
end;

function TClienteController.JsonObjectToObject(Value: TJsonObject): IClienteController;
begin
  Result := Self;
  TGBJSONDefault.Serializer<TCliente>(false).JsonObjectToObject(FDAO.Entity, Value);
end;

function TClienteController.ValidatedData: IClienteController;
begin
  Result := Self;

  if FDAO.Entity.CpfCnpj.IsEmpty then
    raise Exception.Create('Cpf/Cnpj não informado!');

  if (not TServiceValidate.IsCpf(FDAO.Entity.CpfCnpj)) and (not TServiceValidate.IsCnpj(FDAO.Entity.CpfCnpj)) then
    raise Exception.Create('O número do Cpf/Cnpj é inválido!');

  if FDAO.Entity.Email.IsEmpty then
    raise Exception.Create('E-mail não informado!');

  if (not TServiceValidate.IsEmail(FDAO.Entity.Email)) then
    raise Exception.Create('O e-mail informado é inválido!');
end;

end.
