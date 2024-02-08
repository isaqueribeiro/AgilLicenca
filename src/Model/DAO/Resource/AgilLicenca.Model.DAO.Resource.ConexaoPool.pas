unit AgilLicenca.Model.DAO.Resource.ConexaoPool;

interface

uses
  System.SysUtils,
  System.IOUtils,
  System.Generics.Collections,
  Data.DB,
  AgilLicenca.Model.DAO.Resource.Interfaces,
  AgilLicenca.Model.DAO.Resource.Factory;

type
  TConexaoPool = class
    private
      FConfiguracao : IConfiguracao;
      FConnList : TList<IConexao>;
      procedure ConfigurarConexao;
    protected
      constructor Create;
    public
      destructor Destroy; override;
      class function GetInstance() : TConexaoPool;

      procedure Disconnected(aIndexConnection : Integer);
      function Connected(var aIndexConnection : Integer) : TCustomConnection;
  end;

var
  gConexaoPool : TConexaoPool;

implementation

{ TConexaoPool }

procedure TConexaoPool.ConfigurarConexao;
var
  aDatabase : String;
begin
  aDatabase := TPath.Combine(System.SysUtils.GetCurrentDir, 'db\ControleLicencas.db');
  if not DirectoryExists(TPath.GetDirectoryName(aDatabase)) then
    ForceDirectories(TPath.GetDirectoryName(aDatabase));

  FConfiguracao
    .DriverID('SQLite')
    .Database(aDatabase)
    .Locking('Normal');
end;

function TConexaoPool.Connected(var aIndexConnection: Integer): TCustomConnection;
begin
  aIndexConnection := FConnList.Add(TFactory.GetInstance().Conexao(FConfiguracao));
  Result := FConnList[aIndexConnection].Connect;
end;

constructor TConexaoPool.Create;
begin
  FConfiguracao := TFactory.GetInstance().Configuracao;
  FConnList := TList<IConexao>.Create;
  ConfigurarConexao;
end;

destructor TConexaoPool.Destroy;
begin
  FConnList.DisposeOf;
  inherited;
end;

procedure TConexaoPool.Disconnected(aIndexConnection: Integer);
begin
  FConnList[aIndexConnection].Disconnect;
end;

class function TConexaoPool.GetInstance: TConexaoPool;
begin
  Result := gConexaoPool;
end;

initialization
  gConexaoPool := TConexaoPool.Create;

finalization
  gConexaoPool.DisposeOf;

end.
