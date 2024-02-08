unit AgilLicenca.Model.DAO.Service.Interfaces;

interface

uses
  System.JSON,
  System.Generics.Collections;

type
  IService<T : class> = interface
    ['{BEA17ED3-96A1-4B2C-AA1F-DDD20EA985A6}']
    function CampoChave(aValue : String) : IService<T>; overload;
    function CampoChave : String; overload;
    function ListarTodos : IService<T>;
    function ListarPorId(aId : String) : IService<T>; overload;
    function ListarPorId(aId : Int64) : IService<T>; overload;
    function ListarPor(aField : String; aValue : Variant) : IService<T>; overload;
    function ListarPor(aField : String; aValue : String) : IService<T>; overload;
    function ListarPor(aField : String; aValue : Int64) : IService<T>; overload;
    function Inserir : IService<T>;
    function Atualizar : IService<T>;
    function Excluir(aField : String; aValue : String) : IService<T>; overload;
    function Excluir : IService<T>; overload;
    function IsEmpty : Boolean;
    function DataSetAsJsonArray : TJsonArray;
    function DataSetAsJsonObject : TJsonObject;
    function Entity : T;
    function List : TObjectList<T>;
  end;

implementation

end.
