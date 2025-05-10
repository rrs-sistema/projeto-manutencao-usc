import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';

import './../../../infra/valida_campo_formulario.dart';
import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../view/shared/view_util_lib.dart';
import './../../../view/shared/widgets_input.dart';
import './../../../view/shared/botoes.dart';
import './../../../database/app_db.dart';
import './../../../infra/sessao.dart';
import './../../../infra/infra.dart';

class SexoPersistePage extends StatefulWidget {
  final Sexo? sexo;
  final String? title;
  final String? operacao;

  const SexoPersistePage({Key? key, this.sexo, this.title, this.operacao})
      : super(key: key);

  @override
  SexoPersistePageState createState() => SexoPersistePageState();
}

class SexoPersistePageState extends State<SexoPersistePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode _autoValidate = AutovalidateMode.disabled;
  bool _formFoiAlterado = false;

  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  final ScrollController controllerScroll = ScrollController();
  final _foco = FocusNode();

  Sexo? sexo;

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
    sexo = widget.sexo;
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
                            child: TextFormField(
                              maxLength: 100,
                              maxLines: 1,
                              initialValue: sexo?.nome ?? '',
                              decoration: getInputDecoration(
                                  'Informe o Nome', 'Nome', false),
                              onSaved: (String? value) {},
                              validator:
                                  ValidaCampoFormulario.validarAlfanumerico,
                              onChanged: (text) {
                                sexo = sexo!.copyWith(
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
          await Sessao.db.sexoDao.alterar(sexo!);
        } else {
          await Sessao.db.sexoDao.inserir(sexo!);
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
      await Sessao.db.sexoDao.excluir(sexo!);
      if (!mounted) return;
      Navigator.of(context).pop();
      showInSnackBar("Registro excluído com sucesso!", context,
          corFundo: Constantes.secondaryColor);
    });
  }
}
