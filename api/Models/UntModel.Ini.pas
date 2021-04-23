unit UntModel.Ini;

interface

type
  Tini = class
    private
      FProvider: string;
      FHost    : string;
      FDatabase: string;
      FUser: string;
      FPassword: string;
      procedure SetProvider(const Value: string);
      procedure SetHost(const Value: string);
      procedure SetDatabase(const Value: string);
      procedure SetUser(const Value: string);
      procedure SetPassword(const Value: string);
    public
      constructor Create;
      destructor Destroy; override;
      property Provider : string read FProvider write SetProvider;
      property Host : string  read FHost write SetHost;
      property Database : string read FDatabase write SetDatabase;
      property User : string read FUser write SetUser;
      property Password : string read FPassword write SetPassword;
  end;

implementation

uses
  System.SysUtils;

{ Tini }

constructor Tini.Create;
begin

end;

destructor Tini.Destroy;
begin

  inherited;
end;

procedure Tini.SetDatabase(const Value: string);
begin
  if not Length(Value) > 3 then
     raise Exception.Create('Database não informada corretamente.');
  FDatabase := Value;
end;

procedure Tini.SetHost(const Value: string);
begin
  if not Length(Value) > 3 then
     raise Exception.Create('Host não informado corretamente.');
  FHost := Value;
end;

procedure Tini.SetPassword(const Value: string);
begin
  if not Length(Value) > 3 then
     raise Exception.Create('Password não informado corretamente.');
  FPassword := Value;
end;

procedure Tini.SetProvider(const Value: string);
begin
  if not Length(Value) > 3 then
     raise Exception.Create('Provider não informado corretamente.');
  FProvider := Value;
end;

procedure Tini.SetUser(const Value: string);
begin
  if not Length(Value) > 3 then
     raise Exception.Create('Usuário não informado corretamente.');
  FUser := Value;
end;

end.
