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

  IServico<T : class> = interface
    ['{BEA17ED3-96A1-4B2C-AA1F-DDD20EA985A6}']
    function CampoChave(aValue : String) : IServico<T>; overload;
    function CampoChave : String; overload;
    function ListarTodos : IServico<T>;
    function ListarPorId(aId : String) : IServico<T>; overload;
    function ListarPorId(aId : Int64) : IServico<T>; overload;
    function ListarPor(aField : String; aValue : Variant) : IServico<T>; overload;
    function ListarPor(aField : String; aValue : String) : IServico<T>; overload;
    function ListarPor(aField : String; aValue : Int64) : IServico<T>; overload;
    function Inserir : IServico<T>;
    function Atualizar : IServico<T>;
    function Excluir(aField : String; aValue : String) : IServico<T>; overload;
    function Excluir(aField : String; aValue : Int64) : IServico<T>; overload;
    function Excluir : IServico<T>; overload;
    function IsEmpty : Boolean;
    function DataSetAsJsonArray : TJsonArray;
    function DataSetAsJsonObject : TJsonObject;
    function Entity : T;
    function List : TObjectList<T>;
  end;

  IFactory = interface
    ['{5E9FFEF8-AFBE-423E-BB4B-DA745040D231}']
    function Configuracao : IConfiguracao;
    function Conexao(aConfiguracao : IConfiguracao) : IConexao;
  end;


implementation

end.
