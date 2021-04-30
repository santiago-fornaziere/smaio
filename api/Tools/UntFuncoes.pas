unit UntFuncoes;


interface

uses
  System.IniFiles,
  System.SysUtils,
  Vcl.Dialogs,
  System.DateUtils,
  UntModel.Ini,
  System.JSON;

type
  TSistema = record
    Path_Executavel        : String;
    Path_SQL               : String;
    Path_Anexo             : String;
  end;

  var
     Sistema : TSistema;

  function ValidaConexao: Tini;
  function JSONDateToDatetime(JSONDate: string): TDatetime;
  function GeraTransacao(pUsuario : integer): integer;
  procedure DicSistema;
  function AssignFieldsApi(pCampos : Array of String; pJSON : TJSONObject) : Boolean;
  function SoNumero(pTexto: string): string;

implementation

uses
  UntModel.Query;

function AssignFieldsApi(pCampos : Array of String ; pJSON : TJSONObject) : Boolean;
var Field : String;
    I : integer;
begin
  try
    for I := 0 to length(pCampos) -1 do
    begin
      Field := pCampos[I];
      Field := pJSON.Values[pCampos[I]].Value;
    end;
    Result := True;
  except
    on E : Exception do
    begin
      Result := False;
      raise Exception.Create('Erro ao validar campo "'+Field+'" da Api...');
    end;
  end;
end;

procedure DicSistema;
begin
    if not DirectoryExists(ExtractFilePath(ParamStr(0))+'SQL\') then
       forceDirectories(ExtractFilePath(ParamStr(0))+'SQL\');

    if not DirectoryExists(ExtractFilePath(ParamStr(0))+'Anexo\') then
       forceDirectories(ExtractFilePath(ParamStr(0))+'Anexo\');

    Sistema.Path_Executavel   := ExtractFilePath(ParamStr(0));
    Sistema.Path_SQL          := Sistema.Path_Executavel+'SQL\';
    Sistema.Path_Anexo        := Sistema.Path_Executavel+'Anexo\';
end;

function JSONDateToDatetime(JSONDate: string): TDatetime;
var Year, Month, Day, Hour, Minute, Second, Millisecond: Word;
begin
  if not (Length(JSONDate) > 9)
    and (JSONDate <> 'null') then
     raise Exception.Create('Erro na data enviada.');

  if not (JSONDate = 'null') then
  begin
    Year        := StrToInt(Copy(JSONDate, 1, 4));
    Month       := StrToInt(Copy(JSONDate, 6, 2));
    Day         := StrToInt(Copy(JSONDate, 9, 2));
    try
      Hour        := StrToInt(Copy(JSONDate, 12, 2));
      Minute      := StrToInt(Copy(JSONDate, 15, 2));
      Second      := StrToInt(Copy(JSONDate, 18, 2));
      Millisecond := Round(StrToFloat(Copy(JSONDate, 21, 3)));
      Result := EncodeDateTime(Year, Month, Day, Hour, Minute, Second, Millisecond);
    except
      Result := EncodeDate(Year, Month, Day);
    end;
  end else
  begin
    Result := 0;
  end;
end;

function ValidaConexao: Tini;
var vIpServer
  , vDbServer
  , vProvider
  , vUserServer
  , vPwdServer : String;
  vConfigIni : TInifile;
  vIni : Tini;
begin
  vIni := Tini.Create;
  vConfigIni  := TIniFile.Create(ExtractFilePath(ParamSTR(0))+'ApiConfig.Ini');
  vIpServer   := vConfigIni.ReadString('SGDB', 'IP', 'IP - Não foi informado o IP SERVIDOR no arquivo de configuração');
  vProvider   := vConfigIni.ReadString('SGDB', 'PROVIDER', 'PROVIDER - Não foi informado o PROVIDER [ORACLE, SQL SERVER, DB2, MYSQL] no arquivo de configuração');
  vDbServer   := vConfigIni.ReadString('SGDB', 'DB', 'DB - Não foi informado o NOME DO OWNER/BASE DE DADOS da aplicação no arquivo de configuração');
  vUserServer := vConfigIni.ReadString('SGDB', 'USER', 'USER - Não foi informado o USER DO SGDB no arquivo de configuração');
  vPwdServer  := vConfigIni.ReadString('SGDB', 'PW', 'PW - Não foi informado a PASSWORD SERVIDOR no arquivo de configuração');

  vIni.Provider := vProvider;
  vIni.Host:= vIpServer;
  vIni.Database := vDbServer;
  vIni.User := vUserServer;
  vIni.Password := vPwdServer;
  Result := vIni;
end;

function GeraTransacao(pUsuario : integer): integer;
var vQry : TQuery;
begin
    vQry := TQuery.Create;
    vQry.Query.SQL.Add('INSERT INTO transacao (tra_dt_lancamento , tra_usu_id ) values (current_date, '+IntToStr(pUsuario)+') RETURNING tra_id');
    vQry.Query.Open;
    Result := vQry.Query.Fields[0].AsInteger;
end;

function SoNumero(pTexto: string): string;
var vCont: Integer;
begin
   Result := '';
   for vCont := 1 To Length(pTexto) do
       if pTexto [vCont] In ['0'..'9'] Then
          Result := Result + pTexto [vCont];
end;

end.
