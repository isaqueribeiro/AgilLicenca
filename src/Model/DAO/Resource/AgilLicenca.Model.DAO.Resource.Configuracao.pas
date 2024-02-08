unit AgilLicenca.Model.DAO.Resource.Configuracao;

interface

uses
  System.SysUtils,
  AgilLicenca.Model.DAO.Resource.Interfaces;

type
  TConfiguracao = class(TInterfacedObject, IConfiguracao)
    private
      FDriverID,
      FServer  : String;
      FPort : Integer;
      FDatabase ,
      FUserName ,
      FPassword ,
      FSchema   ,
      FLocking  : String;
    public
      constructor Create;
      destructor Destroy; override;
      class function New : IConfiguracao;

      function DriverID(Value : String) : IConfiguracao; overload;
      function DriverID : String; overload;
      function Server(Value : String) : IConfiguracao; overload;
      function Server : String; overload;
      function Port(Value : Integer) : IConfiguracao; overload;
      function Port : Integer; overload;
      function Database(Value : String) : IConfiguracao; overload;
      function Database : String; overload;
      function UserName(Value : String) : IConfiguracao; overload;
      function UserName : String; overload;
      function Password(Value : String) : IConfiguracao; overload;
      function Password : String; overload;
      function Schema(Value : String) : IConfiguracao; overload;
      function Schema : String; overload;
      function Locking(Value : String) : IConfiguracao; overload;
      function Locking : String; overload;
  end;

implementation

{ TConfiguracao }

constructor TConfiguracao.Create;
begin
  FDriverID := EmptyStr;
  FServer   := EmptyStr;
  FPort     := 0;
  FDatabase := EmptyStr;
  FUserName := EmptyStr;
  FPassword := EmptyStr;
  FSchema   := EmptyStr;
  FLocking  := EmptyStr;
end;

function TConfiguracao.Database: String;
begin
  Result := FDatabase;
end;

function TConfiguracao.Database(Value: String): IConfiguracao;
begin
  Result := Self;
  FDatabase := Value.Trim;
end;

destructor TConfiguracao.Destroy;
begin
  inherited;
end;

function TConfiguracao.DriverID: String;
begin
  Result := FDriverID;
end;

function TConfiguracao.DriverID(Value: String): IConfiguracao;
begin
  Result := Self;
  FDriverID := Value.Trim;
end;

function TConfiguracao.Locking: String;
begin
  Result := FLocking;
end;

function TConfiguracao.Locking(Value: String): IConfiguracao;
begin
  Result := Self;
  FLocking := Value.Trim;
end;

class function TConfiguracao.New: IConfiguracao;
begin
  Result := Self.Create;
end;

function TConfiguracao.Password: String;
begin
  Result :=  FPassword;
end;

function TConfiguracao.Password(Value: String): IConfiguracao;
begin
  Result := Self;
  FPassword := Value.Trim;
end;

function TConfiguracao.Port(Value: Integer): IConfiguracao;
begin
  Result := Self;
  FPort := Value;
end;

function TConfiguracao.Port: Integer;
begin
  Result := FPort;
end;

function TConfiguracao.Schema: String;
begin
  Result := FSchema;
end;

function TConfiguracao.Schema(Value: String): IConfiguracao;
begin
  Result := Self;
  FSchema := Value.Trim;
end;

function TConfiguracao.Server(Value: String): IConfiguracao;
begin
  Result := Self;
  FServer := Value.Trim;
end;

function TConfiguracao.Server: String;
begin
  Result := FServer;
end;

function TConfiguracao.UserName(Value: String): IConfiguracao;
begin
  Result := Self;
  FUserName := Value.Trim;
end;

function TConfiguracao.UserName: String;
begin
  Result := FUserName;
end;

end.
