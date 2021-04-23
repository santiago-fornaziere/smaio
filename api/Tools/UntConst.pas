unit UntConst;

interface

uses Classes;

const
     // Periodo Lancamento Contabil
     ConstOrigPeriodoLanctoMovto = 1; // Lancto;
     ConstOrigPeriodoLanctoCtb   = 2; // Lancto;

     // Operacao Transacao Financeira
     ConstOperTransFinanBaixaRec      = 1; // BAIXA DE CONTAS A RECEBER
     ConstOperTransFinanBaixaCheRec   = 2; // BAIXA DE CHEQUE
     ConstOperTransFinanBaixaPag      = 3; // BAIXA DE CONTAS A PAGAR
     ConstOperTransFinanBaixaChePag   = 4; // EMISSÃO DE CHEQUE

     // Desconto de Duplicata
     ConstDescDupSitDigitacao       = 507; // Em digitação
     ConstDescDupSitFechado         = 508; // Fechado
     ConstDescDupSitFinalizado      = 509; // Finalizado

     // Geral
     ConstSim = 6;
     ConstNao = 7;

     // Tipo Operacao de Baixa de Título
     ConstTipoOperBxaTitulo  = 1;
     ConstTipoOperBxaCredito = 2;

     // Tipo de Complemento
     ConstNfTipComplValor = 512; // Valor
     ConstNfTipComplQtde  = 513; // Quantidade
     ConstNfTipComplICMS  = 514; // ICMS

     // operações de cadastros
     ConstIncluir    = 1;
     ConstAlterar    = 2;
     ConstExcluir    = 3;
     ConstVisualizar = 4;
     ConstEncerrar   = 5;
     ConstProrrogar  = 6;
     ConstRrecuperar = 7;
     ConstLocalizar  = 8;
     ConstExpedir    = 9;
     ConstImportar   = 10;

     // pessoa
     ConstPessoaFisica   = 8;
     ConstPessoaJuridica = 9;

     // Pessoa Fisica Sexo
     ConstSexoFeminino  = 25;
     ConstSexoMasculino = 26;

     // Pessoa Fisica Estado Civil
     ConstEstadoCivilSolteiro   = 1;
     ConstEstadoCivilCasado     = 2;
     ConstEstadoCivilSeparado   = 3;
     ConstEstadoCivilDivorciado = 4;
     ConstEstadoCivilViuvo      = 5;

     // Situacao do Cliente
     ConstSitCliLiberado  = 1;
     ConstSitCliBloqueado = 2;
     ConstSitCliSuspenso  = 3;
     ConstSitCliInativo   = 4;


     // Filtros
     ConstFiltChar      = 1;
     ConstFiltDateTime  = 2;
     ConstFiltDecimal   = 3;
     ConstFiltImage     = 4;
     ConstFiltInt       = 5;
     ConstFiltNVarchar  = 6;
     ConstFiltTime      = 7;
     ConstFiltVarbinary = 8;
     ConstFiltVarchar   = 9;
     ConstFiltFK        = 10;

     // Pessoa Vinculo
     ConstCliente        = 1;
     ConstColaborador    = 2;
     ConstFornecedor     = 3;
     ConstTransportador  = 4;

     // Tabela de Preco
     ConstTatPrecoNormal = 38;
     ConstTatPrecoOferta = 39;

     // Situação do Registro
     ConstSitRegAtivo    = 1;
     ConstSitRegInativo  = 2;
     ConstSitRegExcluido = 3;


     // Demonstrativo Contabil
     ConstEstrutContabDLPA  = 547;
     ConstEstrutContabDOAR  = 548;
     ConstEstrutContabDRE   = 549;
     ConstEstrutContabDMPL  = 550;

     // Tipo de Conta Bancaria
     ConstTipoCtaBancContaCorrente = 140;
     ConstTipoCtaBancPoupanca      = 141;

     // Situação do Título
     ConstSituacaoTitAberto      = 18;
     ConstSituacaoTitParcial     = 19;
     ConstSituacaoTitBaixado     = 20;
     ConstSituacaoTitCancelado   = 75;
     ConstSituacaoTitRenegociado = 76;
     ConstSituacaoTitDevolvido   = 77;


     // Situaçao Titulo
     ConstTitParcAberto           = 18;
     ConstTitParcBaixaParcial     = 19;
     ConstTitParcBaixado          = 20;
     ConstTitParcCancelado        = 75;
     ConstTitParcRenegociado      = 76;
     ConstTitParcDevolvido        = 77;

     // Tipo Baixa de Cheque
     ConstTipBaixaLiq         = 78;
     ConstTipBaixaDev         = 79;
     ConstTipBaixaPerdaDanos  = 80;
     ConstTipBaixaAbatimento  = 189;
     ConstTipBaixaPermuta     = 190;
     ConstTipBaixaTransfCred  = 191;


     // Natureza do Titulo
     ConstNatTitReceber               = 1;
     ConstNatTitPagar                 = 2;
     ConstNatTitChequeRecebido        = 3;
     ConstNatTitChequeEmitido         = 4;

     // Condição de Cheque
     ConstCondCheDepositar            = 1;  // A DEPOSITAR
     ConstCondCheCustodia             = 2;  // EM CUSTODIA
     ConstCondCheDepositado           = 3;  // DEPOSITADO
     ConstCondCheDevolvido1           = 4;  // DEVOLVIDO 1a VEZ
     ConstCondCheReapresentado        = 5;  // REAPRESENTADO
     ConstCondCheDevolvido2           = 6;  // DEVOLVIDO 2a VEZ
     ConstCondCheDevolvidoRecebido    = 7;  // DEV. E RECEBIDO
     ConstCondCheDescontado           = 8;  // DESCONTADO
     ConstCondCheResgatado            = 9;  // RESGATADO
     ConstCondChePagoTerceiro         = 10; // PAGO A TERCEIRO
     ConstCondCheCompensado           = 11; // COMPENSADO
     ConstCondCheRenegociado          = 12; // RENEGOCIADO

     // Operacao Financeiro Tipo de conta
     ConstOperaFinTipCtaBanco  = 72;
     ConstOperaFinTipCtaCaixa  = 73;
     ConstOperaFinNatEntrada   = 85;
     ConstOperaFinNatSaida     = 86;


      // Finalidade do Cheque
      ConstFinalidChePagtoDiversos     = 87;
      ConstFinalidChePagtoTitulos      = 88;

      // Talonário
      ConstTalonFolSitDisponivel       = 331; // talonario_folha talon_fol_SITUACAO_ID DISPONÍVEL
      ConstTalonFolSitUtilizada        = 332; //talonario_folha talon_fol_SITUACAO_ID UTILIZADA
      ConstTalonFolSitCancelada        = 333; //talonario_folha talon_fol_SITUACAO_ID CANCELADA




     // Tipo de Conta Financeira
     ConstCtaFinTipoCaixa = 44;
     ConstCtaFinTipoBanco = 45;
     ConstCtaFinTipoPda   = 46;

     // Tipo Despesas
     ConstDespReceber     = 59;
     ConstDespPagar       = 58;
     ConstDespTipoReceita = 56;
     ConstDespTipoDespesa = 57;

     // Tipo de Crédito
     ConstCreditoPagar    = 2;
     ConstCreditoReceber  = 1;


     // Permissão Usuario
     ConstUsuIncluir            = 1;
     ConstUsuAlterar            = 2;
     ConstUsuExcluir            = 3;
     ConstUsuRecuperar          = 4;
     ConstUsuProrrogar          = 5;
     ConstUsuExcluiBaixaTit     = 6;
     ConstUsuGeraBoleto         = 7;
     ConstUsuExcluiMovtoFechado = 8;
     ConstUsuExcluiConciliacao  = 9;
     ConstUsuConciliarMovto     = 10;
     ConstUsuConciliarTransf    = 11;

     // Tipo Despesa Nota Fiscal TIPO
     ConstTipoDespNfPerc          = 31;
     ConstTipoDespNfValor         = 32;
     ConstTipoDespNfFrete         = 23;
     ConstTipoDespNfSeguro        = 28;
     ConstTipoDespNfDespAcess     = 30;
     ConstTipoDespNfFreteFora     = 100;
     ConstTipoDespNfDespAcessFora = 101;


     // Cartão de Crédito/Débito
     ConstCardArredondaPrimeira = 112;
     ConstCardArredondaUltima   = 113;

     // Situação de Liberação
     ConstLiberSitPendente  = 114;
     ConstLiberSitEmAnalise = 115;
     ConstLiberSitLiberada  = 116;
     ConstLiberSitNegada    = 117;

     // Situação do Pedido de Venda
     ConstSitPedidoAberto        = 105;
     ConstSitPedidoFaturado      = 106;
     ConstSitPedidoCancelado     = 107;
     ConstSitPedidoAguardLiberar = 108;
     ConstSitPedidoVendaFechada  = 109;
     ConstSitPedidoLibExpedicao  = 323;

     // Tipo do Pedido
     ConstPedidoTipoOrcamento    = 151;
     ConstPedidoTipoPedido       = 152;

     // Conta Contabil
       // Tipo
       ConstCtaCtbTipoAnalitica = 47;
       ConstCtaCtbTipoSintetica = 48;
       // Grupo
       ConstCtaCtbGrupoAtivo    = 49;
       ConstCtaCtbGrupoPassivo  = 50;
       ConstCtaCtbGrupoRecita   = 51;
       ConstCtaCtbGrupoDespesa  = 52;
       ConstCtaCtbGrupoCusto    = 53;

       // Natureza
       ConstCtaCtbNaturezaDevedora = 54;
       ConstCtaCtbNaturezaCredora  = 55;




     // Tipo da Requisição de Material
     ConstTipoReqConsumo   = 161;
     ConstTipoReqTransfDep = 162;

     // Tipo de endereço digital
     ConstTipoEndDigEmail = 1;
     ConstTipoEndDigSite  = 2;
     ConstTipoEndDigSkype = 3;
     ConstTipoEndDigFace  = 4;

     // Situação da Renegociação
     ConstSitRenegAberto    = 130;
     ConstSitRenegFechada   = 131;
     ConstSitRenegCancelada = 132;
     ConstTpJuroRenegCalc   = 138;
     ConstTpJuroRenegInf    = 139;

     // Tipo Historioco
     ConstHistTipoReceita = 133;
     ConstHistTipoDespesa = 134;


     // Antecipacao
     ConstAntecipaCliente    = 1;
     ConstAntecipaFornecedor = 2;

     // Tipo Prazo da condição de Pagamento
     ConstCondPagTipoPrazoFixo     = 41;
     ConstCondPagTipoPrazoVariavel = 42;
     ConstCondPagTipoPrazoMedio    = 43;

     // Calcula Item
     ConstCalcItemQtde     = 1;
     ConstCalcItemValor    = 2;
     ConstCalcItemVlrDesc  = 3;
     ConstCalcItemPercDesc = 4;

     // Status Nota Fiscal
     ConstStatusNfPendente    = 156;
     ConstStatusNfEmitida     = 157;
     ConstStatusNfCancelada   = 158;
     ConstStatusNfDenegada    = 188;
     ConstStatusNfInutilizada = 242;

     // Situacao Nota Fiscal
     ConstSituacaoNfEmDigitacao = 97;
     ConstSituacaoNfConfirmada  = 98;
     ConstSituacaoNfLiberada    = 99;

     // Situação Requisição
     ConstReqSituacaoAberto  = 121;
     ConstReqSituacaoFechado = 122;

     ConstReqExpedicaoAberto     = 163;
     ConstReqExpedicaoProcessado = 164;

     // Situacao Ordem de Serviço
     ConstOPSituacaoAberto    = 123;
     ConstOPSituacaoParada    = 124;
     ConstOPSituacaoEncerrada = 125;

     // Tipo Operacao Fiscal
     ConstOperFiscalCompra = 1;
     ConstOperFiscalVenda  = 2;

     // tipo_oper_fisc_TIPO_MOVTO_ID
     ConstOperFiscTipMovEstoqEntra = 33;
     ConstOperFiscTipMovEstoqSai   = 34;

     // Status da Cobrança
     ConstStatCobRetContato  = 1;
     ConstStatCobRetAgendado = 2;

     // Pedido  Tipo Entrega
     ConstPedTipoEntrRetira  = 171;
     ConstPedTipoEntrEntrega = 172;

     // Situação do Inventario
     ConstInventSitAberto     = 174;
     ConstInventSitProcessado = 175;
     ConstInventSitEncerrado  = 176;

     // Tipo do Inventário
     ConstInventTipoBalanco     = 177;
     ConstInventTipoConferencia = 178;

     // Contagem
     ConstSitContAberto     = 182;
     ConstSitCont1Contagem  = 183;
     ConstSitCont2Contagem  = 184;
     ConstSitCont3Contagem  = 185;
     ConstSitContProcessado = 186;
     ConstSitContFechado    = 187;

     // Tipo Transação TEF
     ConstProcesTEFPagamento    = 1;
     ConstProcesTEFCancelamento = 2;

     // Condição CST Icms
     ConstCondCstIcmsTributado = 210;
     ConstCondCstIcmsIsento    = 211;
     ConstCondCstIcmsOutras    = 212;

     // Condição CST Ipi
     ConstCondCstIpiTributado    = 213;
     ConstCondCstIpiNaoTributado = 214;

     // Condição CST Pis
     ConstCondCstPisTributado    = 215;
     ConstCondCstPisNaoTributado = 216;

     // Situacao Cartão de Credito TEF
     ConstPedCardSitAprovado   = 217;
     ConstPedCardSitCancelado  = 218;

     // Situação da Analise de Reposição
     constReposSitAberto       = 231;
     constReposSitSeparacao    = 232;
     constReposSitFaturamento  = 233;
     constReposSitEncerrado    = 234;

     // Situação Tabela de Descontos Classificação
     constDescClassAtivo       = 286;
     constDescClassInativo     = 287;

     // Tecnologia utilzada no campo
     constTecnologiaCampoAlta  = 283;
     constTecnologiaCampoMedia = 284;
     constTecnologiaCampoBaixa = 285;

     // Status do envio de regitros para nuvem
     constSincRegPendente       = 288;
     constSincRegErro           = 289;
     constSincRegEnviado        = 290;
     constSincRegConcluido      = 291;

     // Situação romaneios
     constRomanAberto            = 296;
     constRomanFechado           = 297;
     constRomanDescartado        = 319;
//     constromanAguarndadoPesagemVazio       = 288;

     // Situação contrato_agro
     constContrAgroAberto        = 298;
     constContrAgroFechado       = 299;
     constContrAgroEncerrado     = 314;

     // tipo movimento contrato agro
     constContratoMovEntrada     = 33;
     constContratoMovSaida       = 34;

     // tipo LABORATORIO DE ANALISES SEMENTE
     constLaboratorioSemente     = 300;
     constLaboratorioNematologia = 301;

     // Status analises amostras enviadas para analises laboratoriais
     constRemAmostraABERTO      = 302;
     constRemAmostraENVIADO     = 303;
     constRemAmostraAPROVADO    = 304;
     constRemAmostraREPROVADO   = 305;

     // analise ou reanalise laboratorial
     constRemAmostraANALISE     = 306;
     constRemAmostraREANALISE   = 307;

     // finalidades de analises LABORATORIAIS
     constFinalidadeDefinitivaBoletim    = 308;
     constFinalidadeReanalise            = 309;
     constFinalidadeQualidade            = 310;
     constFinalidadePreColheita          = 311;
     constFinalidadeExperimento          = 312;
     constFinalidadeDefinitivaLDF        = 313;

      // sis_tipo_cert_semente
      constcertsemCertificado            = 1;
      constcertsemAtestado               = 2;
      constcertsemTermoConform           = 3;

      // Tipo Item
      ConstItemTipoProduto               = 63;
      ConstItemTipoServico               = 64;

      // Tipo Estoque
      ConstItemTipoEstoqueComum        	= 61;
      ConstItemTipoEstoqueGrade         = 62;

      // Tipo Produto
      ConstProdTipoOutros	              = 147;
      ConstProdTipoMatPrima	            = 148;
      ConstProdTipoProdAcabado          = 149;
      ConstProdTipoProdIntermediario    = 150;


      // WMS
      ConstServWmsArmazenagem           =  1;
      ConstServWmsSeparacao             =  2;
      ConstServWmsMudaEndOrigem         =  3;
      ConstServWmsMudaEndDestino        =  4;

      // wms SITUACAO
      ConstWmsMovSituacaoAberto         = 320;
      ConstWmsMovSituacaoEmExecucao     = 321;
      ConstWmsMovSituacaoEncerrado      = 322;

      // WMS TIPO NATUREZA
      ConstWmsNaturezaNF                = 1;
      ConstWmsNaturezaNFLote            = 2;
      ConstWmsNaturezaNFOrdProdLote     = 3;
      ConstWmsNaturezaNFOrdProd         = 4;
      ConstWmsNaturezaNFReqExpedicao    = 5;
      ConstWmsNaturezaPedExpItem        = 6;
      ConstWmsNaturezaMudaEndereco      = 7;
      ConstWmsNaturezaSaldoInicialLote  = 8;

      // Status Expedicao
      ConstPedExpedicaoAberto           = 324;
      ConstPedExpedicaoAguardandoWMS    = 325;
      ConstPedExpedicaoEmSeparacao      = 326;
      ConstPedExpedicaoAguardandoFat    = 327;
      ConstPedExpedicaoFaturado         = 328;
      ConstPedExpedicaoCancelado        = 389;

      // Tipo contrato Agro
      ConstContrAgrCompra               = 1;
      ConstContrAgrVenda                = 2;
      ConstContrAgrCooperado            = 3;
      ConstContrAgrLicenciado           = 4;
      ConstContrAgrDesenvolvimento      = 5;
      ConstContrAgrColheita             = 6;
      ConstContrAgrServColheita         = 7;
      ConstContrAgrServTransporteo      = 8;
      ConstContrAgrServRemArm           = 9;
      ConstContrAgrServArrenAquis       = 10;
      ConstContrAgrServArrenSaida       = 11;
      ConstContrAgrTroca                = 14;
      ConstContrTransp                  = 12;
      ConstContrEmprestimo              = 15;

      // Situação campos no Sigef
      ConstSitSigefIsento               = 277;
      ConstSitSigefRegistrar            = 278;
      ConstSitSigefRegistrado           = 279;
      ConstSitSigefHomologado           = 280;
      ConstSitSigefDenegado             = 281;
      ConstSitSigefCancelado            = 282;

      // Paran Gera Título a Receber no Pedido de venda
      ConstFecharVdaGeraTitRecSim       = 17;
      ConstFecharVdaGeraTitRecNao       = 18;

      // sped
      ConstSpedFinalidadeOriginal       = 329;
      ConstSpedFinalidadeSubstituto     = 330;


      // cobrança
      ConstCNAB240       = 370;
      ConstCNAB400     = 371;

      ConstPedCompItemPendente          = 256;
      ConstPedCompItemCancelado         = 257;


      // Situacao da Solicitacao de Compra
      ConstSolCompSitEmAberto           = 346;
      ConstSolCompSitTriagem            = 347;
      ConstSolCompSitAprovado           = 348;
      ConstSolCompSitNegado             = 349;

      ConstSolCompItemSitBaixaNaoAtend  = 365;
      ConstSolCompItemSitBaixaTotal     = 366;
      ConstSolCompItemSitBaixaAtendTotal= 367;

      // Bordero_titulo
      ConstBorderoTitAberto               = 372;
      ConstBorderoTitBaixado              = 373;
      ConstBorderoTitNaoExec              = 374;

      ConstBorderoAprovado                = 375;
      ConstBorderoReprovado               = 376;
      ConstBorderoAberto                  = 377;
      ConstBorderoLiquidado               = 378;

      ConstBorderoTipManual               = 503;
      ConstBorderoTipRemessa              = 504;

      ConstAgroAtividadeAberto     = 399;
      ConstAgroAtividadeEncerrado  = 400;
      ConstAgroAtividadeEmExecucao = 401;

      ConstAgroAtribTipoPreencheManual    = 360;
      ConstAgroAtribTipoPreencheCalculado = 361;
      ConstAgroAtribTipoPreencheImportado = 362;

      ConstAgroCroquiSentBaixoCima        = 368;
      ConstAgroCroquiSentCimaBaixo        = 369;

      ConstTransfCredTipoReceber = 192;
      ConstTransfCredTipoPagar   = 193;

      ConstManifestRecebido      = 443;
      ConstManifestCiencia       = 444;
      ConstManifestDesconhecido  = 445;
      ConstManifestNaoRealizada  = 446;
      ConstManifestPendente      = 447;
      ConstManifestConfirmado    = 448;

      ConstVeicVincEngatado      = 450;
      ConstVeicVincDesengatado   = 451;

      ConstCondutorProprio       = 452;
      ConstCondutorTerceiro      = 453;

      ConstSeguroTipoVeicular    = 454;
      ConstSeguroTipoPessoal     = 455;
      ConstSeguroTipoImovel      = 456;

      ConstSeguroSitAtivo        = 457;
      ConstSeguroSitInativo      = 458;

      ConstPneuSitEstoque        = 459;
      ConstPneuSitSucata         = 460;
      ConstPneuSitUso            = 460;
      ConstPneuSitRecapagem      = 464;

      ConstEsquerda              = 463;
      ConstDireita               = 462;

      ConstContrServPercColBruta = 465;
      ConstContrServPercColLiq   = 466;
      ConstContrServValor        = 467;

      ConstContrServCombForn     = 468;
      ConstContrServCombEmp      = 469;

      ConstCteTipoNormal         = 470;
      ConstCteTipoGlobalizado    = 471;

      ConstCTeTomadRemet         = 472;
      ConstCTeTomadExped         = 473;
      ConstCTeTomadReceb         = 474;
      ConstCTeTomadDest          = 475;
      ConstCTeTomadOutro         = 476;

      ConstCTeSegRespTransp      = 484;
      ConstCTeSegRespTomad       = 485;

      ConstCTeSitAberto          = 477;
      ConstCTeSitFaturado        = 478;
      ConstCTeSitCancelado       = 479;

      ConstCTeModalRodoviario    = 1;
      ConstCTeModalAereo         = 2;
      ConstCTeModalAquaviario    = 3;
      ConstCTeModalFerroviario   = 4;
      ConstCTeModalDutoviario    = 5;


      ConstCTePrevEntSemDtDef    = 480;
      ConstCTePrevEntNaData      = 481;
      ConstCTePrevEntAteData     = 482;
      ConstCTePrevEntAposData    = 483;
      ConstCTePrevEntNoPeriodo   = 486;

      ConstVeicTpPropTacAgregado     = 221; // TAC - AGREGADO
      ConstVeicTpPropTacIndependente = 222; // TAC - INDEPENDENTE
      ConstVeicTpPropTacOutros       = 223; // OUTROS

      ConstOrcamentoAberto              = 352;
      ConstOrcamentoConcluido           = 353;
      ConstOrcamentoAprovado            = 354;
      ConstOrcamentoReprovado           = 355;

      ConstArrenSitAberto               = 487;
      ConstArrenSitFechado              = 488;
      ConstArrenSitConcluido            = 489;

      ConstCarregTipProprio             = 490;
      ConstCarregTipTerceiro            = 491;
      ConstCarregTipTransferencia       = 492;

     // Situacao do MDFe
     constMDFeSitPendente    = 245;
     constMDFeSitTransmitido = 246;
     constMDFeSitCancelado   = 247;
     constMDFeSitDenegado    = 421;
     constMDFeSitEncerrado   = 422;

     // Tipo Emitente MDFe
     constMDFeTpEmitPrestador    = 417;
     constMDFeTpEmitNaoPrestador = 418;

     // Tipo Transportador MDFe
     constMDFeTpTranspETC = 248;
     constMDFeTpTranspTAC = 249;
     constMDFeTpTranspCTC = 250;

     // Modalidade do MDFe
     constMDFeModalRodoviario = 415;
     constMDFeModalAquaviario = 416;

     constMDFeSegRespEmitente = 419;
     constMDFeSegRespContr    = 420;

     ConstViagemSitAberto     = 493;
     ConstViagemSitFechada    = 494;
     ConstViagemSitNegTransp  = 495;
     ConstViagemSitRetornado  = 496;
     ConstViagemSitEncerrado  = 497;

     ConstViagemAcerAberto     = 498;
     ConstViagemAcerAguardando = 499;
     ConstViagemAcerEncerrado  = 500;


     ConstContrTranspSitAberto  = 501;
     ConstContrTranspSitFechado = 502;

     ConstContrSitAberto  = 501;
     ConstContrSitFechado = 502;

     ConstContrEmpTipoPre = 510;
     ConstContrEmpTipoPos = 511;

     ConstAgroMonitAgendAguardando = 505;
     ConstAgroMonitAgendConcluido  = 506;


     ConstTipFazenPastoPotreiro = 1;
     ConstTipFazenPastoInvernada = 2;
     ConstTipFazenPastoPiquete = 3;
     ConstTipFazenPastoPasto = 4;
     ConstTipFazenPastoConfinamento = 5;
     ConstTipFazenPastoIntegracao = 6;

     ConstAnimalAtivCria    = 516;
     ConstAnimalAtivReCria  = 517;
     ConstAnimalAtivEngorda = 518;


     ConstAnimalNascTamanhoPequeno = 526;
     ConstAnimalNascTamanhoMedio = 527;
     ConstAnimalNascTamanhoGrande = 528;

     ConstAnimalSitAtivo = 519;
     ConstAnimalSitRejeitado = 520;
     ConstAnimalSitBG = 521;
     ConstAnimalSitTerceiro = 522;
     ConstAnimalSitBaixado = 538;

     ConstAnimalNascSitUnico = 523;
     ConstAnimalNascSitGemeos = 524;
     ConstAnimalNascSitDefeito = 525;

     ConstGtaAberto = 535;
     ConstGtaConfirmada = 536;

     ConstManejSitAberto = 515;
     ConstManejSitFechado = 537;

     ConstManejTipPesagem = 1;
     ConstManejTipDGestacao = 2;
     ConstManejTipDesmame = 3;
     ConstManejTipReproducao = 4;
     ConstManejTipAvaliacao = 5;
     ConstManejTipSanitario = 6;


     ConstAniNutricaoNormal = 529;
     ConstAniNutricaoCreep = 530;

     ConstManejRepNatEntaure     = 539;
     ConstManejRepNatInseminacao = 540;
     ConstManejRepTipPrimtentativa = 541;
     ConstManejRepTipReinseminacao = 542;

     ConstManejDgResultDuvida = 531;
     ConstManejDgResultPrenhe = 532;
     ConstManejDgResultVazia = 533;
     ConstManejDgResultReagendar = 534;

     ConstManejAvaTipConsulta = 543;
     ConstManejAvaTipExame = 544;
     ConstManejAvaTipAvaliacao = 545;
     ConstManejAvaTipOutros = 546;


      implementation

uses UntFuncoes;



end.
