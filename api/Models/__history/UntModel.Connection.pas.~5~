unit UntModel.Connection;

interface

uses
  UntFuncoes,
  Uni,
  UntModel.Ini,
  System.SysUtils,
  MySQLUniProvider,
  UniSQLMonitor;

type
  TConn = class
    private
    FConn : TUniConnection;
    FMySql : TMySQLUniProvider;
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
  FMysql := TMySQLUniProvider.Create(nil);
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
  finally
    FreeAndNil(vIni);
  end;
end;

destructor TConn.Destroy;
begin
  FreeAndNil(FMysql);
  FreeAndNil(FMonitor);
  FreeAndNil(FConn);
  inherited;
end;

procedure TConn.SetConn(const Value: TUniConnection);
begin
  FConn := Value;
end;

end.
