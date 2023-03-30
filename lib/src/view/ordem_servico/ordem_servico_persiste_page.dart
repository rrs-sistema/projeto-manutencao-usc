import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:manutencao_usc/src/database/dao/local_dao.dart';
import 'package:manutencao_usc/src/database/dao/local_sub_dao.dart';
import 'package:manutencao_usc/src/view/shared/botoes.dart';
import 'package:manutencao_usc/src/view/shared/gradiente_app.dart';

import './../../view/shared/page/lookup_local_page.dart';
import './../../database/tabelas/ordem_servico.dart';
import './../../infra/valida_campo_formulario.dart';
import './../../view/shared/caixas_de_dialogo.dart';
import './../../database/dao/categoria_dao.dart';
import './../../infra/atalhos_desktop_web.dart';
import './../../view/shared/view_util_lib.dart';
import './../../view/shared/widgets_input.dart';
import './../../infra/biblioteca.dart';
import './../../infra/constantes.dart';
import './../../infra/sessao.dart';

class OrdemServicoPersistePage extends StatefulWidget {
  final OrdemServicoMontada? ordemServicoMontado;
  final String? operacao;
  final String? title;
  final FocusNode? foco;

  const OrdemServicoPersistePage(
      {Key? key,
      this.ordemServicoMontado,
      this.foco,
      this.operacao,
      this.title})
      : super(key: key);

  @override
  OrdemServicoPersistePageState createState() =>
      OrdemServicoPersistePageState();
}

class OrdemServicoPersistePageState extends State<OrdemServicoPersistePage> {
  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  final _foco = FocusNode();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  final ScrollController controllerScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );
    _shortcutMap = getAtalhosPersistePage();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    _foco.requestFocus();
    if (controllerScroll.hasClients) {
      controllerScroll.jumpTo(50.0);
    }
    //WidgetsBinding.instance.addPostFrameCallback((_) => _carregarImagens());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.excluir:
        _excluir();
        break;
      case AtalhoTelaType.salvar:
        _salvar();
        break;
      default:
        break;
    }
  }

  Future<void> _salvar() async {
    FormState? formCadastro = _formKey.currentState;
    if (formCadastro != null) {
      if (formCadastro.validate()) {
        gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes,
            () async {
          await _showEasyLoading(true, 'Processando os dados...');
          try {
            if (widget.operacao == 'A') {
              await Sessao.db.ordemServicoDao
                  .alterar(widget.ordemServicoMontado!);
            } else {
              await Sessao.db.ordemServicoDao.inserir(
                widget.ordemServicoMontado!,
              );
            }
            if (!mounted) return;
            Navigator.of(context).pop();
          } finally {
            await _showEasyLoading(false, '');
          }
        });
      }
    }
  }

  Future<void> _showEasyLoading(bool show, String status) async {
    if (show) {
      await EasyLoading.show(
          status: status,
          maskType: EasyLoadingMaskType.custom,
          dismissOnTap: false);
    } else {
      await EasyLoading.dismiss();
    }
  }

  void _excluir() {
    gerarDialogBoxExclusao(context, () async {
      await Sessao.db.ordemServicoDao.excluir(widget.ordemServicoMontado!);
      if (!mounted) return;
      Navigator.of(context).pop();
    }, mensagemPersonalizada: 'Deseja marcar essa ordem de serviço como?');
  }

  @override
  Widget build(BuildContext context) {
    final importaCategoriaController = TextEditingController();
    importaCategoriaController.text =
        widget.ordemServicoMontado?.categoria?.nome ?? '';
    final importaLocalController = TextEditingController();
    importaLocalController.text = widget.ordemServicoMontado?.local?.nome ?? '';

    final importaCodigoLocalController = TextEditingController();
    importaCodigoLocalController.text =
        widget.ordemServicoMontado?.local?.codigo.toString() ?? '';

    final importaLocalSubController = TextEditingController();
    importaLocalSubController.text =
        widget.ordemServicoMontado?.localSub?.nome ?? '';

    final importaStatusController = TextEditingController();
    importaStatusController.text =
        widget.ordemServicoMontado?.statusOrdemServico?.nome ?? '';

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title!),
            centerTitle:
                Biblioteca.isTelaPequena(context) == true ? true : false,
            actions: widget.operacao == 'I'
                ? getBotoesAppBarPersistePage(
                    context: context,
                    salvar: _salvar,
                  )
                : getBotoesAppBarPersistePageComExclusao(
                    context: context, salvar: _salvar, excluir: _excluir),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: gradienteApp(),
              ),
            ),
          ),
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.always,
              child: Scrollbar(
                controller: controllerScroll,
                child: SingleChildScrollView(
                  controller: controllerScroll,
                  physics: const ScrollPhysics(),
                  dragStartBehavior: DragStartBehavior.down,
                  child: BootstrapContainer(
                    fluid: true,
                    decoration: const BoxDecoration(color: Colors.white),
                    padding: Biblioteca.isTelaPequena(context) == true
                        ? ViewUtilLib.paddingBootstrapContainerTelaPequena
                        : ViewUtilLib.paddingBootstrapContainerTelaGrande,
                    children: <Widget>[
                      const Divider(
                        color: Colors.white,
                      ),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: _foco,
                                    validator: ValidaCampoFormulario
                                        .validarObrigatorio,
                                    controller: importaCategoriaController,
                                    readOnly: true,
                                    decoration: getInputDecoration(
                                        'Conteúdo para o campo Categoria',
                                        'Categoria *',
                                        false),
                                    onSaved: (String? value) {},
                                    onChanged: (text) {
                                      //paginaMestreDetalheFoiAlterada = true;
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Categoria',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic>? objetoJsonRetorno =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LookupLocalPage(
                                                  title: 'Importar Categoria',
                                                  colunas: CategoriaDao.colunas,
                                                  campos: CategoriaDao.campos,
                                                  campoPesquisaPadrao: 'nome',
                                                  valorPesquisaPadrao: '%',
                                                  metodoConsultaCallBack:
                                                      _filtrarCategoriaLookup,
                                                  permiteCadastro: true,
                                                  metodoCadastroCallBack: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/categoriaLista',
                                                    );
                                                  },
                                                ),
                                                fullscreenDialog: true,
                                              ));
                                      if (objetoJsonRetorno != null) {
                                        if (objetoJsonRetorno['nome'] != null) {
                                          importaCategoriaController.text =
                                              objetoJsonRetorno['nome'];

                                          widget.ordemServicoMontado!
                                                  .ordemServico =
                                              widget.ordemServicoMontado!
                                                  .ordemServico!
                                                  .copyWith(
                                                      codigoCategoria:
                                                          objetoJsonRetorno[
                                                              'codigo']);

                                          widget.ordemServicoMontado!
                                                  .categoria =
                                              widget.ordemServicoMontado!
                                                  .categoria!
                                                  .copyWith(
                                            nome: objetoJsonRetorno['nome'],
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: _foco,
                                    validator: ValidaCampoFormulario
                                        .validarObrigatorio,
                                    controller: importaLocalController,
                                    readOnly: true,
                                    decoration: getInputDecoration(
                                        'Conteúdo para o campo área',
                                        'Área *',
                                        false),
                                    onSaved: (String? value) {},
                                    onChanged: (text) {
                                      //paginaMestreDetalheFoiAlterada = true;
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar área',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic>? objetoJsonRetorno =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LookupLocalPage(
                                                  title: 'Importar Área',
                                                  colunas: LocalDao.colunas,
                                                  campos: LocalDao.campos,
                                                  campoPesquisaPadrao: 'nome',
                                                  valorPesquisaPadrao: '%',
                                                  metodoConsultaCallBack:
                                                      _filtrarLocalLookup,
                                                  permiteCadastro: true,
                                                  metodoCadastroCallBack: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/localLista',
                                                    );
                                                  },
                                                ),
                                                fullscreenDialog: true,
                                              ));
                                      if (objetoJsonRetorno != null) {
                                        if (objetoJsonRetorno['nome'] != null) {
                                          widget.ordemServicoMontado!
                                                  .ordemServico =
                                              widget.ordemServicoMontado!
                                                  .ordemServico!
                                                  .copyWith(
                                                      codigoLocal:
                                                          objetoJsonRetorno[
                                                              'codigo']);

                                          widget.ordemServicoMontado!.local =
                                              widget.ordemServicoMontado!.local!
                                                  .copyWith(
                                            nome: objetoJsonRetorno['nome'],
                                          );

                                          setState(() {
                                            importaLocalController.text =
                                                objetoJsonRetorno['nome'];
                                            widget.ordemServicoMontado!.local =
                                                widget
                                                    .ordemServicoMontado!.local!
                                                    .copyWith(
                                                        codigo:
                                                            objetoJsonRetorno[
                                                                'codigo'],
                                                        nome: objetoJsonRetorno[
                                                            'nome']);
                                            importaCodigoLocalController.text =
                                                objetoJsonRetorno['codigo']
                                                    .toString();
                                          });
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                          BootstrapCol(
                            sizes: 'col-12 col-md-6',
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: _foco,
                                    validator: ValidaCampoFormulario
                                        .validarObrigatorio,
                                    controller: importaLocalSubController,
                                    readOnly: true,
                                    decoration: getInputDecoration(
                                        'Conteúdo para o campo local da área',
                                        'Local da área *',
                                        false),
                                    onSaved: (String? value) {},
                                    onChanged: (text) {
                                      //paginaMestreDetalheFoiAlterada = true;
                                    },
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar local da área',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      ///chamando o lookup
                                      Map<String, dynamic>? objetoJsonRetorno =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LookupLocalPage(
                                                  title:
                                                      'Importar local de ${widget.ordemServicoMontado!.local!.nome}',
                                                  colunas: LocalSubDao.colunas,
                                                  campos: LocalSubDao.campos,
                                                  campoPesquisaPadrao:
                                                      'codigo_local',
                                                  valorPesquisaPadrao:
                                                      importaCodigoLocalController
                                                          .text,
                                                  metodoConsultaCallBack:
                                                      _filtrarSubLocalLookup,
                                                  permiteCadastro: true,
                                                  bloquearTela: true,
                                                  metodoCadastroCallBack: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/localSubLista',
                                                    );
                                                  },
                                                ),
                                                fullscreenDialog: true,
                                              ));
                                      if (objetoJsonRetorno != null) {
                                        if (objetoJsonRetorno['nome'] != null) {
                                          importaLocalSubController.text =
                                              objetoJsonRetorno['nome'];

                                          widget.ordemServicoMontado!
                                                  .ordemServico =
                                              widget.ordemServicoMontado!
                                                  .ordemServico!
                                                  .copyWith(
                                                      codigoSubLocal:
                                                          objetoJsonRetorno[
                                                              'codigo']);

                                          widget.ordemServicoMontado!.localSub =
                                              widget.ordemServicoMontado!
                                                  .localSub!
                                                  .copyWith(
                                            nome: objetoJsonRetorno['nome'],
                                          );
                                        }
                                      }
                                    },
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
                      ),
                      if (widget.operacao == 'A') ...[
                        const Divider(
                          color: Colors.white,
                        ),
                        BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: Row(
                                children: <Widget>[
                                  Expanded(
                                    flex: 1,
                                    child: TextFormField(
                                      focusNode: _foco,
                                      validator: ValidaCampoFormulario
                                          .validarObrigatorio,
                                      controller: importaStatusController,
                                      readOnly: true,
                                      decoration: getInputDecoration(
                                          'Conteúdo para o campo status',
                                          'Status *',
                                          false),
                                      onSaved: (String? value) {},
                                      onChanged: (text) {},
                                    ),
                                  ),
                                  Expanded(
                                    flex: 0,
                                    child: IconButton(
                                      tooltip: 'Importar Status',
                                      icon: ViewUtilLib.getIconBotaoLookup(),
                                      onPressed: () async {
                                        ///chamando o lookup
                                        Map<String, dynamic>?
                                            objetoJsonRetorno =
                                            await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          LookupLocalPage(
                                                    title:
                                                        'Importar status da ordem',
                                                    colunas:
                                                        CategoriaDao.colunas,
                                                    campos: CategoriaDao.campos,
                                                    campoPesquisaPadrao: 'nome',
                                                    valorPesquisaPadrao: '%',
                                                    metodoConsultaCallBack:
                                                        _filtrarStatusLookup,
                                                    permiteCadastro: true,
                                                    metodoCadastroCallBack: () {
                                                      Navigator.pushNamed(
                                                        context,
                                                        '/statusOrdemServicoLista',
                                                      );
                                                    },
                                                  ),
                                                  fullscreenDialog: true,
                                                ));
                                        if (objetoJsonRetorno != null) {
                                          if (objetoJsonRetorno['nome'] !=
                                              null) {
                                            importaStatusController.text =
                                                objetoJsonRetorno['nome'];

                                            widget.ordemServicoMontado!
                                                    .ordemServico =
                                                widget.ordemServicoMontado!
                                                    .ordemServico!
                                                    .copyWith(
                                                        codigoStatus:
                                                            objetoJsonRetorno[
                                                                'codigo']);

                                            widget.ordemServicoMontado!
                                                    .statusOrdemServico =
                                                widget.ordemServicoMontado!
                                                    .statusOrdemServico!
                                                    .copyWith(
                                              nome: objetoJsonRetorno['nome'],
                                            );
                                          }
                                        }
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                      const Divider(
                        color: Colors.white,
                      ),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: TextFormField(
                              validator: ValidaCampoFormulario
                                  .validarObrigatorioTestoLongo,
                              maxLength: 250,
                              maxLines: 3,
                              initialValue: widget.ordemServicoMontado!
                                      .ordemServico?.descricaoProblema ??
                                  '',
                              decoration: getInputDecoration(
                                  'Conteúdo para o campo descrição do problema',
                                  'Descrição do problema *',
                                  false),
                              onSaved: (String? value) {},
                              onChanged: (text) {
                                widget.ordemServicoMontado!.ordemServico =
                                    widget
                                        .ordemServicoMontado!.ordemServico!
                                        .copyWith(
                                            descricaoProblema:
                                                removeCaracteresEspeciais(
                                                    text));
                              },
                            ),
                          ),
                        ],
                      ),
                      if (widget.operacao == 'A') ...[
                        const Divider(
                          color: Colors.white,
                        ),
                        BootstrapRow(
                          height: 60,
                          children: <BootstrapCol>[
                            BootstrapCol(
                              sizes: 'col-12',
                              child: TextFormField(
                                maxLength: 250,
                                maxLines: 3,
                                initialValue: widget.ordemServicoMontado!
                                        .ordemServico?.descricaoSolucao ??
                                    '',
                                decoration: getInputDecoration(
                                    'Conteúdo para o campo solução do problema',
                                    'Solução do problema',
                                    false),
                                onSaved: (String? value) {},
                                onChanged: (text) {
                                  widget.ordemServicoMontado!.ordemServico =
                                      widget
                                          .ordemServicoMontado!.ordemServico!
                                          .copyWith(
                                              descricaoSolucao:
                                                  removeCaracteresEspeciais(
                                                      text));
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                      const Divider(
                        color: Colors.white,
                      ),
                      BootstrapRow(
                        height: 60,
                        children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: 'col-12',
                            child: Text(
                              '* indica que o campo é obrigatório',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _filtrarCategoriaLookup(String campo, String valor) async {
    final listaFiltrada =
        await Sessao.db.categoriaDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  String removeCaracteresEspeciais(String valor) {
    return Biblioteca.removeCaracteresEspeciais(valor);
  }

  void _filtrarLocalLookup(String campo, String valor) async {
    final listaFiltrada =
        await Sessao.db.localDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _filtrarSubLocalLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.localSubDao.consultarListaFiltro(
        'codigo_local', widget.ordemServicoMontado!.local!.codigo.toString());
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _filtrarStatusLookup(String campo, String valor) async {
    final listaFiltrada = await Sessao.db.statusOrdemServicoDao
        .consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  int definirQuantidadeDeCartoesPorLinha(BuildContext context) {
    double larguraDaTela = MediaQuery.of(context).size.width;
    int larguraDoCartao = 150;
    int quantidadePorLinha = larguraDaTela ~/ larguraDoCartao;
    return quantidadePorLinha;
  }
}
