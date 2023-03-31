import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:brasil_fields/brasil_fields.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:manutencao_usc/src/database/tabelas/usuario.dart';

import './../../../infra/valida_campo_formulario.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../view/shared/view_util_lib.dart';
import './../../../view/shared/widgets_input.dart';
import './../../../view/shared/widgets_abas.dart';
import './../../../controller/controller.dart';
import './../../../infra/sessao.dart';
import './../../../infra/infra.dart';

class UsuarioPersistePage extends StatefulWidget {
  final UsuarioMontado? usuarioMontado;
  final String? operacao;
  final GlobalKey<FormState>? formKey;
  final GlobalKey<ScaffoldState>? scaffoldKey;
  final Function? salvarProdutoCallBack;
  final Function? atualizarProdutoCallBack;

  const UsuarioPersistePage(
      {Key? key,
      this.formKey,
      this.scaffoldKey,
      this.usuarioMontado,
      this.operacao,
      this.salvarProdutoCallBack,
      this.atualizarProdutoCallBack})
      : super(key: key);

  @override
  UsuarioPersistePageState createState() => UsuarioPersistePageState();
}

class UsuarioPersistePageState extends State<UsuarioPersistePage>
    with AutomaticKeepAliveClientMixin {
  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  final _foco = FocusNode();

  final ScrollController controllerScroll = ScrollController();

  final textEditingCelularController = TextEditingController();

  @override
  void initState() {
    super.initState();
    UsuarioController.listaUsuarioPermissao = [];
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
    WidgetsBinding.instance.addPostFrameCallback((_) => _carregarPermissoes());
    textEditingCelularController.text = UtilBrasilFields.obterTelefone(
        widget.usuarioMontado?.usuario?.celular ?? '00000000000');
  }

  Future _carregarPermissoes() async {
    if (widget.usuarioMontado?.usuario != null &&
        widget.usuarioMontado?.usuario?.codigo != null) {
      UsuarioController.listaUsuarioPermissao =
          await Sessao.db.usuarioPermissaoDao.consultarListaMontado(
              campo: 'codigo_usuario',
              valor: widget.usuarioMontado?.usuario!.codigo.toString());
      setState(() {});
    }
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      // case AtalhoTelaType.excluir:
      //   _excluir();
      //   break;
      case AtalhoTelaType.salvar:
        widget.salvarProdutoCallBack!();
        break;
      default:
        break;
    }
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: widget.scaffoldKey,
          body: SafeArea(
            top: false,
            bottom: false,
            child: Form(
              key: widget.formKey,
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
                              child: TextFormField(
                                validator:
                                    ValidaCampoFormulario.validarObrigatorio,
                                maxLength: 14,
                                maxLines: 1,
                                initialValue:
                                    widget.usuarioMontado?.usuario?.matricula ??
                                        '',
                                decoration: getInputDecoration(
                                    'Conteúdo para o campo matricula',
                                    'Matricula',
                                    false),
                                onSaved: (String? value) {},
                                onChanged: (text) {
                                  widget.usuarioMontado?.usuario =
                                      widget.usuarioMontado?.usuario!.copyWith(
                                          matricula:
                                              removeCaracteresEspeciais(text));
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-6'
                                : 'col-12',
                            child: Padding(
                              padding:
                                  Biblioteca.distanciaEntreColunasQuebraLinha(
                                      context)!,
                              child: TextFormField(
                                validator:
                                    ValidaCampoFormulario.validarObrigatorio,
                                maxLength: 50,
                                maxLines: 1,
                                initialValue:
                                    widget.usuarioMontado?.usuario?.nome ?? '',
                                decoration: getInputDecoration(
                                    'Conteúdo para o campo nome',
                                    'Nome',
                                    false),
                                onSaved: (String? value) {},
                                onChanged: (text) {
                                  widget.usuarioMontado!.usuario =
                                      widget.usuarioMontado!.usuario!.copyWith(
                                          nome:
                                              removeCaracteresEspeciais(text));
                                  paginaMestreDetalheFoiAlterada = true;
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
                            child: TextFormField(
                              validator:
                                  ValidaCampoFormulario.validarObrigatorio,
                              maxLength: 254,
                              maxLines: 1,
                              initialValue:
                                  widget.usuarioMontado?.usuario?.email ?? '',
                              decoration: getInputDecoration(
                                  'Conteúdo para o campo email',
                                  'E-mail',
                                  false),
                              onSaved: (String? value) {},
                              onChanged: (text) {
                                widget.usuarioMontado!.usuario =
                                    widget.usuarioMontado!.usuario!.copyWith(
                                        email: removeCaracteresEspeciais(text));
                                paginaMestreDetalheFoiAlterada = true;
                              },
                            ),
                          ),
                          BootstrapCol(
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-6'
                                : 'col-12',
                            child: TextFormField(
                              maxLength: 15,
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
                                widget.usuarioMontado!.usuario =
                                    widget.usuarioMontado!.usuario!.copyWith(
                                        celular:
                                            removeCaracteresEspeciais(text));
                                paginaMestreDetalheFoiAlterada = true;
                              },
                            ),
                          ),
                        ],
                      ),
                      if (widget.operacao != 'A') ...[
                        const Divider(
                          color: Colors.white,
                        ),
                        BootstrapRow(height: 60, children: <BootstrapCol>[
                          BootstrapCol(
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-6'
                                : 'col-12',
                            child: Padding(
                              padding:
                                  Biblioteca.distanciaEntreColunasQuebraLinha(
                                      context)!,
                              child: TextFormField(
                                obscureText: true,
                                validator: widget.operacao == 'I'
                                    ? ValidaCampoFormulario.validarObrigatorio
                                    : null,
                                maxLength: 254,
                                maxLines: 1,
                                initialValue:
                                    widget.usuarioMontado?.usuario?.senha ?? '',
                                decoration: getInputDecoration(
                                    'Conteúdo para o campo senha',
                                    'Senha',
                                    false),
                                onSaved: (String? value) {},
                                onChanged: (text) {
                                  widget.usuarioMontado!.usuario = widget
                                      .usuarioMontado!.usuario!
                                      .copyWith(senha: text);
                                  paginaMestreDetalheFoiAlterada = true;
                                },
                              ),
                            ),
                          ),
                          BootstrapCol(
                            sizes: Biblioteca.isDesktop()
                                ? 'col-12 col-md-6'
                                : 'col-12',
                            child: Padding(
                              padding:
                                  Biblioteca.distanciaEntreColunasQuebraLinha(
                                      context)!,
                              child: TextFormField(
                                obscureText: true,
                                validator: (value) {
                                  if (widget.usuarioMontado != null &&
                                      widget.usuarioMontado?.usuario != null &&
                                      widget.usuarioMontado?.usuario?.senha !=
                                          null &&
                                      widget.usuarioMontado?.usuario?.senha! !=
                                          value) {
                                    return 'A senha não confere';
                                  }
                                },
                                maxLength: 254,
                                maxLines: 1,
                                initialValue:
                                    widget.usuarioMontado?.usuario?.senha ?? '',
                                decoration: getInputDecoration(
                                    'Conteúdo para o campo confirmação da senha',
                                    'Confirmação da senha',
                                    false),
                                onSaved: (String? value) {},
                                onChanged: (text) {
                                  if (widget.usuarioMontado?.usuario?.senha !=
                                      text) {
                                    ValidaCampoFormulario.validarObrigatorio(
                                        'Senha não confere');
                                  }
                                },
                              ),
                            ),
                          ),
                        ]),
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

  String removeCaracteresEspeciais(String valor) {
    return Biblioteca.removeCaracteresEspeciais(valor);
  }
}
