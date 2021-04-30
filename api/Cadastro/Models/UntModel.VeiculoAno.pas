unit UntModel.VeiculoAno;

interface

uses
  UntInterface.VeiculoAno,
  System.JSON,
  System.SysUtils,
  UntModel.Query,
  DataSet.Serialize,
  UntFuncoes;

type
  TVeiculoAno = class(TInterfacedObject, iVeiculoAno)
  private
    Fvano_id : integer;
    Fvano_vei_id : integer;
    Fvano_ano_id : integer;
    function vano_id : integer; overload;
    function vano_id (const Value : integer): iVeiculoAno; overload;
    function vano_vei_id : integer; overload;
    function vano_vei_id (const Value : integer): iVeiculoAno; overload;
    function vano_ano_id : integer; overload;
    function vano_ano_id (const Value : integer): iVeiculoAno; overload;
    function Cadastrar: TJSONObject;
    constructor Create;
  public
    destructor Destroy; override;
    class function New : iVeiculoAno;
  end;


implementation

{ TVeiculoAno }

function TVeiculoAno.Cadastrar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\VeiculoAno\veiano_insert.sql');
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
      vQry.Query.ParamByName('vano_vei_id').AsInteger := Fvano_vei_id;
      vQry.Query.ParamByName('vano_ano_id').AsInteger := Fvano_ano_id;
      vQry.Query.Open;
      Fvano_id := vQry.Query.FieldByName('vano_ID').AsInteger;
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

constructor TVeiculoAno.Create;
begin

end;

destructor TVeiculoAno.Destroy;
begin

  inherited;
end;

class function TVeiculoAno.New: iVeiculoAno;
begin
   Result := Self.Create;
end;

function TVeiculoAno.vano_ano_id(const Value: integer): iVeiculoAno;
begin
   if not (Value > 0) then
      raise Exception.Create('Verificar o Ano...');

   Result := Self;
   Fvano_ano_id := Value;
end;

function TVeiculoAno.vano_ano_id: integer;
begin
   Result := Fvano_ano_id;
end;

function TVeiculoAno.vano_id(const Value: integer): iVeiculoAno;
begin
   Result := Self;
   Fvano_ano_id := Value;
end;

function TVeiculoAno.vano_id: integer;
begin
   Result := Fvano_id;
end;

function TVeiculoAno.vano_vei_id(const Value: integer): iVeiculoAno;
begin
   if not (Value > 0) then
      raise Exception.Create('Verificar o Ve�culo...');

   Result := Self;
   Fvano_vei_id := Value;
end;

function TVeiculoAno.vano_vei_id: integer;
begin
   Result := Fvano_vei_id;
end;

end.
