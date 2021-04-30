unit  UntController.Smaio.Peca;


interface

uses
  System.SysUtils,
  Horse,
  System.Generics.Collections,
  System.JSON,
  DataSet.Serialize,
  UntController.Authorization,
  UntModel.Query,
  UntFuncoes;

  procedure registrar;

implementation

function SelectAll: TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Grupo\grupo_by_all.sql');
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

procedure Get(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectAll);
end;


procedure registrar;
begin
  THorse.Post('smaio/peca/localizar', Authorization(), Get);
end;

end.
