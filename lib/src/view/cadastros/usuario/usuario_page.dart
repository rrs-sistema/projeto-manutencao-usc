import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_bootstrap/flutter_bootstrap.dart';
import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'dart:async';

import './../../../view/cadastros/permissao/permissao_liberada_lista_page.dart';
import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../view/shared/view_util_lib.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../database/tabelas/usuario.dart';
import './../../../controller/controller.dart';
import './../../../view/shared/botoes.dart';
import './../../../infra/sessao.dart';
import './usuario_persiste_page.dart';
import './../../../infra/infra.dart';

class UsuarioPage extends StatefulWidget {
  final UsuarioMontado? usuarioMontado;
  final String? title;
  final String? operacao;

  const UsuarioPage({this.usuarioMontado, this.title, this.operacao, Key? key})
      : super(key: key);

  @override
  UsuarioPageState createState() => UsuarioPageState();
}

class UsuarioPageState extends State<UsuarioPage>
    with TickerProviderStateMixin {
  TabController? _abasController;

  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;

  // Usuário
  final GlobalKey<FormState> _persisteFormKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<ScaffoldState> _userScaffoldKey = GlobalKey<ScaffoldState>();
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  @override
  void initState() {
    super.initState();
    _initTabs();
    bootstrapGridParameters(
      gutterSize: Constantes.flutterBootstrapGutterSize,
    );

    _shortcutMap = getAtalhosPersistePage();
    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
  }

  _initTabs() async {
    final SharedPreferences prefs = await _prefs;
    int? index = prefs.getInt("tabIdx");

    _abasController = TabController(vsync: this, length: 2);
    setState(() {
      _abasController!.index = index ?? 0;
    });

    _abasController!.addListener(() {
      prefs.setInt("tabIdx", _abasController!.index);
    });
  }

  @override
  void dispose() {
    _abasController!.dispose();
    super.dispose();
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.salvar:
        _salvarUsuario();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    bool? telaPequena = Biblioteca.isTelaPequena(context);

    return FocusableActionDetector(
        actions: _actionMap,
        shortcuts: _shortcutMap,
        child: Focus(
            autofocus: false,
            child: Scaffold(
              drawerDragStartBehavior: DragStartBehavior.down,
              key: _scaffoldKey,
              appBar: AppBar(
                title: Text(widget.title!),
                centerTitle: telaPequena! ? true : false,
                actions: widget.operacao == 'A'
                    ? _getBotoesAppBarComExclusao(
                        context, _salvarUsuario, (p0) {}, _excluir)
                    : _getBotoesAppBar(context, _salvarUsuario, (p0) {}),
                flexibleSpace: Container(
                  decoration: BoxDecoration(
                    gradient: gradienteApp(),
                  ),
                ),
                bottom: _abasController == null
                    ? null
                    : TabBar(
                        controller: _abasController,
                        tabs: const [
                          Tab(
                            text: "Usuario",
                            icon: Icon(FontAwesomeIcons.userGroup),
                          ),
                          Tab(
                            text: "Permissões",
                            icon: Icon(FontAwesomeIcons.objectGroup),
                          ),
                        ],
                      ),
              ),
              body: _abasController == null
                  ? null
                  : TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _abasController,
                      children: [
                        UsuarioPersistePage(
                          key: const Key("tabBarViewPersistePage"),
                          formKey: _persisteFormKey,
                          scaffoldKey: _userScaffoldKey,
                          usuarioMontado: widget.usuarioMontado,
                          operacao: widget.operacao,
                          salvarProdutoCallBack: _salvarUsuario,
                        ),
                        UsuarioPermissaoListaPage(
                          key: const Key("tabBarViewPermissaoLista"),
                          usuarioMontado: widget.usuarioMontado,
                          salvarProdutoCallBack: _salvarUsuario,
                        ),
                      ],
                    ),
            )));
  }

  bool _salvarForms() {
    // valida e salva os forms
    FormState? formProduto = _persisteFormKey.currentState;
    if (formProduto != null) {
      if (!formProduto.validate()) {
        _abasController!.animateTo(0);
        return false;
      } else {
        _persisteFormKey.currentState?.save();
        return true;
      }
    }

    FormState? formCardapio = _persisteFormKey.currentState;
    if (formCardapio != null) {
      if (!formCardapio.validate()) {
        _abasController!.animateTo(1);
        return false;
      } else {
        _persisteFormKey.currentState?.save();
        return true;
      }
    }
    return true;
  }

  void _salvarUsuario() async {
    if (_salvarForms()) {
      if (UsuarioController.listaUsuarioPermissao!.isEmpty) {
        showInSnackBar(
            'Ops! Você precisa informar pelo menos uma permissão para esse usuário.',
            context);
        return;
      }
      gerarDialogBoxConfirmacao(context, Constantes.perguntaSalvarAlteracoes,
          () async {
        // remove pontos do NCM e do CEST
        try {
          await _showEasyLoading(true, 'Processando os dados...');
          bool tudoCerto = false;
          if (widget.operacao == 'A') {
            await Sessao.db.usuarioDao.alterar(
              widget.usuarioMontado!.usuario!,
              UsuarioController.listaUsuarioPermissao!,
            );
            tudoCerto = true;
          } else {
            var usuarioCadastrado = await Sessao.db.usuarioDao
                .consultarObjetoFiltro(
                    'matricula', widget.usuarioMontado!.usuario!.matricula!);
            if (usuarioCadastrado != null) {
              if (!mounted) return;
              showInSnackBar(
                  'Já existe um usuário cadastrado com a matricula informada.',
                  context);
              return;
            }
            usuarioCadastrado = await Sessao.db.usuarioDao
                .consultarObjetoFiltro(
                    'email', widget.usuarioMontado!.usuario!.email!);
            if (usuarioCadastrado != null) {
              if (!mounted) return;
              showInSnackBar(
                  'Já existe um usuário cadastrado com a e-mail informada.',
                  context);
              return;
            }
            await Sessao.db.usuarioDao.inserir(widget.usuarioMontado!.usuario!,
                UsuarioController.listaUsuarioPermissao!);
            tudoCerto = true;
          }
          if (tudoCerto) {
            if (!mounted) return;
            Navigator.of(context).pop();
          }
        } finally {
          await _showEasyLoading(false, '');
        }
      });
    } else {
      showInSnackBar(
          "Por favor, corrija os erros apresentados antes de continuar.",
          context);
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
      await Sessao.db.usuarioDao.excluir(widget.usuarioMontado!.usuario!);
      if (!mounted) return;
      Navigator.of(context).pop();
    },
        mensagemPersonalizada:
            'Deseja marcar esse usuário como Inativo? Ele não será excluído do banco de dados.');
  }
}

List<Widget> _getBotoesAppBar(
    BuildContext context,
    Function() onPressedBotaoSalvar,
    Function(String) onSelectedPopupMenuButton) {
  if (Biblioteca.isTelaPequena(context)!) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
    ];
  }
}

List<Widget> _getBotoesAppBarComExclusao(
    BuildContext context,
    Function() onPressedBotaoSalvar,
    Function(String) onSelectedPopupMenuButton,
    Function? excluir) {
  if (Biblioteca.isTelaPequena(context)!) {
    return <Widget>[
      getBotaoTelaPequena(
        tooltip: Constantes.botaoExcluirDica,
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaPequena(
        tooltip: Constantes.botaoSalvarDica,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
    ];
  } else {
    return <Widget>[
      getBotaoTelaGrande(
        texto: Constantes.botaoExcluirDescricao,
        icone: ViewUtilLib.getIconBotaoExcluir(),
        onPressed: excluir,
      ),
      getBotaoTelaGrande(
        texto: Constantes.botaoSalvarDescricao,
        icone: ViewUtilLib.getIconBotaoSalvar(),
        onPressed: onPressedBotaoSalvar,
      ),
    ];
  }
}
