unit AgilLicenca.Model.DAO.Service.Interfaces;

interface

uses
  System.JSON,
  System.Generics.Collections,
  AgilLicenca.Model.DAO.Resource.Interfaces,
  AgilLicenca.Model.Entity.Cliente;

type
  IClienteService = interface
    ['{6D6A0E09-D25A-44CD-A40F-8D588A44DA75}']
    function Entity  : TCliente;
    function Service : IServico<TCliente>;
  end;

  IFactoryServices = interface
    ['{F6AD04A9-F217-42C4-BE86-90E3A10FC723}']
    function Cliente : IClienteService;
  end;

implementation

end.
