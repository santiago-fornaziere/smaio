unit UntModel.Peca;

interface

uses
  UntInterface.Peca,
  UntModel.SubGrupo,
  System.JSON,
  System.SysUtils,
  UntModel.Query,
  DataSet.Serialize,
  UntFuncoes,
  System.Generics.Collections, UntModel.SubGruVeiAno;

type
  TPeca = class(TInterfacedObject, iPeca)
  private
    Fpec_id : integer;
    Fpec_descricao : string;
    Fpec_gru_id : integer;
    Fpec_tra_id : integer;
    Fpec_sit_reg : boolean;
    Fpec_sgrus : TList<TSubGrupo>;
    Fpec_usu_id : integer;
    function pec_id : integer; overload;
    function pec_id (const Value : integer): iPeca; overload;
    function pec_descricao : String; overload;
    function pec_descricao (const Value : String): iPeca; overload;
    function pec_gru_id : integer; overload;
    function pec_gru_id (const Value : integer): iPeca; overload;
    function pec_tra_id : integer; overload;
    function pec_tra_id (const Value : integer): iPeca; overload;
    function pec_sit_reg : boolean; overload;
    function pec_sit_reg (const Value : boolean): iPeca; overload;
    function pec_sgrus : TList<TSubGrupo>; overload;
    function pec_sgrus (const Value : TList<TSubGrupo>): iPeca; overload;
    function pec_sgrus (const Value : TJSONArray): iPeca; overload;
    function pec_usu_id : integer; overload;
    function pec_usu_id (const Value : integer): iPeca; overload;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
    function AddSubGrupos(const Value : TSubGrupo) : iPeca;
    constructor Create;
  public
    destructor Destroy; override;
    class function New : iPeca;
  end;
implementation

{ TVeiculoAno }

function TPeca.AddSubGrupos(const Value: TSubGrupo): iPeca;
begin
  Result := Self;
  Fpec_sgrus.Add(Value);
end;

function TPeca.Alterar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    // lendo arquivos de sql
    AssignFile(f, Sistema.Path_SQL+'Smaio\Peca\peca_update.sql');
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
      vQry.Query.ParamByName('pec_id').AsInteger := Fpec_id;
      vQry.Query.ParamByName('pec_descricao').AsString := Fpec_descricao;
      vQry.Query.ParamByName('pec_gru_id').AsInteger := Fpec_gru_id;
      vQry.Query.ParamByName('pec_sit_reg').AsBoolean := Fpec_sit_reg;
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

function TPeca.Cadastrar: TJSONObject;
var
   vSQL, vSQLSG, vSQLSGV, fLinha : String;
   vQry : TQuery;
   f : TextFile;
   vSgru : TSubGrupo;
   vSgvano : TSubGrupoVeiculoAno;
   ja: TJSONArray;
   jv: TJSONValue;
   jSubObj, vRetorno : TJSONObject;
begin
  try

    // lendo arquivos de sql
    AssignFile(f, Sistema.Path_SQL+'Smaio\Peca\peca_insert.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);

    AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\subgrupo_insert.sql');
    Reset(f);
    vSQLSG := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQLSG := vSQLSG + ' '+fLinha;
    end;
    CloseFile(f);

    AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\sgvano_insert.sql');
    Reset(f);
    vSQLSGV := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQLSGV := vSQLSGV + ' '+fLinha;
    end;
    CloseFile(f);

    vQry := TQuery.Create;
    vQry.Query.Connection.StartTransaction;
    try
      Fpec_tra_id := GeraTransacao(Fpec_usu_id);
      vQry.Query.SQL.Add(vSQL);
      vQry.Query.ParamByName('pec_descricao').AsString := Fpec_descricao;
      vQry.Query.ParamByName('pec_gru_id').AsInteger := Fpec_gru_id;
      vQry.Query.ParamByName('pec_tra_id').AsInteger := Fpec_tra_id;
      vQry.Query.Open;
      Fpec_id := vQry.Query.FieldByName('pec_ID').AsInteger;
      vRetorno := vQry.Query.ToJSONObject;

      // inicio da grava��o do subgrupo
      for vSgru in Fpec_sgrus do
      begin
        vQry.Query.SQL.Clear;
        vQry.Query.SQL.Add(vSQLSG);
        vQry.Query.ParamByName('sgru_descricao').AsString := vSgru.Fsgru_descricao;
        vQry.Query.ParamByName('sgru_pec_id').AsInteger := Fpec_id;
        vQry.Query.ParamByName('sgru_tra_id').AsInteger := Fpec_tra_id;
        vQry.Query.Execute;
        vSgru.Fsgru_id := vQry.Query.FieldByName('sgru_id').AsInteger;

        // inicio da grava��o do sgvano
        for vSgvano in vSgru.Fsgru_vanos do
        begin
          vQry.Query.SQL.Clear;
          vQry.Query.SQL.Add(vSQLSGV);
          vQry.Query.ParamByName('sgvano_sgru_id').AsInteger := vSgru.Fsgru_id;
          vQry.Query.ParamByName('sgvano_vano_id').AsInteger := vSgvano.sgvano_vano_id;
          vQry.Query.Execute;
          vSgvano.sgvano_id := vQry.Query.FieldByName('sgvano_id').AsInteger;
        end;
      end;

      vQry.Query.Connection.Commit;

      Result := vRetorno;
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

constructor TPeca.Create;
begin
  Fpec_sit_reg := true;
  Fpec_sgrus := TList<TSubGrupo>.Create;
end;

destructor TPeca.Destroy;
begin
  Fpec_sgrus.Free;
  inherited;
end;

class function TPeca.New: iPeca;
begin
   Result := Self.Create;
end;

function TPeca.pec_descricao(const Value: String): iPeca;
begin
   if not (Length(Value) > 0) then
      raise Exception.Create('Verifique a descri��o da pe�a...');

   Result := Self;
   Fpec_descricao := Value;
end;

function TPeca.pec_descricao: String;
begin
  Result := Fpec_descricao;
end;

function TPeca.pec_gru_id(const Value: integer): iPeca;
begin
   Result := Self;
   Fpec_gru_id := Value;
end;

function TPeca.pec_gru_id: integer;
begin
   Result := Fpec_gru_id;
end;

function TPeca.pec_id: integer;
begin
  Result := Fpec_id;
end;

function TPeca.pec_id(const Value: integer): iPeca;
begin
   Result := Self;
   Fpec_id := Value;
end;

function TPeca.pec_sgrus: TList<TSubGrupo>;
begin
   Result := Fpec_sgrus;
end;

function TPeca.pec_sgrus(const Value: TList<TSubGrupo>): iPeca;
begin
   Result := Self;
   Fpec_sgrus := Value;
end;

function TPeca.pec_sit_reg(const Value: boolean): iPeca;
begin
   Result := Self;
   Fpec_sit_reg := Value;
end;

function TPeca.pec_sit_reg: boolean;
begin
   Result := Fpec_sit_reg;
end;

function TPeca.pec_tra_id(const Value: integer): iPeca;
begin
   Result := Self;
   Fpec_tra_id := Value;
end;

function TPeca.pec_usu_id: integer;
begin
  Result := Fpec_usu_id;
end;

function TPeca.pec_usu_id(const Value: integer): iPeca;
begin
  Result := Self;
  Fpec_usu_id := Value;
end;

function TPeca.pec_tra_id: integer;
begin
   Result := Fpec_tra_id;
end;

function TPeca.pec_sgrus(const Value: TJSONArray): iPeca;
var
  Isgru, Isgvano : integer;
  vSgru : TSubGrupo;
  vSgvano : TSubGrupoVeiculoAno;
  vJsonSgru, vJsonSgvano : TJSONObject;
  ja: TJSONArray;
  jv: TJSONValue;
begin
    Result := Self;
    for Isgru := 0 to Value.Count -1 do
    begin
      vSgru := TSubGrupo.Create;
      vJsonSgru := Value.Items[Isgru] as TJSONObject;
      vSgru.Fsgru_id := Isgru;
      vSgru.Fsgru_descricao := vJsonSgru.Values['sgru_descricao'].Value;
      jv := vJsonSgru.Get('sgru_vanos').JsonValue;
      ja := jv as TJSONArray;
      for Isgvano := 0 to ja.Count -1 do
      begin
        vSgvano := TSubGrupoVeiculoAno.Create;
        vJsonSgvano := ja.Get(Isgvano) as TJSONObject;
        vSgvano.sgvano_id := Isgvano;
        vSgvano.sgvano_sgru_id := Isgru;
        vSgvano.sgvano_vano_id := vJsonSgvano.Values['sgvano_vano_id'].Value.ToInteger();
        vSgru.Fsgru_vanos.Add(vSgvano);
      end;
      Fpec_sgrus.Add(vSgru);
    end;
end;

end.
