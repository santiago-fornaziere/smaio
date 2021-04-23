unit UntFuncoes;


interface

uses
  System.IniFiles,
  System.SysUtils,
  Vcl.Dialogs,
  System.DateUtils,
  UntModel.Ini;

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
  procedure DicSistema;

implementation

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
  vIpServer   := vConfigIni.ReadString('SGDB', 'IP', 'IP - N�o foi informado o IP SERVIDOR no arquivo de configura��o');
  vProvider   := vConfigIni.ReadString('SGDB', 'PROVIDER', 'PROVIDER - N�o foi informado o PROVIDER [ORACLE, SQL SERVER, DB2, MYSQL] no arquivo de configura��o');
  vDbServer   := vConfigIni.ReadString('SGDB', 'DB', 'DB - N�o foi informado o NOME DO OWNER/BASE DE DADOS da aplica��o no arquivo de configura��o');
  vUserServer := vConfigIni.ReadString('SGDB', 'USER', 'USER - N�o foi informado o USER DO SGDB no arquivo de configura��o');
  vPwdServer  := vConfigIni.ReadString('SGDB', 'PW', 'PW - N�o foi informado a PASSWORD SERVIDOR no arquivo de configura��o');

  vIni.Provider := vProvider;
  vIni.Host:= vIpServer;
  vIni.Database := vDbServer;
  vIni.User := vUserServer;
  vIni.Password := vPwdServer;
  Result := vIni;
end;

end.
