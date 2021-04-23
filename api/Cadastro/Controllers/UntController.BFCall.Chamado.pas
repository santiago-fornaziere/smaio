unit UntController.BFCall.Chamado;

interface

uses
  System.SysUtils,
  Vcl.Dialogs,
  UntFuncoes,
  System.Generics.Collections,
  System.JSON,
  DataSet.Serialize,
  Horse,
  UntController.Authorization;

  procedure registrar;

implementation

uses
  UntModel.Query;

function SelectByID(pID: integer): TJsonobject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'BfCall\Chamado\Chamado_by_ID.sql');
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
    Result := vQry.Query.ToJSONObject;
  finally
    FreeAndNil(vQry);
  end;
end;

function SelectAberto: TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'BfCall\Chamado\chamado_by_aberto.sql');
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
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  finally
    FreeAndNil(vQry);
  end;
end;

procedure GetByID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectByID(Req.Params.Items['id'].ToInteger));
end;

procedure GetAberto(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectAberto);
end;

function SelectParamByID(pID: integer; pTipo: String): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
     if pTipo = 'C' then
        AssignFile(f, Sistema.Path_SQL+'BfCall\Chamado\Chamado_by_cliente_id.sql')
     else
     if pTipo = 'U' then
        AssignFile(f, Sistema.Path_SQL+'BfCall\Chamado\Chamado_by_usuario_id.sql');

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
  finally
    FreeAndNil(vQry);
  end;end;

procedure GetByClienteID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectParamByID(Req.Params.Items['id'].ToInteger, 'C'));
end;

procedure GetByUsuarioID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectParamByID(Req.Params.Items['id'].ToInteger, 'U'));
end;

function SelectAll: TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'BfCall\chamado\Chamado_by_all.sql');
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
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  finally
    FreeAndNil(vQry);
  end;
end;

procedure GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectAll);
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
      AssignFile(f, Sistema.Path_SQL+'BfCall\chamado\Chamado_insert.sql')
    else
      AssignFile(f, Sistema.Path_SQL+'BfCall\chamado\Chamado_update.sql');

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
  try
    vJSON := TJSONObject.Create;
    vJSON := Req.Body<TJSONObject>;
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
  THorse.Get( '/bfcall/chamado/:id', Authorization(), GetByID);
  THorse.Get( '/bfcall/chamado/cliente/:id', Authorization(), GetByClienteID);
  THorse.Get( '/bfcall/chamado/usuario/:id', Authorization(), GetByUsuarioID);
  THorse.Get( '/bfcall/chamadoaberto', Authorization(), GetAberto);
  THorse.Get( '/bfcall/chamado', Authorization(), GetAll);
  THorse.Post('/bfcall/chamado', Authorization(), Append);
  THorse.Post('/bfcall/chamado/:id', Authorization(), Update);
end;

end.
