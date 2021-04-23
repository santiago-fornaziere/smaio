﻿unit UntController.BFCall.Usuario;

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

function SelectByEmpresa: TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'BfCall\Usuario\usuario_by_nivel_empresa.sql');
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

procedure GetbyEmpresa(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectByEmpresa);
end;

procedure registrar;
begin
  THorse.Get( 'bfcall/usuario/empresa', Authorization(), GetbyEmpresa);
//  THorse.Get( 'usuario/cliente', Authorization(), GetbyEmpresa);
end;

end.