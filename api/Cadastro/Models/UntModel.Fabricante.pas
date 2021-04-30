unit UntModel.Fabricante;

interface

uses
  UntInterface.Fabricante,
  System.JSON,
  System.SysUtils,
  UntModel.Query,
  DataSet.Serialize,
  UntFuncoes;

type
  TFabricante = class(TInterfacedObject, iFabricante)
  private
    Ffab_id : integer;
    Ffab_nome : string;
    function fab_id : integer; overload;
    function fab_id (const Value : integer): iFabricante; overload;
    function fab_nome : String; overload;
    function fab_nome (const Value : String) : iFabricante; overload;
    constructor Create;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
  public
    destructor Destroy; override;
    class function New : iFabricante;
  end;

implementation



{ TFabricante }

function TFabricante.Alterar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Fabricante\fabricante_update.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.Connection.StartTransaction;
    try
      vQry.Query.SQL.Add(vSQL);
      vQry.Query.ParamByName('fab_nome').AsString := Ffab_nome;
      vQry.Query.ParamByName('fab_id').AsInteger := Ffab_id;
      vQry.Query.Open;
      vQry.Query.Connection.Commit;

      Result := vQry.Query.ToJSONObject;
    except
      on E : Exception do
      begin
        vQry.Query.Connection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    freeandnil(vQry);
  end;
end;

function TFabricante.Cadastrar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Fabricante\fabricante_insert.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.Connection.StartTransaction;
    try
      vQry.Query.SQL.Add(vSQL);
      vQry.Query.ParamByName('fab_nome').AsString := Ffab_nome;
      vQry.Query.Open;
      Ffab_id := vQry.Query.FieldByName('fab_ID').AsInteger;
      vQry.Query.Connection.Commit;

      Result := vQry.Query.ToJSONObject;
    except
      on E : Exception do
      begin
        vQry.Query.Connection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    freeandnil(vQry);
  end;
end;

constructor TFabricante.Create;
begin

end;

destructor TFabricante.Destroy;
begin

  inherited;
end;

function TFabricante.fab_id: integer;
begin
   Result := Ffab_id;
end;

function TFabricante.fab_id(const Value: integer): iFabricante;
begin
  Result := Self;
  Ffab_id := Value;
end;

function TFabricante.fab_nome: String;
begin
  Result := Ffab_nome;
end;

function TFabricante.fab_nome(const Value: String): iFabricante;
begin
  if not (Length(Value) > 0) then
     raise Exception.Create('Verifique o nome...');

  Result := Self;
  Ffab_nome := Value;
end;

class function TFabricante.New: iFabricante;
begin
  Result := Self.Create;
end;

end.