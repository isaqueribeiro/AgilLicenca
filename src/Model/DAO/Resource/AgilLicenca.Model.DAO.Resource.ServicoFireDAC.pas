unit AgilLicenca.Model.DAO.Resource.ServicoFireDAC;

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

  AgilLicenca.Model.DAO.Resource.Interfaces,
  AgilLicenca.Model.DAO.Resource.ConexaoPool;

type
  TServicoFireDAC<T : class, constructor> = class(TInterfacedObject, IServico<T>)
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
      class function New(aParent : T) : IServico<T>;

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
      function List(Value : TObjectList<T>) : IServico<T>; overload;
      function List : TObjectList<T>; overload;
  end;

implementation

{ TServicoFireDAC<T> }


function TServicoFireDAC<T>.Atualizar: IServico<T>;
begin
  Result := Self;
  FDAO.Update(FParent);
end;

function TServicoFireDAC<T>.CampoChave: String;
begin
  Result := FCampoChave;
end;

function TServicoFireDAC<T>.CampoChave(aValue: String): IServico<T>;
begin
  Result := Self;
  FCampoChave := aValue.Trim.ToUpper;
end;

constructor TServicoFireDAC<T>.Create(aParent: T);
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

function TServicoFireDAC<T>.DataSetAsJsonArray: TJsonArray;
begin
  Result := FDataSource.DataSet.ToJsonArray;
end;

function TServicoFireDAC<T>.DataSetAsJsonObject: TJsonObject;
begin
  Result := FDataSource.DataSet.ToJsonObject;
end;

destructor TServicoFireDAC<T>.Destroy;
begin
  TConexaoPool.GetInstance().Disconnected(FIndexConn);
  FDataSource.DisposeOf;
  FList.DisposeOf;
  inherited;
end;

function TServicoFireDAC<T>.Entity: T;
begin
  Result := FParent;
end;

function TServicoFireDAC<T>.Excluir(aField, aValue: String): IServico<T>;
begin
  Result := Self;
  FDAO.Delete(aField, aValue.QuotedString);
end;

function TServicoFireDAC<T>.Excluir: IServico<T>;
begin
  Result := Self;
  FDAO.Delete(FParent);
end;

function TServicoFireDAC<T>.Excluir(aField: String; aValue: Int64): IServico<T>;
begin
  Result := Self;
  FDAO.Delete(aField, aValue.ToString);
end;

function TServicoFireDAC<T>.Inserir: IServico<T>;
begin
  Result := Self;
  FDAO.Insert(FParent);
end;

function TServicoFireDAC<T>.IsEmpty: Boolean;
begin
  Result := FDataSource.DataSet.IsEmpty;
end;

function TServicoFireDAC<T>.List: TObjectList<T>;
begin
  Result := FList;
end;

function TServicoFireDAC<T>.List(Value: TObjectList<T>): IServico<T>;
begin
  Result := Self;
  FList := Value;
end;

function TServicoFireDAC<T>.ListarPor(aField: String; aValue: Int64): IServico<T>;
begin
  Result := Self;
  FDAO.Find(aField, aValue);
  TSimpleRTTI<T>.New(nil).DataSetToEntityList(FDataSource.DataSet, FList);
end;

function TServicoFireDAC<T>.ListarPor(aField, aValue: String): IServico<T>;
begin
  Result := Self;
  FDAO.Find(aField, aValue);
  TSimpleRTTI<T>.New(nil).DataSetToEntityList(FDataSource.DataSet, FList);
end;

function TServicoFireDAC<T>.ListarPor(aField: String; aValue: Variant): IServico<T>;
begin
  Result := Self;
  FDAO.Find(aField, aValue);
  TSimpleRTTI<T>.New(nil).DataSetToEntityList(FDataSource.DataSet, FList);
end;

function TServicoFireDAC<T>.ListarPorId(aId: String): IServico<T>;
begin
  Result := Self;
  FDAO.Find(FCampoChave, aID);
  TSimpleRTTI<T>.New(nil).DataSetToEntity(FDataSource.DataSet, FParent);
end;

function TServicoFireDAC<T>.ListarPorId(aId: Int64): IServico<T>;
begin
  Result := Self;
  FDAO.Find(FCampoChave, aID);
  TSimpleRTTI<T>.New(nil).DataSetToEntity(FDataSource.DataSet, FParent);
end;

function TServicoFireDAC<T>.ListarTodos: IServico<T>;
begin
  Result := Self;
  FDAO.Find(False);
  TSimpleRTTI<T>.New(nil).DataSetToEntityList(FDataSource.DataSet, FList);
end;

class function TServicoFireDAC<T>.New(aParent: T): IServico<T>;
begin
  Result := Self.Create(aParent);
end;

end.
