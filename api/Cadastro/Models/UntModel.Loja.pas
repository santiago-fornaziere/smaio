unit UntModel.Loja;

interface

uses
  UntInterface.Loja,
  System.Generics.Collections,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,
  UntModel.Query;

type
  TLoja = class(TInterfacedObject, iLoja)
  private
    Floj_id : integer;
    Floj_nome : String;
    Floj_ativacao : TDateTime;
    Floj_dt_validade : TDateTime;
    Floj_cnpj : String;
    Floj_email : String;
    Floj_telefone_1 : String;
    Floj_telefone_2 : String;
    Floj_cep : String;
    Floj_logradouro : String;
    Floj_numero : String;
    Floj_bairro : String;
    Floj_cid_id : integer;
    Floj_status : TyStatus;
    Floj_latitude : String;
    Floj_longitude : String;
    Floj_tra_id : integer;
    Floj_sit_reg : Boolean;
    Floj_usu_id : integer;

    function loj_id : integer; overload;
    function loj_id (const Value : integer): iLoja; overload;
    function loj_nome : String; overload;
    function loj_nome (const Value : String) : iLoja; overload;
    function loj_ativacao : TDatetime; overload;
    function loj_ativacao (const Value : TDatetime) : iLoja; overload;
    function loj_ativacao (const Value : String) : iLoja; overload;
    function loj_dt_validade : TDatetime; overload;
    function loj_dt_validade (const Value : TDatetime) : iLoja; overload;
    function loj_dt_validade (const Value : String) : iLoja; overload;
    function loj_cnpj : String; overload;
    function loj_cnpj (const Value : String) : iLoja; overload;
    function loj_email : String; overload;
    function loj_email (const Value : String) : iLoja; overload;
    function loj_telefone_1 : String; overload;
    function loj_telefone_1 (const Value : String) : iLoja; overload;
    function loj_telefone_2 : String; overload;
    function loj_telefone_2 (const Value : String) : iLoja; overload;
    function loj_cep : String; overload;
    function loj_cep (const Value : String) : iLoja; overload;
    function loj_logradouro : String; overload;
    function loj_logradouro (const Value : String) : iLoja; overload;
    function loj_numero : String; overload;
    function loj_numero (const Value : String) : iLoja; overload;
    function loj_bairro : String; overload;
    function loj_bairro (const Value : String) : iLoja; overload;
    function loj_cid_id : integer; overload;
    function loj_cid_id (const Value : integer): iLoja; overload;
    function loj_status : TyStatus; overload;
    function loj_status (const Value : String): iLoja; overload;
    function loj_status (const Value : TyStatus): iLoja; overload;
    function loj_latitude : String; overload;
    function loj_latitude (const Value : String): iLoja; overload;
    function loj_longitude : String; overload;
    function loj_longitude (const Value : String): iLoja; overload;
    function loj_tra_id : integer; overload;
    function loj_tra_id (const Value : integer): iLoja; overload;
    function loj_sit_reg : boolean; overload;
    function loj_sit_reg (const Value : boolean): iLoja; overload;
    function loj_usu_id (const Value : integer): iLoja; overload;
    constructor Create;
    function Cadastrar: TJSONObject;
    function Alterar: TJSONObject;
  public
    destructor Destroy; override;
    class function New : iLoja;
  end;

implementation

uses UntFuncoes;

{ TLoja }

function TLoja.Alterar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Loja\loja_update.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.Connection.StartTransaction;
    try
      vQry.Query.SQL.Add(vSQL);
      vQry.Query.ParamByName('loj_nome').AsString := Floj_nome;
      vQry.Query.ParamByName('loj_ativacao').AsDateTime := Floj_ativacao;
      vQry.Query.ParamByName('loj_cnpj').AsString := Floj_cnpj;
      vQry.Query.ParamByName('loj_email').AsString := Floj_email;
      vQry.Query.ParamByName('loj_telefone_1').AsString := Floj_telefone_1;
      vQry.Query.ParamByName('loj_telefone_2').AsString := Floj_telefone_2;
      vQry.Query.ParamByName('loj_cep').AsString := Floj_cep;
      vQry.Query.ParamByName('loj_logradouro').AsString := Floj_logradouro;
      vQry.Query.ParamByName('loj_numero').AsString := Floj_numero;
      vQry.Query.ParamByName('loj_bairro').AsString := Floj_bairro;
      vQry.Query.ParamByName('loj_cid_id').AsInteger := Floj_cid_id;
      vQry.Query.ParamByName('loj_latitude').AsString := Floj_latitude;
      vQry.Query.ParamByName('loj_longitude').AsString := Floj_longitude;
      vQry.Query.ParamByName('loj_dt_validade').AsDateTime := Floj_dt_validade;
      if Floj_status = TyStatus.stSuspenso then
        vQry.Query.ParamByName('loj_status').AsString := 'Suspenso'
      else
      if Floj_status = TyStatus.stInativo then
        vQry.Query.ParamByName('loj_status').AsString := 'Inativo'
      else
          vQry.Query.ParamByName('loj_status').AsString := 'Ativo';
      vQry.Query.ParamByName('loj_id').AsInteger := Floj_id;
      vQry.Query.Open;
      vQry.Query.Connection.Commit;

      Result := vQry.Query.ToJSONObject;
    except
      on E : Exception do
      begin
        vQry.Query.Connection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    freeandnil(vQry);
  end;
end;

function TLoja.Cadastrar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Loja\loja_insert.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    vQry.Query.Connection.StartTransaction;
    try
      Floj_tra_id := GeraTransacao(Floj_usu_id);
      vQry.Query.SQL.Add(vSQL);
      vQry.Query.ParamByName('loj_nome').AsString := Floj_nome;
      vQry.Query.ParamByName('loj_ativacao').AsDateTime := Floj_ativacao;
      vQry.Query.ParamByName('loj_cnpj').AsString := Floj_cnpj;
      vQry.Query.ParamByName('loj_email').AsString := Floj_email;
      vQry.Query.ParamByName('loj_telefone_1').AsString := Floj_telefone_1;
      vQry.Query.ParamByName('loj_telefone_2').AsString := Floj_telefone_2;
      vQry.Query.ParamByName('loj_cep').AsString := Floj_cep;
      vQry.Query.ParamByName('loj_logradouro').AsString := Floj_logradouro;
      vQry.Query.ParamByName('loj_numero').AsString := Floj_numero;
      vQry.Query.ParamByName('loj_bairro').AsString := Floj_bairro;
      vQry.Query.ParamByName('loj_cid_id').AsInteger := Floj_cid_id;
      vQry.Query.ParamByName('loj_latitude').AsString := Floj_latitude;
      vQry.Query.ParamByName('loj_longitude').AsString := Floj_longitude;
      vQry.Query.ParamByName('loj_tra_id').AsInteger := Floj_tra_id;
      if Floj_status = TyStatus.stSuspenso then
        vQry.Query.ParamByName('loj_status').AsString := 'Suspenso'
      else
      if Floj_status = TyStatus.stInativo then
        vQry.Query.ParamByName('loj_status').AsString := 'Inativo'
      else
          vQry.Query.ParamByName('loj_status').AsString := 'Ativo';
      vQry.Query.Open;
      Floj_id := vQry.Query.FieldByName('loj_ID').AsInteger;
      vQry.Query.Connection.Commit;

      Result := vQry.Query.ToJSONObject;
    except
      on E : Exception do
      begin
        vQry.Query.Connection.Rollback;
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    freeandnil(vQry);
  end;
end;

constructor TLoja.Create;
begin
  Floj_sit_reg := True;
  Floj_ativacao := Now;
  Floj_ativacao := Now+31;
  Floj_status := TyStatus.stAtivo;
end;

destructor TLoja.Destroy;
begin
  inherited;
end;

function TLoja.loj_ativacao: TDatetime;
begin
   Result := Floj_ativacao;
end;

function TLoja.loj_ativacao(const Value: TDatetime): iLoja;
begin
  Result := Self;
  Floj_ativacao := Value;
end;

function TLoja.loj_ativacao(const Value: String): iLoja;
begin
   try
    Result := Self;
    Floj_ativacao := JSONDateToDatetime(Value);
   except
   on E : Exception do
   begin
     raise Exception.Create('Verifique a data de ativa��o...');
   end;
   end;
end;

function TLoja.loj_bairro: String;
begin
   Result := Floj_bairro;
end;

function TLoja.loj_bairro(const Value: String): iLoja;
begin
  Result := Self;
  Floj_bairro := Value;
end;

function TLoja.loj_cep(const Value: String): iLoja;
begin
  if not (Length(SoNumero(Value)) = 8) then
     raise Exception.Create('Verifique o cep...');
  
  Result := Self;
  Floj_cep := SoNumero(Value);
end;

function TLoja.loj_cep: String;
begin
   Result := Floj_cep;
end;

function TLoja.loj_cid_id(const Value: integer): iLoja;
begin
   Result := Self;
   Floj_cid_id := Value;
end;

function TLoja.loj_cid_id: integer;
begin
   Result := Floj_cid_id;
end;

function TLoja.loj_cnpj(const Value: String): iLoja;
begin
   if not (Length(SoNumero(Value)) = 14) then
      raise Exception.Create('CNPJ informado esta incorreto...');

   Result := Self;
   Floj_cnpj := Sonumero(Value);
end;

function TLoja.loj_cnpj: String;
begin
   Result := Floj_cnpj;
end;

function TLoja.loj_dt_validade: TDatetime;
begin
   Result := Floj_dt_validade;
end;

function TLoja.loj_dt_validade(const Value: TDatetime): iLoja;
begin
   Result := Self;
   Floj_dt_validade := Value;
end;

function TLoja.loj_dt_validade(const Value: String): iLoja;
begin
   try
    Result := Self;
    Floj_dt_validade := JSONDateToDatetime(Value);
   except
   on E : Exception do
   begin
     raise Exception.Create('Verifique a data de validade...');
   end;
   end;
end;

function TLoja.loj_email(const Value: String): iLoja;
begin
  if not (Pos('@',Value) > 0) then
     raise Exception.Create('Favor informar um e-email v�lido...');

  Result := Self;
  Floj_email := Value;
end;

function TLoja.loj_email: String;
begin
   Result := Floj_email;
end;

function TLoja.loj_id(const Value: integer): iLoja;
begin
   Result := Self;
   Floj_id := Value;
end;

function TLoja.loj_id: integer;
begin
   Result := Floj_id;
end;

function TLoja.loj_latitude(const Value: String): iLoja;
begin
   Result := Self;
   Floj_latitude := Value;
end;

function TLoja.loj_latitude: String;
begin
   Result := Floj_latitude;
end;

function TLoja.loj_logradouro: String;
begin
   Result := Floj_logradouro;
end;

function TLoja.loj_logradouro(const Value: String): iLoja;
begin
   Result := Self;
   Floj_logradouro := Value;
end;

function TLoja.loj_longitude(const Value: String): iLoja;
begin
   Result := Self;
   Floj_longitude := Value;
end;

function TLoja.loj_longitude: String;
begin
   Result := Floj_longitude;
end;

function TLoja.loj_nome: String;
begin
   Result := Floj_nome;
end;

function TLoja.loj_nome(const Value: String): iLoja;
begin
   if not (Length(Value) > 5) then
      raise Exception.Create('Nome da Loja inv�lido...');

   Result := Self;
   Floj_nome := Value;
end;

function TLoja.loj_numero(const Value: String): iLoja;
begin
   Result := Self;
   Floj_numero := Value;
end;

function TLoja.loj_numero: String;
begin
   Result := Floj_numero;
end;

function TLoja.loj_sit_reg: boolean;
begin
   Result := Floj_sit_reg;
end;

function TLoja.loj_sit_reg(const Value: boolean): iLoja;
begin
   Result := Self;
   Floj_sit_reg := Value;
end;

function TLoja.loj_status: TyStatus;
begin
   Result := Floj_status;
end;

function TLoja.loj_status(const Value: String): iLoja;
begin
   Result := Self;
   if Value = 'Suspenso' then
      Floj_status := TyStatus.stSuspenso
   else if Value = 'Inativo' then
      Floj_status := TyStatus.stInativo
   else
      Floj_status := TyStatus.stAtivo
end;

function TLoja.loj_status(const Value: TyStatus): iLoja;
begin
   Result := Self;
   Floj_status := Value;
end;

function TLoja.loj_telefone_1(const Value: String): iLoja;
begin
   if not (Length(Value) > 7) then
      raise Exception.Create('Verifique o telefone...');

   Result := Self;
   Floj_telefone_1 := Value;
end;

function TLoja.loj_telefone_1: String;
begin
   Result := Floj_telefone_1;
end;

function TLoja.loj_telefone_2: String;
begin
   Result := Floj_telefone_2;
end;

function TLoja.loj_telefone_2(const Value: String): iLoja;
begin
   if not (Length(Value) > 7) and (Length(Value) > 0) then
      raise Exception.Create('Verifique o telefone 2...');

   Result := Self;
   Floj_telefone_2 := Value;
end;

function TLoja.loj_tra_id: integer;
begin
  Result := Floj_tra_id;
end;

function TLoja.loj_tra_id(const Value: integer): iLoja;
begin
   Result := Self;
   Floj_tra_id := Value;
end;

function TLoja.loj_usu_id(const Value: integer): iLoja;
begin
  Result := Self;
  Floj_usu_id := Value;
end;

class function TLoja.New: iLoja;
begin
  Result := Self.Create;
end;

end.
