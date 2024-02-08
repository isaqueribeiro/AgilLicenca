unit AgilLicenca.Model.DAO.Resource.ConexaoFireDAC;

interface

uses
  System.SysUtils,
  System.StrUtils,
  System.Classes,
  FireDAC.Stan.Intf,
  FireDAC.Stan.Option,
  FireDAC.Stan.Error,
  FireDAC.Stan.ExprFuncs,
  FireDAC.UI.Intf,
  FireDAC.Stan.Def,
  FireDAC.Stan.Pool,
  FireDAC.Stan.Async,
  FireDAC.ConsoleUI.Wait,
  FireDAC.Stan.Param,
  FireDAC.DatS,
  FireDAC.DApt.Intf,
  FireDAC.DApt,
  FireDAC.Phys,
  FireDAC.Phys.Intf,
  FireDAC.Phys.SQLiteWrapper.Stat,
  FireDAC.Phys.SQLiteDef,
  FireDAC.Phys.SQLite,
  FireDAC.Phys.FBDef,
  FireDAC.Phys.IBBase,
  FireDAC.Phys.FB,
  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,
  Data.DB,
  AgilLicenca.Model.DAO.Resource.Interfaces;

type
  TConexaoFireDAC = class(TInterfacedObject, IConexao)
    private
      FConfiguracao : IConfiguracao;
      FConnection : TFDConnection;
    public
      constructor Create(aConfiguracao : IConfiguracao);
      destructor Destroy; override;
      class function New(aConfiguracao : IConfiguracao) : IConexao;

      function Connect : TCustomConnection;
      procedure Disconnect;
  end;

implementation

{ TConexaoFireDAC }

function TConexaoFireDAC.Connect: TCustomConnection;
begin
  try
    FConnection.Params.BeginUpdate;
    FConnection.Params.Clear;
    FConnection.Params.AddPair('DriverID', FConfiguracao.DriverID);

    if Trim(FConfiguracao.DriverID).Equals('SQLite') then
    begin
      FConnection.Params.AddPair('Server', FConfiguracao.Server);
      FConnection.Params.AddPair('Port', IfThen(FConfiguracao.Port = 0, '', FConfiguracao.Port.ToString));
      FConnection.Params.AddPair('Database', FConfiguracao.Database);
      FConnection.Params.AddPair('OpenMode', 'CreateUTF8');

      if (not FConfiguracao.Locking.IsEmpty) then
        FConnection.Params.AddPair('LockingMode', FConfiguracao.Locking);
    end
    else
    if Trim(FConfiguracao.DriverID).Equals('FB') then
    begin
      FConnection.Params.AddPair('Protocol', 'TCPIP');
      FConnection.Params.AddPair('Server', FConfiguracao.Server);
      FConnection.Params.AddPair('Port', IfThen(FConfiguracao.Port = 0, '3050', FConfiguracao.Port.ToString));
      FConnection.Params.AddPair('Database', FConfiguracao.Database);
      FConnection.Params.AddPair('User_Name', FConfiguracao.UserName);
      FConnection.Params.AddPair('Password', FConfiguracao.Password);
      FConnection.Params.AddPair('CharacterSet', 'WIN1252');
    end;

    if (not FConfiguracao.Schema.IsEmpty) then
    begin
      FConnection.Params.AddPair('MetaCurSchema', FConfiguracao.Schema);
      FConnection.Params.AddPair('MetaDefSchema', FConfiguracao.Schema);
    end;

    FConnection.Params.EndUpdate;

    FConnection.Connected := True;

    Result := FConnection;
  except
    On E : Exception do
      raise Exception.Create('Erro ao tentar se conectar com a base de dados.' + #13 + E.Message);
  end;
end;

constructor TConexaoFireDAC.Create(aConfiguracao: IConfiguracao);
begin
  FConnection := TFDConnection.Create(nil);
  FConfiguracao := aConfiguracao;
end;

destructor TConexaoFireDAC.Destroy;
begin
  Disconnect;
  FConnection.DisposeOf;
  inherited;
end;

procedure TConexaoFireDAC.Disconnect;
begin
  FConnection.Connected := False;
end;

class function TConexaoFireDAC.New(aConfiguracao: IConfiguracao): IConexao;
begin
  Result := Self.Create(aConfiguracao);
end;

end.
