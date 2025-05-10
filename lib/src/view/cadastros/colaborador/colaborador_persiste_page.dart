import 'dart:async';
import 'dart:convert';

import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:manutencao_usc/src/database/app_db.dart';
import 'package:manutencao_usc/src/database/dao/sexo_dao.dart';

import './../../../view/shared/page/lookup_local_page.dart';
import './../../../infra/valida_campo_formulario.dart';
import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../database/dao/estado_civil_dao.dart';
import './../../../database/tabelas/colaborador.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../view/shared/view_util_lib.dart';
import './../../../view/shared/widgets_input.dart';
import './../../../view/shared/botoes.dart';
import './../../../infra/sessao.dart';
import './../../../infra/infra.dart';

class ColaboradorPersistePage extends StatefulWidget {
  final ColaboradorMontado? montado;
  final String? title;
  final String? operacao;

  const ColaboradorPersistePage(
      {Key? key, this.montado, this.title, this.operacao})
      : super(key: key);

  @override
  ColaboradorPersistePageState createState() => ColaboradorPersistePageState();
}

class ColaboradorPersistePageState extends State<ColaboradorPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  final ScrollController controllerScroll = ScrollController();
  final importaSexoController = TextEditingController();
  final textEditingCelularController = TextEditingController();
  final textEditingTelefoneController = TextEditingController();
  Sexo? _sexo;
  final _foco = FocusNode();

  @override
  void initState() {
    super.initState();
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );
    _sexo = widget.montado?.sexo;

    _shortcutMap = getAtalhosPersistePage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
    _foco.requestFocus();
    textEditingCelularController.text = UtilBrasilFields.obterTelefone(
        widget.montado!.colaborador?.celular ?? '00000000000');
    textEditingTelefoneController.text = UtilBrasilFields.obterTelefone(
        widget.montado!.colaborador?.telefone ?? '00000000000');

    importaSexoController.text = _sexo?.nome ?? '';
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
    final importaEstadoCivilController = TextEditingController();
    importaEstadoCivilController.text = widget.montado?.estadoCivil?.nome ?? '';

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
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-6'
                                : 'col-12',
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: _foco,
                                    validator: ValidaCampoFormulario
                                        .validarObrigatorio,
                                    controller: importaEstadoCivilController,
                                    readOnly: true,
                                    decoration: getInputDecoration(
                                        'Conteúdo para o campo estado civil',
                                        'Estado civil *',
                                        false),
                                    onSaved: (String? value) {},
                                    onChanged: (text) {},
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Estado Civil',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      Map<String, dynamic>? objetoJsonRetorno =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LookupLocalPage(
                                                  title:
                                                      'Importar Estado Civil',
                                                  colunas:
                                                      EstadoCivilDao.colunas,
                                                  campos: EstadoCivilDao.campos,
                                                  campoPesquisaPadrao: 'nome',
                                                  valorPesquisaPadrao: '%',
                                                  metodoConsultaCallBack:
                                                      _filtrarEstadoCivilLookup,
                                                  permiteCadastro: true,
                                                  metodoCadastroCallBack: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/localEstadoCivil',
                                                    );
                                                  },
                                                ),
                                                fullscreenDialog: true,
                                              ));
                                      if (objetoJsonRetorno != null) {
                                        if (objetoJsonRetorno['nome'] != null) {
                                          importaEstadoCivilController.text =
                                              objetoJsonRetorno['nome'];
                                          widget.montado!.colaborador = widget
                                              .montado!.colaborador!
                                              .copyWith(
                                            codigoEstadoCivil:
                                                objetoJsonRetorno['codigo'],
                                          );
                                          widget.montado!.colaborador = widget
                                              .montado!.colaborador!
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
                          BootstrapCol(
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-6'
                                : 'col-12',
                            child: Row(
                              children: <Widget>[
                                Expanded(
                                  flex: 1,
                                  child: TextFormField(
                                    focusNode: _foco,
                                    validator: ValidaCampoFormulario
                                        .validarObrigatorio,
                                    controller: importaSexoController,
                                    readOnly: true,
                                    decoration: getInputDecoration(
                                        'Conteúdo para o campo sexo',
                                        'Sexo *',
                                        false),
                                    onSaved: (String? value) {},
                                    onChanged: (text) {},
                                  ),
                                ),
                                Expanded(
                                  flex: 0,
                                  child: IconButton(
                                    tooltip: 'Importar Sexo',
                                    icon: ViewUtilLib.getIconBotaoLookup(),
                                    onPressed: () async {
                                      Map<String, dynamic>? objetoJsonRetorno =
                                          await Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        LookupLocalPage(
                                                  title: 'Importar Sexo',
                                                  colunas: SexoDao.colunas,
                                                  campos: SexoDao.campos,
                                                  campoPesquisaPadrao: 'nome',
                                                  valorPesquisaPadrao: '%',
                                                  metodoConsultaCallBack:
                                                      _filtrarSexoLookup,
                                                  permiteCadastro: true,
                                                  metodoCadastroCallBack: () {
                                                    Navigator.pushNamed(
                                                      context,
                                                      '/listaSexo',
                                                    );
                                                  },
                                                ),
                                                fullscreenDialog: true,
                                              ));
                                      if (objetoJsonRetorno != null) {
                                        if (objetoJsonRetorno['nome'] != null) {
                                          importaSexoController.text =
                                              objetoJsonRetorno['nome'];
                                          widget.montado!.colaborador = widget
                                              .montado!.colaborador!
                                              .copyWith(
                                            codigoSexo:
                                                objetoJsonRetorno['codigo'],
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
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-4'
                                : 'col-12',
                            child: TextFormField(
                              maxLength: 20,
                              maxLines: 1,
                              initialValue:
                                  widget.montado!.colaborador?.matricula ?? '',
                              decoration: getInputDecoration(
                                  'Informe o matricula', 'Matricula', false),
                              onSaved: (String? value) {},
                              validator:
                                  ValidaCampoFormulario.validarAlfanumerico,
                              onChanged: (text) {
                                widget.montado!.colaborador =
                                    widget.montado!.colaborador!.copyWith(
                                        matricula:
                                            removeCaracteresEspeciais(text));
                                _formFoiAlterado = true;
                              },
                            ),
                          ),
                          BootstrapCol(
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-8'
                                : 'col-12',
                            child: TextFormField(
                              maxLength: 100,
                              maxLines: 1,
                              initialValue:
                                  widget.montado!.colaborador?.nome ?? '',
                              decoration: getInputDecoration(
                                  'Informe o nome', 'Nome', false),
                              onSaved: (String? value) {},
                              validator:
                                  ValidaCampoFormulario.validarAlfanumerico,
                              onChanged: (text) {
                                widget.montado!.colaborador =
                                    widget.montado!.colaborador!.copyWith(
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
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-6'
                                : 'col-12',
                            child: TextFormField(
                              maxLines: 1,
                              controller: textEditingTelefoneController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter(),
                              ],
                              decoration: getInputDecoration(
                                  'Conteúdo para o campo telefone',
                                  'Telefone',
                                  false),
                              onSaved: (String? value) {},
                              onChanged: (text) {
                                widget.montado!.colaborador =
                                    widget.montado!.colaborador!.copyWith(
                                        telefone:
                                            removeCaracteresEspeciais(text));
                              },
                            ),
                          ),
                          BootstrapCol(
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-6'
                                : 'col-12',
                            child: TextFormField(
                              maxLines: 1,
                              controller: textEditingCelularController,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                                TelefoneInputFormatter(),
                              ],
                              decoration: getInputDecoration(
                                  'Conteúdo para o campo celular',
                                  'Celular',
                                  false),
                              onSaved: (String? value) {},
                              onChanged: (text) {
                                widget.montado!.colaborador =
                                    widget.montado!.colaborador!.copyWith(
                                        celular:
                                            removeCaracteresEspeciais(text));
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
                            child: Padding(
                              padding:
                                  Biblioteca.distanciaEntreColunasQuebraLinha(
                                      context)!,
                              child: TextFormField(
                                validator:
                                    ValidaCampoFormulario.validarObrigatorio,
                                maxLength: 254,
                                maxLines: 1,
                                initialValue:
                                    widget.montado!.colaborador?.email ?? '',
                                decoration: getInputDecoration(
                                    'Conteúdo para o campo email',
                                    'E-mail',
                                    false),
                                onSaved: (String? value) {},
                                onChanged: (text) {
                                  widget.montado!.colaborador = widget
                                      .montado!.colaborador!
                                      .copyWith(email: text);
                                },
                              ),
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
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-6'
                                : 'col-12',
                            child: Padding(
                              padding:
                                  Biblioteca.distanciaEntreColunasQuebraLinha(
                                      context)!,
                              child: InputDecorator(
                                baseStyle: const TextStyle(
                                  color: Colors.black,
                                ),
                                decoration: getInputDecoration(
                                  '',
                                  'Data de admissão',
                                  true,
                                ),
                                isEmpty:
                                    widget.montado!.colaborador!.dataAdmissao ==
                                        null,
                                child: DatePickerItem(
                                  colorTextStyle: Colors.black,
                                  mascara: 'dd/MM/yyyy',
                                  dateTime:
                                      widget.montado!.colaborador!.dataAdmissao,
                                  firstDate: DateTime.parse('1900-01-01'),
                                  lastDate: DateTime.now(),
                                  onChanged: (DateTime? value) {
                                    setState(() {
                                      widget.montado!.colaborador = widget
                                          .montado!.colaborador!
                                          .copyWith(dataAdmissao: value);
                                    });
                                  },
                                ),
                              ),
                            ),
                          ),
                          if (widget.operacao == 'A') ...[
                            BootstrapCol(
                              sizes: Biblioteca.isDesktop()
                                  ? 'col-12 col-md-6'
                                  : 'col-12',
                              child: Padding(
                                padding:
                                    Biblioteca.distanciaEntreColunasQuebraLinha(
                                        context)!,
                                child: InputDecorator(
                                  decoration: getInputDecoration(
                                      '', 'Data de demissao', true),
                                  isEmpty: widget
                                          .montado!.colaborador!.dataDemissao ==
                                      null,
                                  child: DatePickerItem(
                                    mascara: 'dd/MM/yyyy',
                                    dateTime: widget
                                        .montado!.colaborador!.dataDemissao,
                                    firstDate: DateTime.parse('1900-01-01'),
                                    lastDate: DateTime.now(),
                                    onChanged: (DateTime? value) {
                                      setState(() {
                                        widget.montado!.colaborador = widget
                                            .montado!.colaborador!
                                            .copyWith(dataDemissao: value);
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ),
                          ]
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

  void _filtrarSexoLookup(String campo, String valor) async {
    final listaFiltrada =
        await Sessao.db.sexoDao.consultarListaFiltro(campo, valor);
    Sessao.retornoJsonLookup = jsonEncode(listaFiltrada);
  }

  void _filtrarEstadoCivilLookup(String campo, String valor) async {
    final listaFiltrada =
        await Sessao.db.estadoCivilDao.consultarListaFiltro(campo, valor);
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
          await Sessao.db.colaboradorDao.alterar(widget.montado!.colaborador!);
        } else {
          await Sessao.db.colaboradorDao.inserir(widget.montado!.colaborador!);
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
      await Sessao.db.colaboradorDao.excluir(widget.montado!.colaborador!);
      if (!mounted) return;
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context,
          corFundo: Constantes.secondaryColor);
    });
  }
}
