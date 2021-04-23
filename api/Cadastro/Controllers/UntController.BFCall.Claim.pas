unit UntController.BFCall.Claim;

interface

uses
  Horse,
  Horse.JWT,
  System.JSON,
  UntModel.Claims,
  System.SysUtils;

procedure registrar;

implementation


procedure registrar;
begin
  THorse.Get( '/bfcall/claim', HorseJWT('key', TClaims),
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LClaims: TClaims;
      vUsuario: TJSONObject;
    begin
      try
        LClaims := Req.Session<TClaims>;
        vUsuario := TJSONObject.Create;
        vUsuario.AddPair('usuarioID', LClaims.UsuarioID);
        vUsuario.AddPair('usuarioNome', LClaims.UsuarioNome);
        vUsuario.AddPair('usuarioNivel', LClaims.UsuarioNivel);
        vUsuario.AddPair('ClienteID', LClaims.ClienteID);
        vUsuario.AddPair('ClienteNome', LClaims.ClienteNome);
        vUsuario.AddPair('AtendenteID', LClaims.AtendenteID);
        Res.Send(vUsuario).Status(200);
      finally
      end;
    end);
end;

end.