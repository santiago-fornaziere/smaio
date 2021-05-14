unit UntModel.Connection;

interface

uses
  UntFuncoes,
  Uni,
  UntModel.Ini,
  System.SysUtils,
  MySQLUniProvider,
  PostgreSQLUniProvider,
  UniSQLMonitor;

type
  TConn = class
    private
    FConn : TUniConnection;
    FMySql : TMySQLUniProvider;
    FPostgres : TPostgreSQLUniProvider;
    FMonitor : TUniSQLMonitor;
    procedure SetConn(const Value: TUniConnection);
    public
    constructor Create;
    destructor Destroy; override;
    property Conn : TUniConnection read FConn write SetConn;

  end;

implementation

{ TConn }



constructor TConn.Create;
var vIni : Tini;
begin
  FConn := TUniConnection.Create(nil);
  if UpperCase(vIni.Provider) = 'MYSQL' then
     FMysql := TMySQLUniProvider.Create(nil);
  if UpperCase(vIni.Provider) = 'POSTGRESQL' then
     FPostgres := TPostgreSQLUniProvider.Create(nil);

  FMonitor := TUniSQLMonitor.Create(nil);
  vIni := Tini.Create;
  try
    vIni := ValidaConexao;
    FConn.Connected := False;
    FConn.Database := vIni.Database;
    FConn.ProviderName := vIni.Provider;
    FConn.Server := vIni.Host;
    FConn.Username := vIni.User;
    FConn.Password := vIni.Password;
    FMonitor.Active := True;
  finally
    FreeAndNil(vIni);
  end;
end;

destructor TConn.Destroy;
begin
  if Assigned(FMySql) then
     FreeAndNil(FMysql);
  if Assigned(FPostgres) then
     FreeAndNil(FPostgres);
  FreeAndNil(FMonitor);
  FreeAndNil(FConn);
  inherited;
end;

procedure TConn.SetConn(const Value: TUniConnection);
begin
  FConn := Value;
end;

end.
