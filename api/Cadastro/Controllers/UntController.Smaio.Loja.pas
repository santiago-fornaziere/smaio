﻿unit UntController.Smaio.Loja;

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
  UntModel.Query,
  UntModel.Loja;

  procedure registrar;

  var
     campos_insert : Array of String = ['loj_nome', 'loj_ativacao', 'loj_cnpj', 'loj_email', 'loj_telefone_1', 'loj_telefone_2', 'loj_cep', 'loj_logradouro', 'loj_numero', 'loj_bairro', 'loj_cid_id', 'loj_latitude', 'loj_longitude'];
     campos_update : Array of String = ['loj_nome', 'loj_cnpj', 'loj_email', 'loj_telefone_1', 'loj_telefone_2', 'loj_cep', 'loj_logradouro', 'loj_numero', 'loj_bairro', 'loj_cid_id', 'loj_status', 'loj_latitude', 'loj_longitude', 'loj_dt_validade', 'loj_ativacao', 'loj_sit_reg'];


implementation

uses
  UntModel.Claims;

function SelectLoja(pID : integer): TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Loja\loja_by_usuario.sql');
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

function SelectAll: TJSONArray;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Loja\loja_by_all.sql');
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

function SaveDB(pJSON : TJSONObject; pUsuario : integer; pID : integer = 0) : TJSONObject;

begin
  Result := TJSONObject.Create;
  try
    if pID = 0 then
    begin
      if not AssignFieldsApi(campos_insert, pJSON) then
         exit;
      Result := TLoja
                  .New
                    .loj_nome(pJson.Values['loj_nome'].Value)
                    .loj_ativacao(pJson.Values['loj_ativacao'].Value)
                    .loj_cnpj(pJson.Values['loj_cnpj'].Value)
                    .loj_email(pJson.Values['loj_email'].Value)
                    .loj_telefone_1(pJson.Values['loj_telefone_1'].Value)
                    .loj_telefone_2(pJson.Values['loj_telefone_2'].Value)
                    .loj_cep(pJson.Values['loj_cep'].Value)
                    .loj_logradouro(pJson.Values['loj_logradouro'].Value)
                    .loj_numero(pJson.Values['loj_numero'].Value)
                    .loj_bairro(pJson.Values['loj_bairro'].Value)
                    .loj_cid_id(pJson.Values['loj_cid_id'].Value.ToInteger())
                    .loj_latitude(pJson.Values['loj_latitude'].Value)
                    .loj_longitude(pJson.Values['loj_longitude'].Value)
                    .loj_usu_id(pUsuario)
                    .Cadastrar
    end
    else
    begin
      if not AssignFieldsApi(campos_update, pJSON) then
         exit;
      Result := TLoja
                  .New
                    .loj_id(pID)
                    .loj_nome(pJson.Values['loj_nome'].Value)
                    .loj_ativacao(pJson.Values['loj_ativacao'].Value)
                    .loj_dt_validade(pJson.Values['loj_dt_validade'].Value)
                    .loj_cnpj(pJson.Values['loj_cnpj'].Value)
                    .loj_email(pJson.Values['loj_email'].Value)
                    .loj_telefone_1(pJson.Values['loj_telefone_1'].Value)
                    .loj_telefone_2(pJson.Values['loj_telefone_2'].Value)
                    .loj_cep(pJson.Values['loj_cep'].Value)
                    .loj_logradouro(pJson.Values['loj_logradouro'].Value)
                    .loj_numero(pJson.Values['loj_numero'].Value)
                    .loj_bairro(pJson.Values['loj_bairro'].Value)
                    .loj_cid_id(pJson.Values['loj_cid_id'].Value.ToInteger)
                    .loj_status(pJson.Values['loj_status'].Value)
                    .loj_latitude(pJson.Values['loj_latitude'].Value)
                    .loj_longitude(pJson.Values['loj_longitude'].Value)
                    .loj_sit_reg(pJson.Values['loj_sit_reg'].Value.ToBoolean)
                    .Alterar;
    end;
  except
    on E: Exception do
    begin
         raise Exception.Create(E.message);
    end;
  end;
end;

function UpdateStatus(pID: integer; pTipo: String) : TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Loja\loja_update_status.sql');
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
    if pTipo = 'I' then
       vQry.Query.ParamByName('loj_status').AsString := 'Inativo'
    else
    if pTipo = 'S' then
       vQry.Query.ParamByName('loj_status').AsString := 'Suspenso'
    else
       vQry.Query.ParamByName('loj_status').AsString := 'Ativo';
    vQry.Query.ParamByName('loj_id').AsInteger := pID;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONObject;
  finally
    freeandnil(vQry);
  end;
end;

function UpdateValidade(pJSON : TJSONObject): TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Loja\loja_update_validade.sql');
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
    vQry.Query.ParamByName('loj_dt_validade').Value := pJSON.Values['loj_dt_validade'].Value;
    vQry.Query.ParamByName('loj_id').AsInteger := pJSON.Values['loj_id'].Value.ToInteger;
    vQry.Query.Open;
    Result := vQry.Query.ToJSONObject;
  finally
    freeandnil(vQry);
  end;
end;

procedure GetbyUsuario(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectLoja(Req.Params.Items['id'].ToInteger));
end;

procedure GetbyAll(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(SelectAll);
end;

procedure Append(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
   LClaims: TClaims;
begin
  vJSON := TJSONObject.Create;
  vJSON := Req.Body<TJSONObject>;
  LClaims := Req.Session<TClaims>;
  try
    Res.Send<TJSONAncestor>(SaveDB(vJSON, LClaims.UsuarioID.ToInteger)).Status(201);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure UpdateStatusSuspenso(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(UpdateStatus(Req.Params.Items['id'].ToInteger, 'S'));
end;

procedure UpdateStatusInativo(Req: THorseRequest; Res: THorseResponse; Next: TProc);
begin
  Res.Send<TJSONAncestor>(UpdateStatus(Req.Params.Items['id'].ToInteger, 'I'));
end;

procedure UpdateValidadeByID(Req: THorseRequest; Res: THorseResponse; Next: TProc);
var
   vJSON : TJSONObject;
begin
  try
    vJSON := TJSONObject.Create;
    vJSON := Req.Body<TJSONObject>;
    Res.Send<TJSONAncestor>(UpdateValidade(vJSON)).Status(202);
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
    Res.Send<TJSONAncestor>(SaveDB(vJSON, 0, Req.Params.Items['id'].ToInteger)).Status(202);
  finally
    FreeAndNil(vJSON);
  end;
end;

procedure registrar;
begin
  THorse.Get( 'smaio/loja/usuario/:id', Authorization(), GetbyUsuario);
  THorse.Get( 'smaio/loja', Authorization(), GetbyAll);
  THorse.Post('smaio/loja', AuthorizationClaim(), Append);
  THorse.Put('smaio/loja/:id', Authorization(), Update);
  THorse.Patch('smaio/loja/inativo/:id', Authorization, UpdateStatusInativo);
  THorse.Patch('smaio/loja/suspenso/:id', Authorization, UpdateStatusSuspenso);
  THorse.Post('smaio/loja/validade', Authorization, UpdateValidadeByID);
end;

end.
