﻿unit UntController.Login;

interface

uses
  System.JSON,
  DataSet.Serialize,
  UntFuncoes,
  System.SysUtils;

  function ConsultaLogin(pUser: TJSONObject): TJSONObject;

implementation

uses
  UntModel.Query, UntErros;

function ConsultaLogin(pUser: TJSONObject): TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  AssignFile(f, Sistema.Path_SQL+'Smaio\Usuario\usuario_by_login_senha.sql');
  Reset(f);
  vSQL := '';
  While not Eof(f) do
  begin
    Readln(f, fLinha);
    vSQL := vSQL + fLinha;
  end;
  CloseFile(f);
  try
    vQry := TQuery.Create;
    vQry.Query.SQL.Add(vSQL);
    vQry.Query.Params[0].AsString := pUser.GetValue('email').Value;
    vQry.Query.Params[1].AsString := pUser.GetValue('senha').Value;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONObject
  finally
    FreeAndNil(vQry);
  end;
end;

end.
