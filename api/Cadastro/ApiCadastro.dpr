program ApiCadastro;

{$APPTYPE CONSOLE}
{$R *.res}

uses
  System.SysUtils,
  Vcl.Forms,
  Vcl.Dialogs,
  Horse,
  Horse.Jhonson,
  Horse.Logger.Provider.LogFile,
  Horse.Logger,
  Horse.HandleException,
  Horse.Cors,
  UntFuncoes in '..\Tools\UntFuncoes.pas',
  UntModel.Safra in 'Models\UntModel.Safra.pas',
  UntConst in '..\Tools\UntConst.pas',
  UntController.Safra in 'Controllers\UntController.Safra.pas',
  UntController.BFCall.Chamado in 'Controllers\UntController.BFCall.Chamado.pas',
  Untmodel.BFCall.Chamado in 'Models\Untmodel.BFCall.Chamado.pas',
  UntInterface.BfCall.Chamado in 'Interfaces\UntInterface.BfCall.Chamado.pas',
  UntController.BFCall.TipoChamado in 'Controllers\UntController.BFCall.TipoChamado.pas',
  UntController.BFCall.Clientes in 'Controllers\UntController.BFCall.Clientes.pas',
  UntModel.Claims in '..\Models\UntModel.Claims.pas',
  UntController.BFCall.Claim in 'Controllers\UntController.BFCall.Claim.pas',
  UntController.BFCall.ChamadoEvento in 'Controllers\UntController.BFCall.ChamadoEvento.pas',
  UntController.BFCall.Usuario in 'Controllers\UntController.BFCall.Usuario.pas',
  UntController.Authorization in '..\Tools\UntController.Authorization.pas',
  UntModel.Query in '..\Models\UntModel.Query.pas',
  UntModel.Connection in '..\Models\UntModel.Connection.pas',
  UntModel.Ini in '..\Models\UntModel.Ini.pas',
  UntController.BFCall.Dashboard in 'Controllers\UntController.BFCall.Dashboard.pas';

begin
  ReportMemoryLeaksOnShutdown := True;

  THorse.Use(Jhonson);
  THorseLoggerManager.RegisterProvider(THorseLoggerProviderLogFile.New());
  THorse.Use(THorseLoggerManager.HorseCallback());
  THorse.Use(HandleException);
  THorse.Use(Cors);
  DicSistema;

  // registro de rotas de Api
  UntController.Safra.registrar;
  UntController.BFCall.Chamado.registrar;
  UntController.BFCall.TipoChamado.registrar;
  UntController.BFCall.Clientes.registrar;
  UntController.BFCall.Claim.registrar;
  UntController.BFCall.ChamadoEvento.registrar;
  UntController.BFCall.Usuario.registrar;
  UntController.BFCall.Dashboard.registrar;

  THorse.Listen(9001,
    procedure(Horse: THorse)
    begin
      Writeln('Servidor api-cadastros rodando na porta ' + THorse.Port.ToString);
      Write('Precione qualquer tecla para parar...');
      ReadLn;
      THorse.StopListen;
    end);
end.