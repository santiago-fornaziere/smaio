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
        vUsuario.AddPair('usu_id', LClaims.UsuarioID);
        vUsuario.AddPair('usu_nome', LClaims.UsuarioNome);
        vUsuario.AddPair('usu_nivel', LClaims.UsuarioNivel);
        vUsuario.AddPair('usu_email', LClaims.UsuarioEmail);
        Res.Send(vUsuario).Status(200);
      finally
      end;
    end);
end;

end.
