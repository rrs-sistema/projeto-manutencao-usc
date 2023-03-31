import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:manutencao_usc/src/database/tabelas/usuario.dart';

import './../../../view/cadastros/permissao/permissao_padrao_lookup_page.dart';
import './../../../database/tabelas/usuario_permissao.dart';
import './../../../view/shared/view_util_lib.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../controller/controller.dart';
import './../../../infra/constantes.dart';
import './../../../database/app_db.dart';

class UsuarioPermissaoListaPage extends StatefulWidget {
  final UsuarioMontado? usuarioMontado;
  final FocusNode? foco;
  final Function? salvarProdutoCallBack;

  const UsuarioPermissaoListaPage(
      {Key? key, this.usuarioMontado, this.foco, this.salvarProdutoCallBack})
      : super(key: key);

  @override
  UsuarioPermissaoListaPageState createState() =>
      UsuarioPermissaoListaPageState();
}

class UsuarioPermissaoListaPageState extends State<UsuarioPermissaoListaPage> {
  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController controllerScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosAbaPage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };

    if (controllerScroll.hasClients) {
      controllerScroll.jumpTo(50.0);
    }
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.inserir:
        _inserir();
        break;
      case AtalhoTelaType.salvar:
        widget.salvarProdutoCallBack!();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: FocusableActionDetector(
        actions: _actionMap,
        shortcuts: _shortcutMap,
        child: Focus(
          key: const Key('permissaoLiberadaLista'),
          child: Scaffold(
            drawerDragStartBehavior: DragStartBehavior.down,
            key: _scaffoldKey,
            floatingActionButton: FloatingActionButton(
                focusNode: widget.foco,
                autofocus: true,
                focusColor: ViewUtilLib.getBotaoFocusColor(),
                tooltip: Constantes.botaoInserirDica,
                backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
                child: ViewUtilLib.getIconBotaoInserir(),
                onPressed: () {
                  _inserir();
                }),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            body: Scrollbar(
              controller: controllerScroll,
              child: ListView(
                controller: controllerScroll,
                padding: const EdgeInsets.all(2.0),
                children: <Widget>[
                  const Divider(
                    color: Colors.black,
                  ),
                  Text(
                    'Permissões do(a) usuario(a): ${widget.usuarioMontado?.usuario?.nome ?? ''}',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 18.0,
                        color: Colors.blue,
                        fontStyle: FontStyle.italic),
                  ),
                  const Divider(
                    color: Colors.black,
                  ),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Card(
                      color: Colors.white,
                      elevation: 2.0,
                      child:
                          DataTable(columns: _getColumns(), rows: _getRows()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _inserir() async {
    final retorno = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => const PermissaoPadraoLookupPage(),
          fullscreenDialog: true,
        ));
    if (retorno is List<Permissao>) {
      for (var i = 0; i < retorno.length; i++) {
        UsuarioPermissaoMontado userPermission = UsuarioPermissaoMontado();
        userPermission.permissao = retorno[i];
        userPermission.usuario = Usuario();
        userPermission.usuario = widget.usuarioMontado?.usuario;
        UsuarioController.listaUsuarioPermissao!.add(userPermission);
      }
    }

    setState(() {
      _getRows();
    });
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> lista = [];
    lista.add(const DataColumn(label: Text('Permisão')));
    lista.add(const DataColumn(label: Text('Descrição')));
    return lista;
  }

  List<DataRow> _getRows() {
    List<DataRow> lista = [];
    for (var userMotando in UsuarioController.listaUsuarioPermissao!) {
      List<DataCell> celulas = [];

      celulas = [
        DataCell(Text(userMotando.permissao!.nome ?? ''), onTap: () {
          //_detalharPermissao(widget.usuario, context);
        }),
        DataCell(Text(userMotando.permissao!.descricao ?? ''), onTap: () {
          //_detalharPermissao(widget.usuario, context);
        }),
      ];

      lista.add(DataRow(cells: celulas));
    }
    return lista;
  }

  Future<void> _detalharPermissao(
      Usuario? usuario, BuildContext context) async {
    setState(() {
      _getRows();
    });
  }
}
