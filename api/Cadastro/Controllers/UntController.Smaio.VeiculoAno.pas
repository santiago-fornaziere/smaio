unit UntController.Smaio.VeiculoAno;

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
  UntModel.VeiculoAno;

  procedure registrar;

  var
     campos_insert : Array of String = ['vano_vei_id', 'vano_ano_id'];
     campos_update : Array of String = [];
     campos_where : Array of String = ['where', 'orderby'];



implementation

function SaveDB(pJSON : TJSONObject; pID : integer = 0) : TJSONObject;
begin
  Result := TJSONObject.Create;
  try
    if pID = 0 then
    begin
      if not AssignFieldsApi(campos_insert, pJSON) then
         exit;
      Result := TVeiculoAno
                  .New
                    .vano_vei_id(pJson.Values['vano_vei_id'].Value.ToInteger())
                    .vano_ano_id(pJson.Values['vano_ano_id'].Value.ToInteger())
                    .Cadastrar
    end;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
end;

function DeleteDB(pID : integer = 0) : Boolean;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\VeiculoAno\veiano_delete.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.SQL.Add(vSQL);
    vQry.Query.ParamByName('vano_id').AsInteger := pID;
    vQry.Query.Execute;
    Result := True;
  finally
    freeandnil(vQry);
  end;
end;

function SelectDB(pJSON : TJSONObject) : TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    if not AssignFieldsApi(campos_where, pJSON) then
       exit;

    AssignFile(f, Sistema.Path_SQL+'Smaio\VeiculoAno\veiano_select.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.SQL.Add(vSQL);
    vQry.Query.AddWhere(pJSON.Values['where'].Value);
    vQry.Query.SetOrderBy(pJSON.Values['orderby'].Value);
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
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

procedure Delete(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
    if DeleteDB(Req.Params.Items['id'].ToInteger) then
       Res.Send('Registro exclu�do...').Status(201);
end;

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(SelectDB(vJSON)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure registrar;
begin
  THorse.Post('smaio/veiano', Authorization(), Append);
  THorse.Delete('smaio/veiano/:id', Authorization(), Delete);
  THorse.Post( 'smaio/veiano/localizar', Authorization(), Get);
end;

end.