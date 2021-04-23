unit UntModel.Claims;

interface

uses
  JOSE.Core.JWT,
  JOSE.Types.JSON;

type
  TClaims = class(TJWTClaims)
    strict private
      function GetUsuarioID: string;
      procedure SetUsuarioID(const Value: string);
      function GetAtendenteID: string;
      function GetClienteID: string;
      function GetClienteNome: string;
      function GetNivel: string;
      function GetUsuarioNome: string;
      procedure SetAtendenteID(const Value: string);
      procedure SetClienteID(const Value: string);
      procedure SetClienteNome(const Value: string);
      procedure SetNivel(const Value: string);
      procedure SetUsuarioNome(const Value: string);
    public
      property UsuarioID : string read GetUsuarioID write SetUsuarioID;
      property UsuarioNome : string read GetUsuarioNome write SetUsuarioNome;
      property ClienteID : string read GetClienteID write SetClienteID;
      property ClienteNome : string read GetClienteNome write SetClienteNome;
      property UsuarioNivel : string read GetNivel write SetNivel;
      property AtendenteID : string read GetAtendenteID write SetAtendenteID;
  end;

implementation

{ TClaims }

function TClaims.GetAtendenteID: string;
begin
  Result := TJSONUtils.GetJSONValue('AtendenteID', FJSON).AsString;
end;

function TClaims.GetClienteID: string;
begin
  Result := TJSONUtils.GetJSONValue('ClienteID', FJSON).AsString;
end;

function TClaims.GetClienteNome: string;
begin
  Result := TJSONUtils.GetJSONValue('ClienteNome', FJSON).AsString;
end;

function TClaims.GetNivel: string;
begin
  Result := TJSONUtils.GetJSONValue('Nivel', FJSON).AsString;
end;

function TClaims.GetUsuarioID: string;
begin
  Result := TJSONUtils.GetJSONValue('UsuarioID', FJSON).AsString;
end;

function TClaims.GetUsuarioNome: string;
begin
  Result := TJSONUtils.GetJSONValue('UsuarioNome', FJSON).AsString;
end;

procedure TClaims.SetAtendenteID(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('AtendenteID', Value, FJSON);
end;

procedure TClaims.SetClienteID(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('ClienteID', Value, FJSON);
end;

procedure TClaims.SetClienteNome(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('ClienteNome', Value, FJSON);
end;

procedure TClaims.SetNivel(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('Nivel', Value, FJSON);
end;

procedure TClaims.SetUsuarioID(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('UsuarioID', Value, FJSON);
end;

procedure TClaims.SetUsuarioNome(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('UsuarioNome', Value, FJSON);
end;

end.
