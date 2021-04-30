unit UntModel.Usuario;

interface
uses
  UntInterface.Usuario,
  System.Generics.Collections,
  System.JSON,
  System.SysUtils,
  DataSet.Serialize,
  UntModel.Query;
type
  TUsuario = class(TInterfacedObject, iUsuario)
    private
      Fusu_id : integer;
      Fusu_nome : String;
      Fusu_email : String;
      Fusu_telefone : String;
      Fusu_senha : String;
      Fusu_dt_ativacao : TDateTime;
      Fusu_dt_lancamento : TDateTime;
      Fusu_dt_validade : TDateTime;
      Fusu_nivel : TyNivel;
      Fusu_sit_reg : Boolean;
      Fusu_loj_id : TList<integer>;

      function usu_id : integer; overload;
      function usu_id (const Value : integer) : iUsuario; overload;
      function usu_id (const Value : String) : iUsuario; overload;
      function usu_nome : String; overload;
      function usu_nome (const Value : String) : iUsuario; overload;
      function usu_email : String; overload;
      function usu_email (const Value : String) : iUsuario; overload;
      function usu_telefone : String; overload;
      function usu_telefone (const Value : String) : iUsuario; overload;
      function usu_senha : String; overload;
      function usu_senha (const Value : String = '') : iUsuario; overload;
      function usu_dt_ativacao : TDateTime; overload;
      function usu_dt_ativacao (const Value : TDateTime) : iUsuario; overload;
      function usu_dt_ativacao (const Value : String) : iUsuario; overload;
      function usu_dt_lancamento : TDateTime; overload;
      function usu_dt_lancamento (const Value : TDateTime) : iUsuario; overload;
      function usu_dt_lancamento (const Value : String) : iUsuario; overload;
      function usu_dt_validade : TDateTime; overload;
      function usu_dt_validade (const Value : TDateTime) : iUsuario; overload;
      function usu_dt_validade (const Value : String) : iUsuario; overload;
      function usu_nivel : TyNivel; overload;
      function usu_nivel (const Value : TyNivel) : iUsuario; overload;
      function usu_nivel (const Value : String) : iUsuario; overload;
      function usu_sit_reg : Boolean; overload;
      function usu_sit_reg (const Value : Boolean) : iUsuario; overload;
      function usu_loj_id : TList<integer>; overload;
      function usu_loj_id (const Value : TJSONArray) : iUsuario; overload;
      constructor Create;
      function Cadastrar: TJSONObject;
      function Alterar: TJSONObject;
    public
      destructor Destroy; override;
      class function New : iUsuario;
  end;

implementation


{ TUsuario }

uses UntFuncoes;

function TUsuario.Cadastrar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
   I : integer;
   ja: TJSONArray;
   jv: TJSONValue;
   jSubObj, vRetorno : TJSONObject;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Usuario\usuario_insert.sql');
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
      vQry.Query.ParamByName('usu_nome').AsString := Fusu_nome;
      vQry.Query.ParamByName('usu_email').AsString := Fusu_email;
      vQry.Query.ParamByName('usu_telefone').AsString := Fusu_telefone;
      vQry.Query.ParamByName('usu_senha').AsString := Fusu_senha;
      vQry.Query.ParamByName('usu_dt_ativacao').AsDateTime := Fusu_dt_ativacao;
      vQry.Query.ParamByName('usu_dt_validade').AsDateTime := Fusu_dt_validade;
      if Fusu_nivel = TyNivel.niSmaio then
        vQry.Query.ParamByName('usu_nivel').AsString := 'Smaio'
      else
          vQry.Query.ParamByName('usu_nivel').AsString := 'Loja';
      vQry.Query.Open;
      Fusu_id := vQry.Query.FieldByName('usu_ID').AsInteger;
      vRetorno := vQry.Query.ToJSONObject;

      AssignFile(f, Sistema.Path_SQL+'Smaio\Usuario\usuloj_insert.sql');
      Reset(f);
      vSQL := '';
      While not Eof(f) do
      begin
        Readln(f, fLinha);
        vSQL := vSQL + ' '+fLinha;
      end;
      CloseFile(f);
      vQry.Query.SQL.Clear;
      vQry.Query.SQL.Add(vSQL);
      for I := 0 to Fusu_loj_id.Count - 1 do
      begin
        vQry.Query.ParamByName('uloj_loj_id').AsInteger := Fusu_loj_id[I];
        vQry.Query.ParamByName('uloj_usu_id').AsInteger := Fusu_id;
        vQry.Query.Execute;
      end;
      vQry.Query.Connection.Commit;

      Result := vRetorno;
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

function TUsuario.Alterar: TJSONObject;
var
   vSQL, fLinha : String;
   vQry : TQuery;
   f : TextFile;
begin
  try
    AssignFile(f, Sistema.Path_SQL+'Smaio\Usuario\usuario_update.sql');
    Reset(f);
    vSQL := '';
    While not Eof(f) do
    begin
      Readln(f, fLinha);
      vSQL := vSQL + ' '+fLinha;
    end;
    CloseFile(f);
    vQry := TQuery.Create;
    try
      vQry.Query.SQL.Add(vSQL);
      vQry.Query.ParamByName('usu_id').AsInteger := Fusu_id;
      vQry.Query.ParamByName('usu_nome').AsString := Fusu_nome;
      vQry.Query.ParamByName('usu_email').AsString := Fusu_email;
      vQry.Query.ParamByName('usu_telefone').AsString := Fusu_telefone;
      vQry.Query.ParamByName('usu_dt_validade').AsDateTime := Fusu_dt_validade;
      if Fusu_nivel = TyNivel.niSmaio then
        vQry.Query.ParamByName('usu_nivel').AsString := 'Smaio'
      else
          vQry.Query.ParamByName('usu_nivel').AsString := 'Loja';
      vQry.Query.ParamByName('usu_sit_reg').AsBoolean := Fusu_sit_reg;
      vQry.Query.Open;
      Result := vQry.Query.ToJSONObject;;
    except
      on E : Exception do
      begin
        raise Exception.Create(E.Message);
      end;
    end;
  finally
    freeandnil(vQry);
  end;
end;

constructor TUsuario.Create;
begin
  Fusu_sit_reg := True;
  Fusu_dt_lancamento := Now;
  Fusu_loj_id := TList<integer>.Create;
end;

destructor TUsuario.Destroy;
begin
  Fusu_loj_id.Free;
  inherited;
end;

class function TUsuario.New: iUsuario;
begin
  Result := Self.Create;
end;

function TUsuario.usu_dt_ativacao: TDateTime;
begin
  Result := Fusu_dt_ativacao;
end;

function TUsuario.usu_dt_ativacao(const Value: TDateTime): iUsuario;
begin
    Result := Self;
    Fusu_dt_ativacao := Value;
end;

function TUsuario.usu_dt_ativacao(const Value: String): iUsuario;
begin
  try
    Result := Self;
    Fusu_dt_ativacao := JSONDateToDatetime(Value);
  except
  on E : Exception do
  begin
    raise Exception.Create('Verifique a data de ativa��o...');
  end;
  end;
end;

function TUsuario.usu_dt_lancamento(const Value: TDateTime): iUsuario;
begin
  Result := Self;
  Fusu_dt_lancamento := Value;
end;

function TUsuario.usu_dt_lancamento(const Value: String): iUsuario;
begin
  try
    Result := Self;
    Fusu_dt_lancamento := JSONDateToDatetime(Value);
  except
  on E: Exception do
  begin
    raise Exception.Create('Verifique a data de lan�amento...');
  end;
  end;
end;

function TUsuario.usu_dt_lancamento: TDateTime;
begin
  Result := Fusu_dt_lancamento;
end;

function TUsuario.usu_dt_validade: TDateTime;
begin
  Result := Fusu_dt_validade;
end;

function TUsuario.usu_dt_validade(const Value: TDateTime): iUsuario;
begin
  Result := Self;
  Fusu_dt_validade := Value;
end;

function TUsuario.usu_dt_validade(const Value: String): iUsuario;
begin
  try
    Result := Self;
    Fusu_dt_validade := JSONDateToDatetime(Value);
  except
  on E: Exception do
  begin
    raise Exception.Create('Verifique a data de validade...');
  end;
  end;
end;

function TUsuario.usu_email(const Value: String): iUsuario;
begin
  if not (Pos('@',Value) > 0) then
     raise Exception.Create('Favor informar um e-email v�lido...');

  Result := Self;
  Fusu_email := Value;
end;

function TUsuario.usu_email: String;
begin
  Result := Fusu_email;
end;

function TUsuario.usu_id(const Value: integer): iUsuario;
begin
  Result := Self;
  Fusu_id := Value;
end;

function TUsuario.usu_id(const Value: String): iUsuario;
begin
  Result := Self;
  Fusu_id := StrToInt(Value);
end;

function TUsuario.usu_id: integer;
begin
  Result := Fusu_id;
end;

function TUsuario.usu_loj_id(const Value: TJSONArray): iUsuario;
var I : integer;
   jSubObj : TJSONObject;
   jv: TJSONValue;
begin
  try
    Result := Self;
    for I := 0 to Value.Size - 1 do
    begin
      jSubObj := (Value.Get(i) as TJSONObject);
      jv := jSubObj.Get(0).JsonValue;
      Fusu_loj_id.Add(jv.Value.ToInteger);
    end;
  except
  on E: Exception do
  begin
    raise Exception.Create('Erro ao carregar liga��o com as lojas...');
  end;
  end;
end;

function TUsuario.usu_loj_id: TList<integer>;
begin
  Result := Fusu_loj_id;
end;

function TUsuario.usu_nivel(const Value: TyNivel): iUsuario;
begin
  Result := Self;
  Fusu_nivel := Value;
end;

function TUsuario.usu_nivel(const Value: String): iUsuario;
begin
  Result := Self;
  if Value = 'Loja' then
     Fusu_nivel := TyNivel.niLoja
  else Fusu_nivel := TyNivel.niSmaio;
end;

function TUsuario.usu_nivel: TyNivel;
begin
  Result := Fusu_nivel;
end;

function TUsuario.usu_nome: String;
begin
  Result := Fusu_nome;
end;

function TUsuario.usu_nome(const Value: String): iUsuario;
begin
  Result := Self;
  Fusu_nome := Value;
end;

function TUsuario.usu_senha: String;
begin
  Result := Fusu_senha;
end;

function TUsuario.usu_senha(const Value: String): iUsuario;
begin
  if not (Length(Value) > 5) then
    raise Exception.Create('Favor informar uma senha com mais de 5 caracteres...');
  Result := Self;
  Fusu_senha := Value;
end;

function TUsuario.usu_sit_reg: Boolean;
begin
  Result := Fusu_sit_reg;
end;

function TUsuario.usu_sit_reg(const Value: Boolean): iUsuario;
begin
  Result := Self;
  Fusu_sit_reg := Value;
end;

function TUsuario.usu_telefone(const Value: String): iUsuario;
begin
  Result := Self;
  Fusu_telefone := Value;
end;

function TUsuario.usu_telefone: String;
begin
  Result := Fusu_telefone;
end;

end.