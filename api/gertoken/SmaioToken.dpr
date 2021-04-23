program SmaioToken;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  Vcl.Forms,
  Horse,
  Horse.Jhonson,
  System.JSON,
  JOSE.core.JWT,
  JOSE.core.Builder,
  System.SysUtils,
  Vcl.Dialogs,
  Horse.Logger.Provider.LogFile,
  Horse.Logger,
  Horse.HandleException,
  Horse.Cors,
  UntFuncoes in '..\Tools\UntFuncoes.pas',
  UntConst in '..\Tools\UntConst.pas',
  UntController.Login in 'Controllers\UntController.Login.pas',
  UntModel.Claims in '..\Models\UntModel.Claims.pas',
  System.Generics.Collections,
  UntModel.Connection in '..\Models\UntModel.Connection.pas',
  UntModel.Ini in '..\Models\UntModel.Ini.pas',
  UntModel.Query in '..\Models\UntModel.Query.pas';

begin
  THorse.Use(Jhonson());
  THorseLoggerManager.RegisterProvider( THorseLoggerProviderLogFile.New() );
  THorse.Use( THorseLoggerManager.HorseCallback() );
  THorse.Use(HandleException);
  THorse.use(Cors);
  DicSistema;

  THorse.POST('/gertoken',
    procedure(Req: THorseRequest; Res: THorseResponse; Next: TProc)
    var
      LToken: TJWT;
      LCompactToken, texto: string;
      User, vUsuarioDB : TJSONObject;
      LClaims: TClaims;
    begin
      texto := Req.Body;
      User := TJSONObject.ParseJSONValue(texto) as TJSONObject;
      vUsuarioDB := UntController.Login.ConsultaLogin(User);
      if vUsuarioDB.Count > 0 then
      begin
        LToken := TJWT.Create(TClaims);
        try
          LClaims := TClaims(LToken.Claims);
          // Padr�o da ferramenta
          LClaims.Issuer := 'Gerencial Sistemas';
          LClaims.Subject := 'Token';
          LClaims.Expiration := Now + 1;

          // Minhas informa��es... exemplo
          LClaims.UsuarioID := vUsuarioDB.Values['usuario_ID'].Value;
          LClaims.UsuarioNome := vUsuarioDB.Values['usuario_NOME'].Value;
          LClaims.UsuarioNivel := vUsuarioDB.Values['usuario_NIVEL'].Value;
          LClaims.ClienteID := vUsuarioDB.Values['usuario_CLIENTE_ID'].Value;
          LClaims.ClienteNome := vUsuarioDB.Values['cli_NOME'].Value;
          LClaims.AtendenteID := vUsuarioDB.Values['usuario_ATEND_ID'].Value;

          // criando o token
          LCompactToken := TJOSE.SHA256CompactToken('key', LToken);
          Res.Send(LCompactToken);
        finally
          freeandnil(LToken);
          Freeandnil(vUsuarioDB);
          freeandnil(User);
        end;
      end else
      begin
        Res.Send('N�o foi poss�vel concluir a solicita��o, verifique os dados enviados!').Status(401);
      end;
    end);

  THorse.Listen(9099,
    procedure(Horse: THorse)
    begin
      Writeln('TOKEN Server est� rondando na porta ' + THorse.Port.ToString);
      Write('Precione qualquer tecla para parar...');
      ReadLn;
      THorse.StopListen;
    end);
end.
