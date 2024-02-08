unit AgilLicenca.Model.DAO.Interfaces;

interface

uses
  System.JSON,
  System.Generics.Collections;

type
  IDAO<T : class> = interface
    ['{BEA17ED3-96A1-4B2C-AA1F-DDD20EA985A6}']
    function ListarTodos : IDAO<T>;
    function ListarPorId(aId : String) : IDAO<T>; overload;
    function ListarPorId(aId : Int64) : IDAO<T>; overload;
    function ListarPor(aField : String; aValue : Variant) : IDAO<T>; overload;
    function ListarPor(aField : String; aValue : String) : IDAO<T>; overload;
    function ListarPor(aField : String; aValue : Int64) : IDAO<T>; overload;
    function Inserir : IDAO<T>;
    function Atualizar : IDAO<T>;
    function Excluir(aField : String; aValue : String) : IDAO<T>; overload;
    function Excluir : IDAO<T>; overload;
    function IsEmpty : Boolean;
    function DataSetAsJsonArray : TJsonArray;
    function DataSetAsJsonObject : TJsonObject;
    function Entity : T;
    function List : TObjectList<T>;
  end;

implementation

end.
