unit UntModel.SubGrupo;

interface

uses
  UntModel.SubGruVeiAno,
  System.Generics.Collections,
  System.JSON,
  UntInterface.SubGrupo,
  UntModel.Query,
  DataSet.Serialize,
  UntFuncoes, System.SysUtils;

type
  TSubGrupo = class(TInterfacedObject, iSubGrupo)
  public
    Fsgru_id : integer;
    Fsgru_descricao : String;
    Fsgru_pec_id : integer;
    Fsgru_tra_id : integer;
    Fsgru_sit_reg : boolean;
    Fsgru_vanos : TList<TSubGrupoVeiculoAno>;

    function sgru_id : integer; overload;
    function sgru_id (const Value : integer): iSubGrupo; overload;
    function sgru_descricao : String; overload;
    function sgru_descricao (const Value : String): iSubGrupo; overload;
    function sgru_pec_id : integer; overload;
    function sgru_pec_id (const Value : integer): iSubGrupo; overload;
    function sgru_sit_reg : boolean; overload;
    function sgru_sit_reg (const Value : boolean): iSubGrupo; overload;

    function Alterar: TJSONObject;
    constructor Create;
    procedure AddVeiculoAno(const Value : TSubGrupoVeiculoAno);
    destructor Destroy; override;
    class function New : iSubGrupo;
  end;
implementation

{ TSubGrupo }

procedure TSubGrupo.AddVeiculoAno(const Value: TSubGrupoVeiculoAno);
begin
  Fsgru_vanos.Add(Value);
end;

function TSubGrupo.Alterar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    // lendo arquivos de sql
    AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\subgrupo_update.sql');
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
      vQry.Query.ParamByName('sgru_id').AsInteger := Fsgru_id;
      vQry.Query.ParamByName('sgru_descricao').AsString := Fsgru_descricao;
      vQry.Query.ParamByName('sgru_pec_id').AsInteger := Fsgru_pec_id;
      vQry.Query.ParamByName('sgru_sit_reg').AsBoolean := Fsgru_sit_reg;
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

constructor TSubGrupo.Create;
begin
  Fsgru_vanos := TList<TSubGrupoVeiculoAno>.Create;
  Fsgru_sit_reg := true;
end;

destructor TSubGrupo.Destroy;
begin
  Fsgru_vanos.Free;
  inherited;
end;

class function TSubGrupo.New: iSubGrupo;
begin
  Result := Self.Create;
end;

function TSubGrupo.sgru_descricao(const Value: String): iSubGrupo;
begin
  Result := Self;
  Fsgru_descricao := Value;
end;

function TSubGrupo.sgru_descricao: String;
begin
   Result := Fsgru_descricao;
end;

function TSubGrupo.sgru_id: integer;
begin
   Result := Fsgru_id;
end;

function TSubGrupo.sgru_id(const Value: integer): iSubGrupo;
begin
   Result := Self;
   Fsgru_id := value;
end;

function TSubGrupo.sgru_pec_id: integer;
begin
   Result := Fsgru_pec_id;
end;

function TSubGrupo.sgru_pec_id(const Value: integer): iSubGrupo;
begin
   Result := Self;
   Fsgru_pec_id := Value;
end;

function TSubGrupo.sgru_sit_reg: boolean;
begin
  Result := Fsgru_sit_reg;
end;

function TSubGrupo.sgru_sit_reg(const Value: boolean): iSubGrupo;
begin
  Result := Self;
  Fsgru_sit_reg := Value;
end;

end.
