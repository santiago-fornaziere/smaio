program SmaioApiCadastro;

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
  UntConst in '..\Tools\UntConst.pas',
  UntModel.Claims in '..\Models\UntModel.Claims.pas',
  UntController.BFCall.Claim in 'Controllers\UntController.BFCall.Claim.pas',
  UntController.Authorization in '..\Tools\UntController.Authorization.pas',
  UntController.BFCall.Dashboard in 'Controllers\UntController.BFCall.Dashboard.pas',
  UntController.Smaio.Loja in 'Controllers\UntController.Smaio.Loja.pas',
  UntController.Smaio.Usuario in 'Controllers\UntController.Smaio.Usuario.pas',
  UntModel.Query in '..\Models\UntModel.Query.pas',
  UntModel.Connection in '..\Models\UntModel.Connection.pas',
  UntModel.Ini in '..\Models\UntModel.Ini.pas',
  UntModel.Usuario in 'Models\UntModel.Usuario.pas',
  UntModel.Loja in 'Models\UntModel.Loja.pas',
  UntInterface.Usuario in 'Interfaces\UntInterface.Usuario.pas',
  UntInterface.Loja in 'Interfaces\UntInterface.Loja.pas',
  UntInterface.Fabricante in 'Interfaces\UntInterface.Fabricante.pas',
  UntModel.Fabricante in 'Models\UntModel.Fabricante.pas',
  UntController.Smaio.Fabricante in 'Controllers\UntController.Smaio.Fabricante.pas',
  UntInterface.Veiculo in 'Interfaces\UntInterface.Veiculo.pas',
  UntModel.Veiculo in 'Models\UntModel.Veiculo.pas',
  UntController.Smaio.Veiculo in 'Controllers\UntController.Smaio.Veiculo.pas',
  UntInterface.VeiculoAno in 'Interfaces\UntInterface.VeiculoAno.pas',
  UntModel.VeiculoAno in 'Models\UntModel.VeiculoAno.pas',
  UntController.Smaio.VeiculoAno in 'Controllers\UntController.Smaio.VeiculoAno.pas',
  UntController.Smaio.Grupo in 'Controllers\UntController.Smaio.Grupo.pas',
  UntInterface.Peca in 'Interfaces\UntInterface.Peca.pas',
  UntModel.Peca in 'Models\UntModel.Peca.pas',
  UntModel.SubGrupo in 'Models\UntModel.SubGrupo.pas',
  UntModel.SubGruVeiAno in 'Models\UntModel.SubGruVeiAno.pas',
  UntController.Smaio.Peca in 'Controllers\UntController.Smaio.Peca.pas';

begin
  ReportMemoryLeaksOnShutdown := True;

  THorse.Use(Jhonson);
  THorseLoggerManager.RegisterProvider(THorseLoggerProviderLogFile.New());
  THorse.Use(THorseLoggerManager.HorseCallback());
  THorse.Use(HandleException);
  THorse.Use(Cors);
  DicSistema;

  // registro de rotas de Api
  UntController.Smaio.Loja.registrar;
  UntController.Smaio.Usuario.registrar;
  UntController.Smaio.Fabricante.registrar;
  UntController.Smaio.Veiculo.registrar;
  UntController.Smaio.VeiculoAno.registrar;
  UntController.Smaio.Grupo.registrar;

  THorse.Listen(9101,
    procedure(Horse: THorse)
    begin
      Writeln('Servidor api-cadastros rodando na porta ' + THorse.Port.ToString);
      Write('Precione qualquer tecla para parar...');
      ReadLn;
      THorse.StopListen;
    end);
end.