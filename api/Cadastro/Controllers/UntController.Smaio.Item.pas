unit UntController.Smaio.Item;

interface

uses
  System.SysUtils,
  Horse,
  System.Generics.Collections,
  System.JSON,
  DataSet.Serialize,
  UntController.Authorization,
  UntModel.Query,
  UntFuncoes,
  UntModel.Claims, UntModel.Item;

  procedure registrar;

  var
     campos_insert : Array of String = ['ite_descricao', 'ite_sgvano_id', 'ite_valor', 'ite_situacao', 'ite_loj_id', 'ite_tra_entrada'];
     campos_update : Array of String = ['ite_id', 'ite_descricao', 'ite_sgvano_id', 'ite_valor', 'ite_situacao', 'ite_status', 'ite_loj_id', 'ite_tra_saida', 'ite_sit_reg'];


implementation

function SaveDB(pJSON : TJSONObject; pUsuario : integer; pID : integer = 0) : TJSONObject;
begin
  Result := TJSONObject.Create;
  try

    if pID = 0 then
    begin
      if not AssignFieldsApi(campos_insert, pJSON) then
         exit;
      Result := TItem
                  .New
                    .ite_descricao(pJson.Values['ite_descricao'].Value)
                    .ite_sgvano_id(pJson.Values['ite_sgvano_id'].Value.ToInteger())
                    .ite_valor(pJson.Values['ite_valor'].Value.ToDouble())
                    .ite_situacao(pJson.Values['ite_situacao'].Value)
                    .ite_loj_id(pJson.Values['ite_loj_id'].Value.ToInteger())
                    .ite_usu_id(pUsuario)
                    .Cadastrar
    end
    else
    begin
      if not AssignFieldsApi(campos_update, pJSON) then
         exit;
      Result := TItem
                  .New
                    .ite_id(pID)
                    .ite_usu_id(pUsuario)
                    .ite_descricao(pJson.Values['ite_descricao'].Value)
                    .ite_sgvano_id(pJson.Values['ite_sgvano_id'].Value.ToInteger())
                    .ite_valor(pJson.Values['ite_valor'].Value.ToDouble())
                    .ite_situacao(pJson.Values['ite_situacao'].Value)
                    .ite_status(pJson.Values['ite_status'].Value)
                    .ite_loj_id(pJson.Values['ite_loj_id'].Value.ToInteger())
                    .ite_sit_reg(pJson.Values['ite_sit_reg'].Value.ToBoolean())
                    .Alterar;
    end;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
end;

function Select(pJson : TJSONObject): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Item\item_by_where.sql');
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
    vQry.Query.AddWhere(pJson.Values['where'].Value);
    vQry.Query.SetOrderBy(pJson.Values['orderby'].Value);
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  finally
    FreeAndNil(vQry);
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

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
   LClaims: TClaims;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  LClaims := Req.Session<TClaims>;
  try
    Res.Send<TJSONAncestor>(SaveDB(vJSON, LClaims.UsuarioID.ToInteger, Req.Params.Items['id'].ToInteger)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure GetLocalizar(Req: THorseRequest; Res: THorseResponse; Next: TProc);
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

procedure registrar;
begin
  THorse.Post('smaio/item', AuthorizationClaim(), Append);
  THorse.Put('smaio/item/:id', AuthorizationClaim(), Update);
  THorse.Post('smaio/item/localizar', Authorization(), GetLocalizar);
end;

end.
