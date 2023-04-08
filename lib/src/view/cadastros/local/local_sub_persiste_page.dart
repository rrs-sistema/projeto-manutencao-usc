import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import './../../../view/shared/page/lookup_local_page.dart';
import './../../../infra/valida_campo_formulario.dart';
import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../database/tabelas/local_sub.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../view/shared/view_util_lib.dart';
import './../../../view/shared/widgets_input.dart';
import './../../../database/dao/local_dao.dart';
import './../../../view/shared/botoes.dart';
import './../../../infra/sessao.dart';
import './../../../infra/infra.dart';

class SubLocalPersistePage extends StatefulWidget {
  final LocalSubMontado? subLocalMontado;
  final String? title;
  final String? operacao;

  const SubLocalPersistePage(
      {Key? key, this.subLocalMontado, this.title, this.operacao})
      : super(key: key);

  @override
  SubLocalPersistePageState createState() => SubLocalPersistePageState();
}

class SubLocalPersistePageState extends State<SubLocalPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  final ScrollController controllerScroll = ScrollController();
  final _foco = FocusNode();

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

  @override
  Widget build(BuildContext context) {
    final importaLocalController = TextEditingController();
    importaLocalController.text = widget.subLocalMontado?.local?.nome ?? '';

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
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
          body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: _formKey,
              autovalidateMode: _autoValidate,
              onWillPop: _avisarUsuarioFormAlterado,
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
                                    controller: importaLocalController,
                                    readOnly: true,
                                    decoration: getInputDecoration(
                                        'Conteúdo para o campo Local',
                                        'Local *',
                                        false),
                                    onSaved: (String? value) {},
                                    onChanged: (text) {},
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Local',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      Map<String, dynamic>? objetoJsonRetorno =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LookupLocalPage(
                                                  title: 'Importar Local',
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
                                          importaLocalController.text =
                                              objetoJsonRetorno['nome'];
                                          widget.subLocalMontado!.localSub =
                                              widget.subLocalMontado!.localSub!
                                                  .copyWith(
                                            codigoLocal:
                                                objetoJsonRetorno['codigo'],
                                          );
                                          widget.subLocalMontado!.local = widget
                                              .subLocalMontado!.local!
                                              .copyWith(
                                            codigo: objetoJsonRetorno['codigo'],
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
                            sizes: 'col-12',
                            child: TextFormField(
                              maxLength: 100,
                              maxLines: 1,
                              initialValue:
                                  widget.subLocalMontado!.localSub?.nome ?? '',
                              decoration: getInputDecoration(
                                  'Informe o Nome', 'Nome', false),
                              onSaved: (String? value) {},
                              validator:
                                  ValidaCampoFormulario.validarAlfanumerico,
                              onChanged: (text) {
                                widget.subLocalMontado!.localSub =
                                    widget.subLocalMontado!.localSub!.copyWith(
                                        nome: removeCaracteresEspeciais(text));
                                _formFoiAlterado = true;
                              },
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
                            sizes: 'col-12',
                            child: Text(
                              '* indica que o campo é obrigatório',
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ),
                        ],
                      ),
                      const Divider(
                        color: Colors.white,
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

  void _filtrarLocalLookup(String campo, String valor) async {
    final listaFiltrada =
        await Sessao.db.localDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  String removeCaracteresEspeciais(String valor) {
    return Biblioteca.removeCaracteresEspeciais(valor);
  }

  Future<void> _salvar() async {
    final FormState form = _formKey.currentState!;
    if (!form.validate()) {
      _autoValidate = AutovalidateMode.always;
      showInSnackBar(Constantes.mensagemCorrijaErrosFormSalvar, context);
    } else {
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes,
          () async {
        form.save();
        if (widget.operacao == 'A') {
          await Sessao.db.localSubDao
              .alterar(widget.subLocalMontado!.localSub!);
        } else {
          await Sessao.db.localSubDao
              .inserir(widget.subLocalMontado!.localSub!);
        }
        if (!mounted) return;
        Navigator.of(context).pop();
        showInSnackBar("Registro salvo com sucesso!", context,
            corFundo: Constantes.secondaryColor);
      });
    }
  }

  Future<bool> _avisarUsuarioFormAlterado() async {
    final FormState? form = _formKey.currentState;
    if (form == null || !_formFoiAlterado) {
      return true;
    } else {
      await (gerarDialogBoxFormAlterado(context));
      return false;
    }
  }

  void _excluir() {
    gerarDialogBoxExclusao(context, () async {
      await Sessao.db.localSubDao.excluir(widget.subLocalMontado!.localSub!);
      if (!mounted) return;
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context,
          corFundo: Constantes.secondaryColor);
    });
  }
}
