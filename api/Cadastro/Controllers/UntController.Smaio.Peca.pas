unit  UntController.Smaio.Peca;


interface

uses
  System.SysUtils,
  Horse,
  System.Generics.Collections,
  System.JSON,
  DataSet.Serialize,
  UntController.Authorization,
  UntModel.Query,
  UntModel.Peca,
  UntFuncoes, UntModel.SubGrupo;

  procedure registrar;

    var
     campos_insert : Array of String = ['pec_descricao', 'pec_gru_id'];
     campos_update : Array of String = ['pec_descricao', 'pec_gru_id', 'pec_sit_reg'];
     campos_update_subgrupo : Array of String = ['sgru_descricao', 'sgru_pec_id', 'sgru_sit_reg'];

implementation

uses
  UntModel.Claims;

function SaveDB(pJSON : TJSONObject; pUsuario : integer; pID : integer = 0) : TJSONObject;
var
   ja: TJSONArray;
   jv: TJSONValue;
begin
  Result := TJSONObject.Create;
  try

    if pID = 0 then
    begin
      jv := pJSON.Get('pec_sgrus').JsonValue;
      ja := jv as TJSONArray;

      if not AssignFieldsApi(campos_insert, pJSON) then
         exit;
      Result := TPeca
                  .New
                    .pec_descricao(pJson.Values['pec_descricao'].Value)
                    .pec_gru_id(pJson.Values['pec_gru_id'].Value.ToInteger())
                    .pec_usu_id(pUsuario)
                    .pec_sgrus(ja)
                    .Cadastrar
    end
    else
    begin
      if not AssignFieldsApi(campos_update, pJSON) then
         exit;
      Result := TPeca
                  .New
                    .pec_id(pID)
                    .pec_descricao(pJson.Values['pec_descricao'].Value)
                    .pec_gru_id(pJson.Values['pec_gru_id'].Value.ToInteger())
                    .pec_sit_reg(pJson.Values['pec_sit_reg'].Value.ToBoolean())
                    .Alterar;
    end;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
end;

function SaveSubGrupoDB(pJSON : TJSONObject; pID : integer = 0) : TJSONObject;
var
   ja: TJSONArray;
   jv: TJSONValue;
begin
  Result := TJSONObject.Create;
  try
    if not AssignFieldsApi(campos_update_subgrupo, pJSON) then
       exit;
    Result := TSubGrupo
                .New
                  .sgru_id(pID)
                  .sgru_descricao(pJson.Values['sgru_descricao'].Value)
                  .sgru_pec_id(pJson.Values['sgru_pec_id'].Value.ToInteger())
                  .sgru_sit_reg(pJson.Values['sgru_sit_reg'].Value.ToBoolean())
                  .Alterar;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
end;

function Select(pJSON : TJSONObject): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Peca\peca_select.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.SQL.Add(vSQL);
    vQry.Query.AddWhere(pJSON.Values['where'].Value);
    vQry.Query.SetOrderBy(pJSON.Values['orderby'].Value);
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  finally
    FreeAndNil(vQry);
  end;
end;

function SelectSubGrupo(pID : integer): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\subgrupo_by_peca.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.SQL.Add(vSQL);
    vQry.Query.Params[0].AsInteger := pID;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  finally
    FreeAndNil(vQry);
  end;
end;

function SelectSGVano(pID : integer): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\sgvano_by_subgrupo.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.SQL.Add(vSQL);
    vQry.Query.Params[0].AsInteger := pID;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  finally
    FreeAndNil(vQry);
  end;
end;

function DeleteSGVanoDB(pID : integer = 0) : Boolean;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    // lendo arquivos de sql
    AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\sgvano_delete.sql');
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
      vQry.Query.ParamByName('sgvano_id').AsInteger := pID;
      vQry.Query.Execute;
      vQry.Query.Connection.Commit;

      Result := True;
    except
      on E : Exception do
      begin
        Result := False;
        vQry.Query.Connection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    freeandnil(vQry);
  end;
end;

procedure Append(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
   LClaims: TClaims;
begin
vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  LClaims := Req.Session<TClaims>;
  try
    Res.Send<TJSONAncestor>(SaveDB(vJSON, LClaims.UsuarioID.ToInteger)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(Select(vJSON)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  try
    vJSON := TJSONObject.Create;
    vJSON := Req.Body<TJSONObject>;
    Res.Send<TJSONAncestor>(SaveDB(vJSON, 0, Req.Params.Items['id'].ToInteger)).Status(202);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure UpdateSubgrupo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  try
    vJSON := TJSONObject.Create;
    vJSON := Req.Body<TJSONObject>;
    Res.Send<TJSONAncestor>(SaveSubGrupoDB(vJSON, Req.Params.Items['id'].ToInteger)).Status(202);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure DeleteSGVano(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
    if DeleteSGVanoDB(Req.Params.Items['id'].ToInteger) then
       Res.Send('Registro exclu�do...').Status(201);
end;

procedure GetSubgrupo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectSubGrupo(Req.Params.Items['id'].ToInteger));
end;

procedure GetSGVano(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectSGVano(Req.Params.Items['id'].ToInteger));
end;

procedure registrar;
begin
  THorse.Post('smaio/peca', AuthorizationClaim(), Append);
  THorse.Put('smaio/peca/:id', Authorization(), Update);
  THorse.Post('smaio/peca/localizar', Authorization(), Get);
  THorse.Delete('smaio/peca/sgvano/:id', Authorization(), DeleteSGVano);
  THorse.Put('smaio/peca/subgrupo/:id', Authorization(), UpdateSubgrupo);
  THorse.Get('smaio/peca/subgrupo/:id', Authorization(), GetSubgrupo);
  THorse.Get('smaio/peca/sgvano/:id', Authorization(), GetSGVano);
end;

end.
