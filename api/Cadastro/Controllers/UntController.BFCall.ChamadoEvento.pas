﻿unit UntController.BFCall.ChamadoEvento;

interface

uses
  System.SysUtils,
  Vcl.Dialogs,
  UntFuncoes,
  System.Generics.Collections,
  System.JSON,
  DataSet.Serialize,
  Horse,
  UntController.Authorization, UntModel.Query;

  procedure registrar;

implementation

function SelectByChamadoID(pID: integer): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  AssignFile(f, Sistema.Path_SQL+'BfCall\ChamadoEvento\Chamado_evento_by_ID.sql');
  Reset(f);
  vSQL := '';
  While not Eof(f) do
  begin
    Readln(f, fLinha);
    vSQL := vSQL + fLinha;
  end;
  CloseFile(f);
  vQry := TQuery.Create;
  vQry.Query.SQL.Add(StringReplace(vSQL, 'ï»¿﻿','',[]));
  vQry.Query.Params[0].AsInteger := pID;
  vQry.Query.Open;
  Result := vQry.Query.ToJSONArray;
end;

procedure GetByChamadoID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectByChamadoID(Req.Params.Items['id'].ToInteger));
end;

function SaveDB(pJSON : TJSONObject; pID : integer = 0) : TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
   I : integer;
begin
  try
    if pID = 0 then
      AssignFile(f, Sistema.Path_SQL+'BfCall\ChamadoEvento\Chamado_evento_insert.sql')
    else
      AssignFile(f, Sistema.Path_SQL+'BfCall\ChamadoEvento\Chamado_evento_update.sql');

    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);

    vQry := TQuery.Create;
    vQry.Query.SQL.Add(StringReplace(vSQL, 'ï»¿﻿','',[]));

    for I := 0 to pJson.Count -1 do
    begin
      try
      if Assigned(pJSON.Values[vQry.Query.Params[I].Name]) then
        if not (LowerCase(pJSON.Values[vQry.Query.Params[I].Name].Value) = 'null') then
          vQry.Query.Params[I].Value := pJSON.Values[vQry.Query.Params[I].Name].Value;
      except
      end;
    end;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONObject;
  finally
    freeandnil(vQry);
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

procedure Update(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(SaveDB(vJSON, Req.Params.Items['id'].ToInteger)).Status(202);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure registrar;
begin
  THorse.Get( '/bfcall/chamadoevento/:id', Authorization(), GetByChamadoID);
  THorse.Post('/bfcall/chamadoevento', Authorization(), Append);
  THorse.Post('/bfcall/chamadoevento/:id', Authorization(), Update);
end;

end.