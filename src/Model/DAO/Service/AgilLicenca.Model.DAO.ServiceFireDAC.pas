unit AgilLicenca.Model.DAO.ServiceFireDAC;

interface

uses
  System.SysUtils,
  System.JSON,
  System.Generics.Collections,
  Data.DB,

  FireDAC.Comp.DataSet,
  FireDAC.Comp.Client,

  SimpleInterface,
  SimpleDAO,
  SimpleQueryFireDAC,
  SimpleRTTI,
  DataSet.Serialize,

  AgilLicenca.Model.DAO.Service.Interfaces,
  AgilLicenca.Model.DAO.Resource.ConexaoPool;

type
  TServiceFireDAC<T : class, constructor> = class(TInterfacedObject, IService<T>)
    private
      FParent : T;
      FList : TObjectList<T>;
      FConn : ISimpleQuery;
      FIndexConn : Integer;
      FDAO : ISimpleDAO<T>;
      FDataSource : TDataSource;
      FCampoChave : String;
    protected
      constructor Create(aParent : T);
    public
      destructor Destroy; override;
      class function New(aParent : T) : IService<T>;

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

{ TServiceFireDAC<T> }


function TServiceFireDAC<T>.Atualizar: IService<T>;
begin
  Result := Self;
  FDAO.Update(FParent);
end;

function TServiceFireDAC<T>.CampoChave: String;
begin
  Result := FCampoChave;
end;

function TServiceFireDAC<T>.CampoChave(aValue: String): IService<T>;
begin
  Result := Self;
  FCampoChave := aValue.Trim.ToUpper;
end;

constructor TServiceFireDAC<T>.Create(aParent: T);
begin
  FParent := aParent;
  FList := TObjectList<T>.Create;
  FDataSource := TDataSource.Create(nil);
  FConn := TSimpleQueryFireDAC.New(TFDConnection(
    TConexaoPool.GetInstance().Connected(FIndexConn)
  ));
  FDAO := TSimpleDAO<T>.New(FConn).DataSource(FDataSource);

  TDataSetSerializeConfig.GetInstance.CaseNameDefinition := TCaseNameDefinition.cndLower;
  TSimpleRTTI<T>.New(nil).PrimaryKey(FCampoChave);
end;

function TServiceFireDAC<T>.DataSetAsJsonArray: TJsonArray;
begin
  Result := FDataSource.DataSet.ToJsonArray;
end;

function TServiceFireDAC<T>.DataSetAsJsonObject: TJsonObject;
begin
  Result := FDataSource.DataSet.ToJsonObject;
end;

destructor TServiceFireDAC<T>.Destroy;
begin
  TConexaoPool.GetInstance().Disconnected(FIndexConn);
  FDataSource.DisposeOf;
  FList.DisposeOf;
  inherited;
end;

function TServiceFireDAC<T>.Entity: T;
begin
  Result := FParent;
end;

function TServiceFireDAC<T>.Excluir(aField, aValue: String): IService<T>;
begin
  Result := Self;
  FDAO.Delete(aField, aValue);
end;

function TServiceFireDAC<T>.Excluir: IService<T>;
begin
  Result := Self;
  FDAO.Delete(FParent);
end;

function TServiceFireDAC<T>.Inserir: IService<T>;
begin
  Result := Self;
  FDAO.Insert(FParent);
end;

function TServiceFireDAC<T>.IsEmpty: Boolean;
begin
  Result := FDataSource.DataSet.IsEmpty;
end;

function TServiceFireDAC<T>.List: TObjectList<T>;
begin
  Result := FList;
end;

function TServiceFireDAC<T>.ListarPor(aField: String; aValue: Int64): IService<T>;
begin
  Result := Self;
  FDAO.Find(aField, aValue);
  TSimpleRTTI<T>.New(nil).DataSetToEntityList(FDataSource.DataSet, FList);
end;

function TServiceFireDAC<T>.ListarPor(aField, aValue: String): IService<T>;
begin
  Result := Self;
  FDAO.Find(aField, aValue);
  TSimpleRTTI<T>.New(nil).DataSetToEntityList(FDataSource.DataSet, FList);
end;

function TServiceFireDAC<T>.ListarPor(aField: String; aValue: Variant): IService<T>;
begin
  Result := Self;
  FDAO.Find(aField, aValue);
  TSimpleRTTI<T>.New(nil).DataSetToEntityList(FDataSource.DataSet, FList);
end;

function TServiceFireDAC<T>.ListarPorId(aId: String): IService<T>;
begin
  Result := Self;
  FDAO.Find(FCampoChave, aID);
  TSimpleRTTI<T>.New(nil).DataSetToEntity(FDataSource.DataSet, FParent);
end;

function TServiceFireDAC<T>.ListarPorId(aId: Int64): IService<T>;
begin
  Result := Self;
  FDAO.Find(FCampoChave, aID);
  TSimpleRTTI<T>.New(nil).DataSetToEntity(FDataSource.DataSet, FParent);
end;

function TServiceFireDAC<T>.ListarTodos: IService<T>;
begin
  Result := Self;
  FDAO.Find(False);
  TSimpleRTTI<T>.New(nil).DataSetToEntityList(FDataSource.DataSet, FList);
end;

class function TServiceFireDAC<T>.New(aParent: T): IService<T>;
begin
  Result := Self.Create(aParent);
end;

end.
