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
     campos_insert_subgrupo : Array of String = ['sgru_descricao', 'sgru_pec_id'];
     campos_insert_subgruveiano : Array of String = ['sgvano_sgru_id', 'sgvano_vano_id'];
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

function SaveSubGrupoDB(pJSON : TJSONObject; pUsuario : integer = 0; pID : integer = 0) : TJSONObject;
begin
  Result := TJSONObject.Create;
  try
    if pID = 0 then
    begin
      if not AssignFieldsApi(campos_insert_subgrupo, pJSON) then
         exit;
      Result := TSubGrupo
                  .New
                    .sgru_descricao(pJson.Values['sgru_descricao'].Value)
                    .sgru_pec_id(pJson.Values['sgru_pec_id'].Value.ToInteger())
                    .sgru_sit_reg(pJson.Values['sgru_sit_reg'].Value.ToBoolean())
                    .sgru_usu_id(pUsuario)
                    .Cadastrar;
    end else
    begin
      if not AssignFieldsApi(campos_update_subgrupo, pJSON) then
         exit;
      Result := TSubGrupo
                  .New
                    .sgru_id(pID)
                    .sgru_descricao(pJson.Values['sgru_descricao'].Value)
                    .sgru_pec_id(pJson.Values['sgru_pec_id'].Value.ToInteger())
                    .sgru_sit_reg(pJson.Values['sgru_sit_reg'].Value.ToBoolean())
                    .Alterar;
    end;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
end;

function SaveSGVano(pJSON : TJSONObject) : TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  Result := TJSONObject.Create;
  try
    if not AssignFieldsApi(campos_insert_subgruveiano, pJSON) then
       exit;
    AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\sgvano_insert.sql');
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
    vQry.Query.SQL.Add(vSQL);
    vQry.Query.ParamByName('sgvano_sgru_id').AsString := pJSON.Values['sgvano_sgru_id'].Value;
    vQry.Query.ParamByName('sgvano_vano_id').AsString := pJSON.Values['sgvano_vano_id'].Value;
    vQry.Query.Open;
    vQry.Query.Connection.Commit;

    Result := vQry.Query.ToJSONObject;
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

function SelectSGVanoWhere(pJSON : TJSONObject): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\sgvano_by_veiano.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL +' '+ fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.SQL.Add(vSQL);
    vQry.Query.DeleteWhere;
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

function SelectSubGrupoLocalizar(pJson : TJSONObject): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\subgrupo_by_grupo_and_veiano.sql');
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
    vQry.Query.DeleteWhere;
    vQry.Query.AddWhere(pJson.Values['where'].Value);
    vQry.Query.SetOrderBy(pJson.Values['orderby'].Value);
    vQry.Query.ParamByName('sgvano_vano_id').AsString := pJson.Values['sgvano_vano_id'].Value;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  finally
    FreeAndNil(vQry);
  end;
end;

function SelectSGVano(pID : integer; pTipo : String = 'SG'): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    if pTipo = 'SG' then
    begin
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
    end else
    if pTipo = 'VA' then
    begin
      AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\sgvano_by_veiano.sql');
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
    end else
    if pTipo = 'GR' then
    begin
      AssignFile(f, Sistema.Path_SQL+'Smaio\SubGrupo\subgrupo_by_grupo.sql');
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
    end;
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

procedure AppendSubGrupo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
   LClaims: TClaims;
begin
vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  LClaims := Req.Session<TClaims>;
  try
    Res.Send<TJSONAncestor>(SaveSubGrupoDB(vJSON, LClaims.UsuarioID.ToInteger)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure AppendSGVano(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(SaveSGVano(vJSON)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure GetSubGrupoLocalizar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(SelectSubGrupoLocalizar(vJSON)).Status(201);
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
    Res.Send<TJSONAncestor>(SaveSubGrupoDB(vJSON, 0, Req.Params.Items['id'].ToInteger)).Status(202);
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

procedure GetSGVanoSG(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectSGVano(Req.Params.Items['id'].ToInteger, 'SG'));
end;

procedure GetSGVanoVA(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectSGVano(Req.Params.Items['id'].ToInteger, 'VA'));
end;

procedure GetSGVanoGR(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectSGVano(Req.Params.Items['id'].ToInteger, 'GR'));
end;

procedure GetSGVano(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(SelectSGVanoWhere(vJSON)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure registrar;
begin
  THorse.Post('smaio/peca', AuthorizationClaim(), Append);
  THorse.Put('smaio/peca/:id', Authorization(), Update);
  THorse.Post('smaio/peca/localizar', Authorization(), Get);
  THorse.Delete('smaio/peca/sgvano/:id', Authorization(), DeleteSGVano);
  THorse.Post('smaio/peca/sgvano', Authorization(), AppendSGVano);
  THorse.Post('smaio/peca/sgvano/localizar', Authorization(), GetSGVano);
  THorse.Put('smaio/peca/subgrupo/:id', Authorization(), UpdateSubgrupo);
  THorse.Get('smaio/peca/subgrupo/:id', Authorization(), GetSubgrupo);
  THorse.Get('smaio/peca/sgvano/subgrupo/:id', Authorization(), GetSGVanoSG);
  THorse.Get('smaio/peca/sgvano/veiano/:id', Authorization(), GetSGVanoVA);
  THorse.Get('smaio/peca/subgrupo/grupo/:id', Authorization(), GetSGVanoGR);
  THorse.Post('smaio/peca/subgrupo/localizar', Authorization(), GetSubGrupoLocalizar);
  THorse.Post('smaio/peca/subgrupo', AuthorizationClaim(), AppendSubGrupo);
end;

end.
