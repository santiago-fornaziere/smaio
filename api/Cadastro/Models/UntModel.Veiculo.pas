unit UntModel.Veiculo;

interface

uses
  UntInterface.Veiculo,
  System.JSON,
  System.SysUtils,
  UntModel.Query,
  DataSet.Serialize,
  UntFuncoes;

type
  TVeiculo = class(TInterfacedObject, iVeiculo)
  private
    Fvei_id : integer;
    Fvei_descricao : String;
    Fvei_fab_id : integer;
    Fvei_sit_reg : boolean;
    function vei_id : integer; overload;
    function vei_id (const Value : integer): iVeiculo; overload;
    function vei_descricao : String; overload;
    function vei_descricao (const Value : String) : iVeiculo; overload;
    function vei_fab_id : integer; overload;
    function vei_fab_id (const Value : integer): iVeiculo; overload;
    function vei_sit_reg : boolean; overload;
    function vei_sit_reg (const Value : boolean): iVeiculo; overload;
    constructor Create;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
  public
    destructor Destroy; override;
    class function New : iVeiculo;
  end;

implementation

{ TVeiculo }

function TVeiculo.Alterar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Veiculo\veiculo_update.sql');
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
      vQry.Query.ParamByName('veic_descricao').AsString := Fvei_descricao;
      vQry.Query.ParamByName('veic_id').AsInteger := Fvei_id;
      vQry.Query.ParamByName('veic_fab_id').AsInteger := Fvei_fab_id;
      vQry.Query.ParamByName('veic_sit_reg').AsBoolean := Fvei_sit_reg;
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

function TVeiculo.Cadastrar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Veiculo\veiculo_insert.sql');
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
      vQry.Query.ParamByName('veic_descricao').AsString := Fvei_descricao;
      vQry.Query.ParamByName('veic_fab_id').AsInteger := Fvei_fab_id;
      vQry.Query.Open;
      Fvei_id := vQry.Query.FieldByName('vei_ID').AsInteger;
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

constructor TVeiculo.Create;
begin
  Fvei_sit_reg := true;
end;

destructor TVeiculo.Destroy;
begin

  inherited;
end;

class function TVeiculo.New: iVeiculo;
begin
  Result := Self.Create;
end;

function TVeiculo.vei_descricao(const Value: String): iVeiculo;
begin
   if not (Length(Value) > 0) then
     raise Exception.Create('Verifique a descri��o...');

   Result := Self;
   Fvei_descricao := Value;
end;

function TVeiculo.vei_descricao: String;
begin
  Result := Fvei_descricao;
end;

function TVeiculo.vei_fab_id(const Value: integer): iVeiculo;
begin
   Result := Self;
   Fvei_fab_id := Value;
end;

function TVeiculo.vei_fab_id: integer;
begin
  Result := Fvei_fab_id;
end;

function TVeiculo.vei_id: integer;
begin
   Result := Fvei_id;
end;

function TVeiculo.vei_id(const Value: integer): iVeiculo;
begin
   Result := Self;
   Fvei_id := Value;
end;

function TVeiculo.vei_sit_reg: boolean;
begin
   Result := vei_sit_reg;
end;

function TVeiculo.vei_sit_reg(const Value: boolean): iVeiculo;
begin
   Result := Self;
   Fvei_sit_reg := Value;
end;

end.