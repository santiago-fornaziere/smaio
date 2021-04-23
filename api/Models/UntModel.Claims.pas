unit UntModel.Claims;

interface

uses
  JOSE.Core.JWT,
  JOSE.Types.JSON;

type
  TClaims = class(TJWTClaims)
    strict private
      function GetUsuarioID: string;
      function GetUsuarioNivel: string;
      function GetUsuarioNome: string;
      function GetUsuarioEmail: string;

      procedure SetUsuarioID(const Value: string);
      procedure SetUsuarioNome(const Value: string);
      procedure SetUsuarioNivel(const Value: string);
      procedure SetUsuarioEmail(const Value: string);
    public
      property UsuarioID : string read GetUsuarioID write SetUsuarioID;
      property UsuarioNome : string read GetUsuarioNome write SetUsuarioNome;
      property UsuarioNivel : string read GetUsuarioNivel write SetUsuarioNivel;
      property UsuarioEmail : string read GetUsuarioEmail write SetUsuarioEmail;
  end;

implementation

{ TClaims }

function TClaims.GetUsuarioNivel: string;
begin
  Result := TJSONUtils.GetJSONValue('Nivel', FJSON).AsString;
end;

function TClaims.GetUsuarioEmail: string;
begin
  Result := TJSONUtils.GetJSONValue('usu_nivel', FJSON).AsString;
end;

function TClaims.GetUsuarioID: string;
begin
  Result := TJSONUtils.GetJSONValue('usu_id', FJSON).AsString;
end;

function TClaims.GetUsuarioNome: string;
begin
  Result := TJSONUtils.GetJSONValue('usu_nome', FJSON).AsString;
end;

procedure TClaims.SetUsuarioNivel(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('usu_nivel', Value, FJSON);
end;

procedure TClaims.SetUsuarioEmail(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('usu_email', Value, FJSON);
end;

procedure TClaims.SetUsuarioID(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('usu_id', Value, FJSON);
end;

procedure TClaims.SetUsuarioNome(const Value: string);
begin
  TJSONUtils.SetJSONValueFrom<string>('usu_nome', Value, FJSON);
end;

end.
