unit AgilLicenca.Controller.Interfaces;

interface

uses
  System.JSON,
  AgilLicenca.Model.DAO.Service.Interfaces;

type
  IClienteController = interface
    ['{7FCE1C6F-47EC-48F0-AEA5-E2788B7AF7EE}']
    function DAO : IClienteService;
    function JsonObjectToObject(Value : TJsonObject) : IClienteController;
    function ValidatedData : IClienteController;
  end;

  IFactoryController = interface
    ['{0F07DCED-86BE-41A1-8E43-9F549CB23B1D}']
    function Cliente : IClienteController;
  end;

implementation

end.
