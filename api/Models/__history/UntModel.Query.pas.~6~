unit UntModel.Query;

interface

uses
  Uni,
  UntModel.Connection;

type
  TQuery = class
    private
      FQuery : TUniQuery;
      FConn : TConn;
    procedure SetQuery(const Value: TUniQuery);
    public
    constructor Create;
    destructor Destroy; override;
    property Query : TUniQuery read FQuery write SetQuery;
  end;

implementation

uses
  System.SysUtils;

{ TQuery }

constructor TQuery.Create;
begin
   FQuery := TUniQuery.Create(nil);
   FConn := TConn.Create();
   FQuery.Connection := FConn.Conn;
end;

destructor TQuery.Destroy;
begin
  FreeAndNil(FConn);
  FQuery.DisposeOf;
  inherited;
end;

procedure TQuery.SetQuery(const Value: TUniQuery);
begin
  FQuery := Value;
end;

end.
