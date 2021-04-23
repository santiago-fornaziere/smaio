﻿unit UntController.BFCall.ChamadoAnexo;

interface

uses
  System.SysUtils,
  Vcl.Dialogs,
  UntFuncoes,
  System.Generics.Collections,
  System.JSON,
  DataSet.Serialize,
  System.Classes,
  Horse,
  Horse.JWT,
  UntModel.Claims,
  UntController.Authorization,
  UntModel.Query;

  procedure registrar;

implementation

function SelectByID(pID: integer): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'BfCall\Chamado_anexo\chamado_anexo_by_ID.sql');
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
  end;
end;


procedure GetByChamID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectByID(Req.Params.Items['id'].ToInteger));
end;

procedure Insert(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LStream: TMemoryStream;
  vNome, vNomePath: String;
  vChamado : integer;
  LClaims: TClaims;
  vQry : TQuery;
  vSQL, fLinha : String;
  f : TextFile;
begin
  try
    LClaims := Req.Session<TClaims>;
    vNome :=StringReplace(FloatToStr(now()), ',','', [])+Req.Params.Items['nome'];
    vNomePath := Sistema.Path_Anexo+vNome;
    vChamado := Req.Params.Items['chamado'].ToInteger;
    LStream:= Req.Body<TMemoryStream>;
    LStream.SaveToFile(vNomePath);

    AssignFile(f, Sistema.Path_SQL+'BfCall\chamado_anexo\chamado_anexo_insert.sql');
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
    vQry.Query.Params[0].AsString  := vNomePath;
    vQry.Query.Params[1].AsString := LClaims.UsuarioID;
    vQry.Query.Params[2].AsInteger := vChamado;
    vQry.Query.Params[3].AsString := vNome;
    vQry.Query.Execute;

    Res.Send('Imagem cadastrada com sucesso...').Status(201);
  finally
    FreeAndNil(vQry);
  end;
end;

procedure GetArquivo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
  LStream: TFileStream;
  vFile : String;
  vQry : TQuery;
  f : TextFile;
  vSQL, fLinha : String;
begin
    AssignFile(f, Sistema.Path_SQL+'BfCall\chamado_anexo\chamado_anexo_download_by_ID.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + fLinha;
    end;
    vQry := TQuery.Create;
    vQry.Query.SQL.Add(StringReplace(vSQL, 'ï»¿﻿','',[]));
    vQry.Query.Params[0].AsInteger  := Req.Params.Items['id'].ToInteger;
    vQry.Query.Open;

    if not vQry.Query.IsEmpty then
    begin
       try
         vFile := vQry.Query.FieldByName('cham_anex_ARQUIVO').AsString;
         LStream := TFileStream.Create(vFile, fmOpenRead);
         Res.Send<TStream>(LStream).Status(200);
       finally
         Freeandnil(vQry);
       end;
    end else
        Res.Send('Arquivo não disponível...').Status(400);

end;

procedure registrar;
begin
  THorse.Get( '/bfcall/chamadoanexo/:id', Authorization(), GetByChamID);
  THorse.Get( '/bfcall/chamadoanexo/download/:id', GetArquivo);
  THorse.Post('/bfcall/chamadoanexo/:nome/:chamado', HorseJWT('key', TClaims), Insert);
end;


end.
