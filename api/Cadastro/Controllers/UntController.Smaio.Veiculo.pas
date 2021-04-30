unit UntController.Smaio.Veiculo;

interface

uses
  System.SysUtils,
  Vcl.Dialogs,
  UntFuncoes,
  System.Generics.Collections,
  System.JSON,
  DataSet.Serialize,
  Horse,
  UntController.Authorization,
  UntModel.Query,
  UntModel.Veiculo;

  procedure registrar;

  var
     campos_insert : Array of String = ['vei_descricao', 'vei_fab_id'];
     campos_update : Array of String = ['vei_descricao', 'vei_fab_id', 'vei_sit_reg'];


implementation


function SelectByFabricante(pID: integer): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Veiculo\veiculo_by_fabricante.sql');
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
    vQry.Query.ParamByName('vei_fab_id').AsInteger := pID;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  finally
    FreeAndNil(vQry);
  end;
end;

function SaveDB(pJSON : TJSONObject; pID : integer = 0) : TJSONObject;
begin
  Result := TJSONObject.Create;
  try
    if pID = 0 then
    begin
      if not AssignFieldsApi(campos_insert, pJSON) then
         exit;
      Result := TVeiculo
                  .New
                    .vei_descricao(pJson.Values['vei_descricao'].Value)
                    .vei_fab_id(pJson.Values['vei_fab_id'].Value.ToInteger())
                    .Cadastrar
    end
    else
    begin
      if not AssignFieldsApi(campos_update, pJSON) then
         exit;
      Result := TVeiculo
                  .New
                    .vei_id(pID)
                    .vei_descricao(pJson.Values['vei_descricao'].Value)
                    .vei_fab_id(pJson.Values['vei_fab_id'].Value.ToInteger())
                    .vei_sit_reg(pJson.Values['vei_sit_reg'].Value.ToBoolean)
                    .Alterar;
    end;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
end;

procedure GetbyFabricante(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectByFabricante(Req.Params.Items['id'].ToInteger));
end;

procedure Append(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(SaveDB(vJSON)).Status(201);
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
    Res.Send<TJSONAncestor>(SaveDB(vJSON, Req.Params.Items['id'].ToInteger)).Status(202);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure registrar;
begin
  THorse.Post('smaio/veiculo', Authorization(), Append);
  THorse.Put('smaio/veiculo/:id', Authorization(), Update);
  THorse.Get( 'smaio/veiculo/fabricante/:id', Authorization(), GetbyFabricante);
end;

end.