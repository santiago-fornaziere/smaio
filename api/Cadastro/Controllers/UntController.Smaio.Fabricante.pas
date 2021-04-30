unit UntController.Smaio.Fabricante;

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
  UntModel.Fabricante;

  procedure registrar;

  var
     campos_insert : Array of String = ['fab_nome'];
     campos_update : Array of String = ['fab_nome'];


implementation


function SelectAll: TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Fabricante\fabricante_by_all.sql');
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
      Result := TFabricante
                  .New
                    .fab_nome(pJson.Values['fab_nome'].Value)
                    .Cadastrar
    end
    else
    begin
      if not AssignFieldsApi(campos_update, pJSON) then
         exit;
      Result := TFabricante
                  .New
                    .fab_id(pID)
                    .fab_nome(pJson.Values['fab_nome'].Value)
                    .Alterar;
    end;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
end;

procedure GetbyAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectAll);
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
  THorse.Post('smaio/fabricante', Authorization(), Append);
  THorse.Put('smaio/fabricante/:id', Authorization(), Update);
  THorse.Get( 'smaio/fabricante', Authorization(), GetbyAll);
end;

end.