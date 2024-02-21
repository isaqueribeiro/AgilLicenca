program AgilLicencaAPI;

{$APPTYPE CONSOLE}

{$R *.res}

uses
  Horse,
  Horse.CORS,
  Horse.Jhonson,
  Horse.HandleException,
  System.SysUtils,
  AgilLicenca.Model.DAO.Resource.Interfaces in 'Model\DAO\Resource\AgilLicenca.Model.DAO.Resource.Interfaces.pas',
  AgilLicenca.Model.DAO.Resource.Configuracao in 'Model\DAO\Resource\AgilLicenca.Model.DAO.Resource.Configuracao.pas',
  AgilLicenca.Model.DAO.Resource.ConexaoFireDAC in 'Model\DAO\Resource\AgilLicenca.Model.DAO.Resource.ConexaoFireDAC.pas',
  AgilLicenca.Model.DAO.Resource.Factory in 'Model\DAO\Resource\AgilLicenca.Model.DAO.Resource.Factory.pas',
  AgilLicenca.Model.DAO.Resource.ConexaoPool in 'Model\DAO\Resource\AgilLicenca.Model.DAO.Resource.ConexaoPool.pas',
  AgilLicenca.Model.DAO.Resource.ServicoFireDAC in 'Model\DAO\Resource\AgilLicenca.Model.DAO.Resource.ServicoFireDAC.pas',
  AgilLicenca.Model.DAO.Service.Interfaces in 'Model\DAO\Service\AgilLicenca.Model.DAO.Service.Interfaces.pas',
  AgilLicenca.Model.Entity.Cliente in 'Model\Entity\AgilLicenca.Model.Entity.Cliente.pas',
  AgilLicenca.Model.Entity.Endereco in 'Model\Entity\AgilLicenca.Model.Entity.Endereco.pas',
  AgilLicenca.Classe.ServiceUtils in 'Classe\AgilLicenca.Classe.ServiceUtils.pas';

procedure InicializarHorse;
begin
  THorse
    .Use(CORS)
    .Use(Jhonson)
    .Use(HandleException);
end;

procedure WriteInConsole;
begin
  Writeln(Format(' Servidor : %s', [THorse.Host]));
  Writeln(Format(' Porta    : %d', [THorse.Port]));
  Writeln('---');
  Writeln(' Ágil Licença API - Active service');
  Writeln('---');
end;

procedure GetPing(aReq: THorseRequest; aRes: THorseResponse) ;
begin
  aRes.Send('pong');
end;

begin
  ReportMemoryLeaksOnShutdown := True;

  InicializarHorse;
  THorse.Get('/ping', GetPing);
  THorse.Listen(9000, WriteInConsole);
end.
