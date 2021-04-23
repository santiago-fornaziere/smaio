unit UntController.Safra;

interface

uses
  System.SysUtils,
  Vcl.Dialogs,
  UntFuncoes,
  System.Generics.Collections,
  System.JSON,
  DataSet.Serialize,
  Horse,
  UntModel.Safra,
  UntController.Authorization,
  UntModel.Query;

  function QrySafraToClasse(pQry: TQuery): TList<TSafra>;
  procedure registrar;

implementation


function SelectByID(pID: integer): TJsonobject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  AssignFile(f, Sistema.Path_SQL+'Safra\Safra_by_ID.sql');
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
end;

function SelectAll: TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  AssignFile(f, Sistema.Path_SQL+'Safra\Safra.sql');
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
end;

function QrySafraToClasse(pQry : TQuery) : TList<TSafra>;
var
   vSafra : TSafra;
   vSafras : TList<TSafra>;
begin
     vSafra := TSafra.Create;
     vSafras := TList<TSafra>.Create;
     pQry.Query.First;
     while not pQry.Query.Eof do
     begin
       vSafra.safID := pQry.Query.FieldByName('saf_ID').AsInteger;
       vSafra.safDescricao := pQry.Query.FieldByName('saf_DESCRICAO').AsString;
       vSafra.safDtInicPlantio := pQry.Query.FieldByName('saf_DT_INIC_PLANTIO').AsDateTime;
       vSafra.safDtInicColheita := pQry.Query.FieldByName('saf_DT_INIC_COLHEITA').AsDateTime;
       vSafra.safDtFinalColheita := pQry.Query.FieldByName('saf_DT_FINAL_COLHEITA').AsDateTime;
       vSafra.safSitRegId := pQry.Query.FieldByName('saf_SIT_REG_ID').AsInteger;
       vSafras.Add(vSafra);
       pQry.Query.Next;
     end;
     Result := vSafras;
end;

procedure GetByID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectByID(Req.Params.Items['id'].ToInteger));
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
begin
  if pID = 0 then
    AssignFile(f, Sistema.Path_SQL+'Safra\Safra_insert.sql')
  else
    AssignFile(f, Sistema.Path_SQL+'Safra\Safra_update.sql');

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
  vQry.Query.Params[0].AsString := pJSON.Values['safDescricao'].Value;
  vQry.Query.Params[1].AsDateTime :=  JSONDateToDatetime(pJSON.Values['safDtInicPlantio'].Value);
  vQry.Query.Params[2].AsDateTime := JSONDateToDatetime(pJSON.Values['safDtInicColheita'].Value);
  vQry.Query.Params[3].AsDateTime := JSONDateToDatetime(pJSON.Values['safDtFinalColheita'].Value);
  vQry.Query.Params[4].AsInteger := StrToInt(pJSON.Values['safSitRegId'].Value);
  if not (pID = 0) then
    vQry.Query.Params[5].AsInteger := pID;
  vQry.Query.Open;
  Result := vQry.Query.ToJSONObject;
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
  THorse.Get('/safra/:id', Authorization(), GetByID);
  THorse.Get('/safra', Authorization(), GetAll);
  THorse.Post('/safra', Authorization(), Append);
  THorse.Post('/safra/:id', Authorization(), Update);
end;

end.
