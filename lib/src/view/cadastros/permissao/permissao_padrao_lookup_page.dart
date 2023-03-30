import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:manutencao_usc/src/database/app_db.dart';
import 'package:manutencao_usc/src/infra/atalhos_desktop_web.dart';
import 'package:manutencao_usc/src/infra/infra.dart';
import 'package:manutencao_usc/src/infra/sessao.dart';
import 'package:manutencao_usc/src/view/shared/botoes.dart';
import 'package:manutencao_usc/src/view/shared/gradiente_app.dart';
import 'package:manutencao_usc/src/view/shared/view_util_lib.dart';

class PermissaoPadraoLookupPage extends StatefulWidget {
  const PermissaoPadraoLookupPage({Key? key}) : super(key: key);

  @override
  PermissaoPadraoLookupPageState createState() =>
      PermissaoPadraoLookupPageState();
}

class PermissaoPadraoLookupPageState extends State<PermissaoPadraoLookupPage> {
  List<Permissao> _listaPermissao = [];
  final List<Permissao> _itensSelecionados = [];

  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController controllerScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosPersistePage();

    _actionMap = <Type, Action<Intent>>{
      AtalhoTelaIntent: CallbackAction<AtalhoTelaIntent>(
        onInvoke: _tratarAcoesAtalhos,
      ),
    };
    if (controllerScroll.hasClients) {
      controllerScroll.jumpTo(50.0);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) => _refrescarTela());
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.salvar:
        Navigator.pop(context);
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
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Selecione as observações desejadas'),
            centerTitle: telaPequena! ? true : false,
            actions: const <Widget>[],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: gradienteApp(),
              ),
            ),
          ),
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),
            shape: const CircularNotchedRectangle(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: _getBotoesRodape(context: context),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              controller: controllerScroll,
              child: ListView(
                controller: controllerScroll,
                padding:
                    const EdgeInsets.all(Constantes.paddingListViewListaPage),
                children: <Widget>[
                  DataTable(
                    showCheckboxColumn: true,
                    columns: const [
                      DataColumn(
                        label: Text('Descrição'),
                        tooltip: 'Descrição',
                      ),
                    ],
                    rows: _getRows(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  List<DataRow> _getRows() {
    List<DataRow> lista = [];

    for (var permissao in _listaPermissao) {
      String role = permissao.nome ?? '';
      String descrition = permissao.descricao ?? '';

      String roleDescrition = '$role - $descrition';
      List<DataCell> celulas = [];
      celulas = [
        DataCell(
          Text(roleDescrition),
        ),
      ];

      final itemEncontrado = _itensSelecionados
          .where((descricao) => descricao.codigo == permissao.codigo)
          .toList();

      lista.add(
        DataRow(
          selected: itemEncontrado.isNotEmpty,
          cells: celulas,
          onSelectChanged: (value) {
            if (itemEncontrado.isEmpty) {
              Permissao permissaoNew = Permissao(
                  codigo: permissao.codigo,
                  nome: permissao.nome,
                  descricao: permissao.descricao);
              _itensSelecionados.add(permissaoNew);
            } else {
              _itensSelecionados
                  .removeWhere((p) => p.codigo == permissao.codigo);
            }
            debugPrint(_itensSelecionados.toString());
            setState(() {});
          },
        ),
      );
    }
    return lista;
  }

  Future _refrescarTela() async {
    _listaPermissao = (await Sessao.db.permissaoDao.consultarLista())!;
    setState(() {});
  }

  List<Widget> _getBotoesRodape({required BuildContext context}) {
    List<Widget> listaBotoes = [];
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context)! ? 130 : 150,
        child: getBotaoGenericoPdv(
            descricao: Biblioteca.isMobile() ? 'Cancelar' : 'Cancelar [F11]',
            cor: Colors.red,
            onPressed: () {
              Navigator.pop(context, false);
            }),
      ),
    );
    listaBotoes.add(
      const SizedBox(
        width: 10.0,
        height: 50,
      ),
    );
    listaBotoes.add(
      SizedBox(
        width: Biblioteca.isTelaPequena(context)! ? 130 : 150,
        child: getBotaoGenericoPdv(
            descricao: Biblioteca.isMobile() ? 'Confirmar' : 'Confirmar [F12]',
            cor: Colors.green.shade900,
            onPressed: () {
              Navigator.pop(context, _itensSelecionados);
            }),
      ),
    );
    return listaBotoes;
  }
}
