﻿unit UntController.Smaio.Usuario;

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

  var
     campos_insert : Array of String = ['usu_nome', 'usu_email', 'usu_telefone', 'usu_senha', 'usu_dt_ativacao', 'usu_dt_validade', 'usu_nivel'];
     campos_update : Array of String = ['usu_nome', 'usu_email', 'usu_telefone', 'usu_dt_validade', 'usu_nivel'];

implementation

uses
  UntModel.Usuario;

function SaveDB(pJSON : TJSONObject; pID : integer = 0) : TJSONObject;
var
   ja: TJSONArray;
   jv: TJSONValue;
begin
  try
    jv := pJSON.Get('usu_loj').JsonValue;
    ja := jv as TJSONArray;

    if pID = 0 then
    begin
      if not AssignFieldsApi(campos_insert, pJSON) then
         exit;
      Result := TUsuario
                  .New
                    .usu_nome(pJson.Values['usu_nome'].Value)
                    .usu_email(pJson.Values['usu_email'].Value)
                    .usu_telefone(pJson.Values['usu_telefone'].Value)
                    .usu_senha(pJson.Values['usu_senha'].Value)
                    .usu_dt_ativacao(pJson.Values['usu_dt_ativacao'].Value)
                    .usu_dt_validade(pJson.Values['usu_dt_validade'].Value)
                    .usu_nivel(pJson.Values['usu_nivel'].Value)
                    .usu_loj_id(ja)
                    .Cadastrar
    end
    else
    begin
      if not AssignFieldsApi(campos_update, pJSON) then
         exit;
      Result := TUsuario
                  .New
                    .usu_id(pID)
                    .usu_nome(pJson.Values['usu_nome'].Value)
                    .usu_email(pJson.Values['usu_email'].Value)
                    .usu_telefone(pJson.Values['usu_telefone'].Value)
                    .usu_dt_validade(pJson.Values['usu_dt_validade'].Value)
                    .usu_nivel(pJson.Values['usu_nivel'].Value)
                    .usu_sit_reg(pJson.Values['usu_sit_reg'].Value.ToBoolean)
                    .Alterar;
    end;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
end;

function SaveSenha(pJSON : TJSONObject; pID : integer = 0) : TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Usuario\usuario_update_senha.sql');
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
    vQry.Query.ParamByName('usu_id').AsInteger := pID;
    vQry.Query.ParamByName('usu_senha').AsString := pJSON.Values['usu_senha'].Value;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONObject;
  finally
    freeandnil(vQry);
  end;
end;

function SaveValidade(pJSON : TJSONObject; pID : integer = 0) : TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Usuario\usuario_update_validade.sql');
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
    vQry.Query.ParamByName('usu_id').AsInteger := pJSON.Values['usu_id'].Value.ToInteger;
    vQry.Query.ParamByName('usu_dt_validade').AsString := pJSON.Values['usu_dt_validade'].Value;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONObject;
  finally
    freeandnil(vQry);
  end;
end;

function AppendLojaDB(pJSON : TJSONObject; pID : integer = 0) : TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Usuario\usuloj_insert.sql');
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
    vQry.Query.ParamByName('uloj_usu_id').AsInteger := pID;
    vQry.Query.ParamByName('uloj_loj_id').AsString := pJSON.Values['uloj_loj_id'].Value;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONObject;
  finally
    freeandnil(vQry);
  end;
end;

function DeleteLojaDB(pID : integer = 0) : Boolean;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Usuario\usuloj_delete.sql');
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
    vQry.Query.ParamByName('uloj_id').AsInteger := pID;
    vQry.Query.Execute;
    Result := True;
  finally
    freeandnil(vQry);
  end;
end;


function SelectByLoja(pID : integer): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Usuario\usuario_by_loja.sql');
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
    vQry.Query.Params[0].AsInteger := pID;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONArray;
  finally
    FreeAndNil(vQry);
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
    Res.Send<TJSONAncestor>(SaveDB(vJSON, Req.Params.Items['id'].ToInteger)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure AppendLoja(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(AppendLojaDB(vJSON, Req.Params.Items['id'].ToInteger)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure DeleteLoja(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
    if DeleteLojaDB(Req.Params.Items['id'].ToInteger) then
       Res.Send('Registro excluído...').Status(201);
end;

procedure UpdateSenha(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(SaveSenha(vJSON, Req.Params.Items['id'].ToInteger)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure UpdateValidade(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  try
    Res.Send<TJSONAncestor>(SaveValidade(vJSON)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure GetbyLoja(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectByLoja(Req.Params.Items['id'].ToInteger));
end;

procedure registrar;
begin
  THorse.Post( 'smaio/usuario', Authorization(), Append);
  THorse.Put( 'smaio/usuario/:id', Authorization(), Update);
  THorse.Post( 'smaio/usuario/validade', Authorization(), UpdateValidade);
  THorse.Post( 'smaio/usuario/senha/:id', Authorization(), UpdateSenha);
  THorse.Get( 'smaio/usuario/loja/:id', Authorization(), GetbyLoja);
  THorse.Post( 'smaio/usuario/loja/:id', Authorization(), AppendLoja);
  THorse.Delete( 'smaio/usuario/loja/:id', Authorization(), DeleteLoja);
end;

end.
