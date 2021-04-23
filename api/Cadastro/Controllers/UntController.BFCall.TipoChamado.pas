unit UntController.BFCall.TipoChamado;

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
  UntModel.Query;

  procedure registrar;


implementation



function SelectAll: TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  AssignFile(f, Sistema.Path_SQL+'BfCall\TipoChamado\TipoChamado.sql');
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

procedure GetAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectAll);
end;

procedure registrar;
begin
  THorse.Get( '/bfcall/tipochamado', Authorization(), GetAll);
end;

end.
