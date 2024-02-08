unit AgilLicenca.Model.DAO.Resource.Interfaces;

interface

uses
  System.JSON,
  System.Generics.Collections,
  Data.DB;

type
  IConfiguracao = interface
    ['{88BB95B0-8609-4EEB-874C-E6DDE386DA0F}']
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

  IConexao = interface
    ['{4D6038F7-A6A2-4EB3-9D1F-4A53B2A70E34}']
    function Connect : TCustomConnection;
    procedure Disconnect;
  end;

  IFactory = interface
    ['{5E9FFEF8-AFBE-423E-BB4B-DA745040D231}']
    function Configuracao : IConfiguracao;
    function Conexao(aConfiguracao : IConfiguracao) : IConexao;
  end;

implementation

end.
