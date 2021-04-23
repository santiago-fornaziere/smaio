﻿program ApiArquivo;
{$APPTYPE CONSOLE}
{$R *.res}
uses
  Vcl.Forms,
  Horse,
  Horse.OctetStream,
  System.Classes,
  System.SysUtils,
  Horse.JWT,
  Horse.Cors,
  Horse.Jhonson,
  Horse.Logger.Provider.LogFile,
  Horse.Logger,
  Horse.HandleException,
  UntFuncoes in '..\Tools\UntFuncoes.pas',
  UntController.Authorization in '..\Tools\UntController.Authorization.pas',
  UntController.BFCall.ChamadoAnexo in 'Controllers\UntController.BFCall.ChamadoAnexo.pas',
  UntModel.Connection in '..\Models\UntModel.Connection.pas',
  UntModel.Ini in '..\Models\UntModel.Ini.pas',
  UntModel.Query in '..\Models\UntModel.Query.pas',
  UntModel.Claims in '..\Models\UntModel.Claims.pas';

begin
  ReportMemoryLeaksOnShutdown := True;

  THorse.Use(OctetStream);
  THorse.Use(Cors);
  THorse.Use(Jhonson);
  THorseLoggerManager.RegisterProvider(THorseLoggerProviderLogFile.New());
  THorse.Use(THorseLoggerManager.HorseCallback());
  THorse.Use(HandleException);
  DicSistema;

  UntController.BFCall.ChamadoAnexo.registrar;

  THorse.Listen(9098,
    procedure(Horse: THorse)
    begin
      Writeln('Servidor api-anexos rodando na porta ' + THorse.Port.ToString);
      Write('Precione qualquer tecla para parar...');
      ReadLn;
      THorse.StopListen;
    end);

  end.