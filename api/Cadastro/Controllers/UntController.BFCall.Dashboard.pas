unit UntController.BFCall.Dashboard;

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

function Select(pID: integer; pARquivo: String): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  AssignFile(f, Sistema.Path_SQL+pArquivo);
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


procedure GetStatusID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(Select(Req.Params.Items['id'].ToInteger, 'BfCall\dashboard\dashboard_chamado_status.sql'));
end;

procedure GetTipoID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(Select(Req.Params.Items['id'].ToInteger, 'BfCall\dashboard\dashboard_chamado_tipo.sql'));
end;

procedure registrar;
begin
  THorse.Get( '/bfcall/dashboard/status/:id', Authorization(), GetStatusID);
  THorse.Get( '/bfcall/dashboard/tipo/:id', Authorization(), GetTipoID);
end;

end.
