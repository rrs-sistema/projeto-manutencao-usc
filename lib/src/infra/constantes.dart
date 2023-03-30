/*
Title: Manutenção USC                                                                
Description: Classe que armazena algumas constantes para a aplicação.
                                                                                
The MIT License                                                                 
                                                                                
Copyright: Copyright (C) 2021 RRS System                                          
                                                                                
Permission is hereby granted, free of charge, to any person                     
obtaining a copy of this software and associated documentation                  
files (the 'Software'), to deal in the Software without                         
restriction, including without limitation the rights to use,                    
copy, modify, merge, publish, distribute, sublicense, and/or sell               
copies of the Software, and to permit persons to whom the                       
Software is furnished to do so, subject to the following                        
conditions:                                                                     
                                                                                
The above copyright notice and this permission notice shall be                  
included in all copies or substantial portions of the Software.                 
                                                                                
THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,                 
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES                 
OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND                        
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT                     
HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,                    
WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING                    
FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR                   
OTHER DEALINGS IN THE SOFTWARE.                                                 
                                                                                
       The author may be contacted at:                                          
           rrs.sistema@gmail.com                                                   
                                                                                
@author Rivaldo Roberto (rivaldo.roberto@outlook.com)                    
@version 1.0.0
*******************************************************************************/
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:catcher/catcher.dart';
import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart' hide Key;
import 'package:flutter/foundation.dart' hide Key;
import 'package:intl/intl.dart';

import './../infra/infra.dart';

class Constantes {
  /// singleton
  factory Constantes() {
    _this ??= Constantes._();
    return _this!;
  }
  static Constantes? _this;
  Constantes._() : super();
  static String chave =
      '#Sua-Chave-de-32-caracteres-aqui'; // #Sua-Chave-de-32-caracteres-aqui tem que alterar para produção e gerar os valores do ENV com a chave correta

  static const String versaoApp = 'versão 1.0.0 - Janeiro/2023';
  static Key key = Key.fromUtf8(Constantes.chave);
  static IV iv = IV.fromUtf8('#Seu-Vetor-aqui#');

  static Encrypter encrypter =
      Encrypter(AES(key, mode: AESMode.ctr, padding: null));

  static var primaryColor = Colors.indigo[900]; //Color(0xFF2A2D3E);
  static final secondaryColor = Colors.amber[900];
  static final secondaryColorOme = Colors.amber[600];
  static const secondaryColor1 = Color.fromARGB(255, 62, 67, 92);
  static const bgColor = Color(0xFF212332);
  static var btnPrimary = Colors.amber[900];
  static var btnSecondary = Colors.indigo[900];

  static const primaryColorError = Colors.red;
  static final btnPrimaryOverlay = Colors.blueGrey[700];

// #region Inteiros
  static const int paginatedDataTableLinhasPorPagina =
      PaginatedDataTable.defaultRowsPerPage;
// #endregion Inteiros

// #region Double
  static const double paddingListViewListaPage = 8.0;
  static const double flutterBootstrapGutterSize = 10.0;
// #region Double

// #region Decimais
  static final formatoDecimalTaxa = NumberFormat('#,##0.00', 'pt_BR');
  static final formatoDecimalValor = NumberFormat('#,##0.00', 'pt_BR');
  static final formatoDecimalQuantidade = NumberFormat('#,##0.000', 'pt_BR');
// #endregion Decimais

// #region Strings
  static const String nomeSoftwareHouse = 'Manutenção USC';
  static const String dadosSoftwareHouse =
      '$nomeSoftwareHouse - WhatsApp: (41) 98422-1805';
  static const String nomeAppCompleto = 'Proje Uni - Manutenção USC';
  static const String nomeApp = 'Manutenção USC';

  static const String menuCadastrosString = 'Manutenção USC - Cadastros';
  static const String menuFinanceiroString = 'Manutenção USC - Financeiro';
  static const String menuTributacaoString = 'Manutenção USC - Tributação';
  static const String menuEstoqueString = 'Manutenção USC - Estoque';
  static const String menuVendasString = 'Manutenção USC - Vendas';
  static const String menuComprasString = 'Manutenção USC - Compras';
  static const String menuComissoesString =
      'Manutenção USC - Gestão de Comissões';
  static const String menuOsString = 'Manutenção USC - Ordem de Serviço';
  static const String menuAfvString = 'Manutenção USC - AFV';
  static const String menuNfseString = 'Manutenção USC - NFS-e';
  static const String menuCTeString = "Manutenção USC - CT-e";

  static const String tituloAbaDetalhePrincipal = 'Detalhes';

  static const String impressaoFormularioA4 = 'Formulário A4';
  static const String impressaoBobina57 = 'Bobina 57';
  static const String impressaoBobina80 = 'Bobina 80';

  static const String tituloCaixaAberto = '[Caixa Aberto]';
  static const String tituloCaixaFechado = '[Caixa Fechado]';
  static const String tituloCaixaVendaEmAndamento = '[Venda em andamento]';

  // Descrição botões
  static const String botaoFiltrarDescricao =
      kIsWeb == true ? 'Filtro [Ctrl+F11]' : 'Filtro [F11]';
  static const String botaoImprimirDescricao =
      kIsWeb == true ? 'Relatório [Ctrl+F8]' : 'Relatório [F8]';
  static const String botaoExcluirDescricao =
      kIsWeb == true ? 'Excluir [Ctrl+F9]' : 'Excluir [F9]';
  static const String botaoAlterarDescricao =
      kIsWeb == true ? 'Alterar [Ctrl+F3]' : 'Alterar [F3]';
  static const String botaoSalvarDescricao =
      kIsWeb == true ? 'Salvar [Ctrl+F12]' : 'Salvar [12]';
  // - Caixa
  static final String botaoCaixaSalvar =
      Biblioteca.isDesktop() ? 'Salvar [F12]' : 'Salvar';
  static final String botaoCaixaCancelar =
      Biblioteca.isDesktop() ? 'Cancelar [F11]' : 'Cancelar';

  static final String botaoCaixaComprarAssinatura =
      Biblioteca.isDesktop() ? 'Assinar [F8]' : 'Assinar';

  static final String botaoCaixaRecuperar =
      Biblioteca.isDesktop() ? 'Recuperar [F9]' : 'Recuperar';
  static final String botaoCaixaDesconto =
      Biblioteca.isDesktop() ? 'Desconto [F10]' : 'Desconto';

  static final String botaoCaixaVendedor =
      Biblioteca.isDesktop() ? 'Vendedor [F3]' : 'Vendedor';
  static final String botaoCaixaCliente =
      Biblioteca.isDesktop() ? 'Cliente [F4]' : 'Cliente';
  static final String botaoCaixaOpcoes =
      Biblioteca.isDesktop() ? 'Mais... [F5]' : 'Mais...';

  // Dicas botões
  static const String botaoInserirDica = 'Inserir Item [F2]';
  static const String botaoFiltrarDica = 'Aplicar Filtro';
  static const String botaoImprimirDica = 'Relatório PDF';
  static const String botaoExcluirDica = 'Excluir Registro';
  static const String botaoAlterarDica = 'Alterar Registro';
  static const String botaoSalvarDica = 'Salvar';
  // - Caixa
  static const String botaoCaixaImportarProdutoDica = 'Importar Produto [F6]';

  // Perguntas
  static const String perguntaGerarRelatorio = 'Desejar gerar o relatório?';
  static const String perguntaSalvarAlteracoes =
      'Desejar salvar as alterações?';

  // Mensagens
  static const String mensagemCorrijaErrosFormSalvar =
      'Por favor, corrija os erros apresentados antes de continuar.';

// #endregion Strings

// #region Máscaras
  static const String mascaraCPF = '000.000.000-00';
  static const String mascaraCNPJ = '00.000.000/0000-00';
  static const String mascaraCEP = '00000-000';
  static const String mascaraTELEFONE = '(00)00000-0000';
  // ignore: constant_identifier_names
  static const String mascaraMES_ANO = '00/0000';
  static const String mascaraHORA = '00:00:00';
  static const String mascaraDIA = '00';
  static const String mascaraMES = '00';
  static const String mascaraANO = '0000';
  // ignore: constant_identifier_names
  static const String mascaraDATA_HORA = "00/00/0000 00:00";
  // ignore: constant_identifier_names
  static const String mascaraQUANTIDADE_INTEIRO = '00000';
// #endregion Máscaras

// #region Fontes
  static const String quickFont = 'Quicksand';
  static const String ralewayFont = 'Raleway';
  static const String quickBoldFont = 'Quicksand_Bold.otf';
  static const String quickNormalFont = 'Quicksand_Book.otf';
  static const String quickLightFont = 'Quicksand_Light.otf';
// #endregion Fontes

// #region Imagens
  //images
  static const String imageDir = 'assets';
  static const String rrsSystemLogo = '$imageDir/logo_manutencao.gif';
  static const String rrsSystemLogo48 =
      '$imageDir/rrs.system.technology-48.png';
  static const String rrsSystemLogoGrande =
      '$imageDir/logo_rrs.system.technology.png';
  static const String logoPrincipal = '$imageDir/logo-manutencao.png';

  static const String googleMapFake = '$imageDir/maps.png';
  static const String restauranteBackgroundImage =
      '$imageDir/restaurante-background.jpg';
  static const String comandaBackgroundImage =
      '$imageDir/comanda-background.jpg';
  static const String mesaImage = '$imageDir/mesa.jpg';
  static const String mesaImage01 = '$imageDir/mesa01.jpg';
  static const String mesaImage02 = '$imageDir/mesa02.jpg';
  static const String mesaImage03 = '$imageDir/mesa03.jpg';
  static const String addIcon = '$imageDir/add_icon.png';
  static const String fundoComandaImage = '$imageDir/fundo-comanda.png';
  static const String addImage = '$imageDir/add_image.jpg';

  //images menu
  static const String menuCadastrosImage = '$imageDir/menu_cadastros.jpg';
  static const String menuNfeImage = '$imageDir/menu_nfe.jpg';
  static const String menuNfceImage = '$imageDir/menu_nfce.jpg';
  static const String menuNfseImage = '$imageDir/menu_nfse.jpg';
  static const String menuCteImage = '$imageDir/menu_cte.jpg';
  static const String menuSpedImage = '$imageDir/menu_sped.jpg';
  static const String menuSatImage = '$imageDir/menu_sat.jpg';
  static const String menuGedImage = '$imageDir/menu_ged.jpg';
  static const String menuLojaImage = '$imageDir/menu_loja.jpg';
  static const String menuPagarImage = '$imageDir/menu_pagar.jpg';
  static const String menuVendasImage = '$imageDir/menu_vendas.jpg';
  static const String menuEstoqueImage = '$imageDir/menu_estoque.jpg';
  static const String menuReceberImage = '$imageDir/menu_receber.jpg';
  static const String menuTesourariaImage = '$imageDir/menu_tesouraria.jpg';
  static const String menuBancoImage = '$imageDir/menu_banco.jpg';
  static const String menuFluxoCaixaImage = '$imageDir/menu_fluxo_caixa.jpg';
  static const String menuConciliacaoImage = '$imageDir/menu_conciliacao.jpg';
  static const String menuTributacaoImage = '$imageDir/menu_tributacao.jpg';
  static const String menuComprasImage = '$imageDir/menu_compras.jpg';
  static const String menuAfvImage = '$imageDir/menu_afv.jpg';
  static const String menuComissoesImage = '$imageDir/menu_comissoes.jpg';
  static const String menuOsImage = '$imageDir/menu_os.jpg';
  static const String menuCrmImage = '$imageDir/menu_crm.jpg';
  static const String menuBiImage = '$imageDir/menu_bi.jpg';

  // outras imagens
  static const String suprimentoSangriaIcon =
      '$imageDir/suprimento-sangria-icon.jpg';
  static const String informaValorIcon = '$imageDir/informa-valor-icon.png';
  static const String opcoesGerenteIcon = '$imageDir/opcoes-gerente-icon.png';
  static const String caixaIcon = '$imageDir/caixa-icon.png';
  static const String pagamentoIcon = '$imageDir/pagamento-icon.png';
  static const String produtoIcon = '$imageDir/produto-icon.png';
  static const String dashboardIcon = '$imageDir/dashboard-icon.png';
  static const String parcelamentoIcon = '$imageDir/parcelas-icon.png';
  static const String dialogQuestionIcon = '$imageDir/dialog-question-icon.png';
  static const String dialogInfoIcon = '$imageDir/dialog-info-icon.png';
  static const String dialogErrorIcon = '$imageDir/dialog-error-icon.png';
  static const String nfceBanner = '$imageDir/nfce-banner.png';
  static const String premiumBanner = '$imageDir/premium-banner.png';

// #endregion Imagens

  static String? sentryDns =
      'https://c67d0e5e589a48c2b85e2946e8ac56e1@o4504571542437888.ingest.sentry.io/4504571681767424';

  // #region Catcher
  ///configuração para tratar erros em modo de debug (desenvolvimento)
  static CatcherOptions debugOptionsDialogo = CatcherOptions(
    DialogReportMode(),
    [
      SentryHandler(
        SentryClient(SentryOptions(dsn: sentryDns)),
      ),
      ConsoleHandler()
    ],
    localizationOptions: [
      LocalizationOptions.buildDefaultPortugueseOptions(),
    ],
    customParameters: {"versao-atual": versaoApp},
  );

  ///configuração para tratar erros em modo de release (produção)
  static CatcherOptions releaseOptionsDialogo = CatcherOptions(
    DialogReportMode(),
    [
      SentryHandler(
        SentryClient(SentryOptions(dsn: sentryDns)),
      ),
      ConsoleHandler(),
    ],
    localizationOptions: [
      LocalizationOptions.buildDefaultPortugueseOptions(),
    ],
    customParameters: {"versao-atual": versaoApp},
  );

  ///configuração para tratar erros em modo de debug (desenvolvimento) - modo silencioso
  static CatcherOptions debugOptionsSilencioso = CatcherOptions(
    SilentReportMode(),
    [
      SentryHandler(
        SentryClient(SentryOptions(dsn: sentryDns)),
      ),
      ConsoleHandler()
    ],
    localizationOptions: [
      LocalizationOptions.buildDefaultPortugueseOptions(),
    ],
    customParameters: {"versao-atual": versaoApp},
  );

  ///configuração para tratar erros em modo de release (produção) - modo silencioso
  static CatcherOptions releaseOptionsSilencioso = CatcherOptions(
    DialogReportMode(),
    [
      SentryHandler(
        SentryClient(SentryOptions(dsn: sentryDns)),
      ),
      ConsoleHandler(),
    ],
    localizationOptions: [
      LocalizationOptions.buildDefaultPortugueseOptions(),
    ],
    customParameters: {"versao-atual": versaoApp},
  );

  ///configuração para tratar erros em modo de debug (desenvolvimento) - modo página
  static CatcherOptions debugOptionsPagina = CatcherOptions(
    PageReportMode(),
    [
      SentryHandler(
        SentryClient(SentryOptions(dsn: sentryDns)),
      ),
      ConsoleHandler()
    ],
    localizationOptions: [
      LocalizationOptions.buildDefaultPortugueseOptions(),
    ],
    customParameters: {"versao-atual": versaoApp},
  );

  ///configuração para tratar erros em modo de release (produção) - modo página
  static CatcherOptions releaseOptionsPagina = CatcherOptions(
    ///Vai mostrar o erro numa página
    PageReportMode(),

    ///Vai mostrar o erro numa página
    // PageReportMode(showStackTrace: true),
    [
      //Manda os erros para o Sentry
      SentryHandler(
        SentryClient(SentryOptions(dsn: sentryDns)),
      ),

      ///Imprime os erros no Console
      ConsoleHandler(),
    ],
    localizationOptions: [
      LocalizationOptions.buildDefaultPortugueseOptions(),
    ],
    customParameters: {"versao-atual": versaoApp},
  );

// #endregion Catcher
}
