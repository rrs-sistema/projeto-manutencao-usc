import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../view/shared/page/filtro_page.dart';
import './../../../model/transiente/transiente.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../view/shared/view_util_lib.dart';
import './../../../database/dao/funcao_dao.dart';
import './../../../view/shared/botoes.dart';
import './../../../database/app_db.dart';
import './../../../infra/sessao.dart';
import './../../../infra/infra.dart';

import 'funcao_persiste_page.dart';

class FuncaoListaPage extends StatefulWidget {
  const FuncaoListaPage({Key? key}) : super(key: key);

  @override
  FuncaoListaPageState createState() => FuncaoListaPageState();
}

class FuncaoListaPageState extends State<FuncaoListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = FuncaoDao.colunas;
  final _campos = FuncaoDao.campos;

  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController controllerScroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _shortcutMap = getAtalhosListaPage();

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
      case AtalhoTelaType.inserir:
        _inserir();
        break;
      case AtalhoTelaType.imprimir:
        _gerarRelatorio();
        break;
      case AtalhoTelaType.filtrar:
        _chamarFiltro();
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final funcao = Sessao.db.funcaoDao.listaLocal;

    final _LocalDataSource localDataSource =
        _LocalDataSource(funcao, context, _refrescarTela);

    // ignore: no_leading_underscores_for_local_identifiers
    void _sort<T>(Comparable<T>? Function(Funcao funcao) getField,
        int columnIndex, bool ascending) {
      localDataSource._sort<T>(getField, ascending);
      setState(() {
        _sortColumnIndex = columnIndex;
        _sortAscending = ascending;
      });
    }

    bool? telaPequena = Biblioteca.isTelaPequena(context);

    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        key: const Key('funcaoLista'),
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Cadastro - Função'),
            centerTitle: telaPequena! ? true : false,
            actions: const <Widget>[],
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: gradienteApp(),
              ),
            ),
          ),
          floatingActionButton: FloatingActionButton(
              focusColor: ViewUtilLib.getBotaoFocusColor(),
              tooltip: Constantes.botaoInserirDica,
              backgroundColor: ViewUtilLib.getBackgroundColorBotaoInserir(),
              child: ViewUtilLib.getIconBotaoInserir(),
              onPressed: () {
                _inserir();
              }),
          floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
          bottomNavigationBar: BottomAppBar(
            color: ViewUtilLib.getBottomAppBarColor(),
            shape: const CircularNotchedRectangle(),
            child: Row(
              children: getBotoesNavigationBarListaPage(
                context: context,
                chamarFiltro: _chamarFiltro,
                gerarRelatorio: _gerarRelatorio,
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Scrollbar(
              controller: controllerScroll,
              child: funcao == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      controller: controllerScroll,
                      padding: const EdgeInsets.all(
                          Constantes.paddingListViewListaPage),
                      children: <Widget>[
                        PaginatedDataTable(
                          header: const Text('Relação - Função'),
                          rowsPerPage: _rowsPerPage!,
                          onRowsPerPageChanged: (int? value) {
                            setState(() {
                              _rowsPerPage = value;
                            });
                          },
                          sortColumnIndex: _sortColumnIndex,
                          sortAscending: _sortAscending,
                          columns: _pegarColunas(_sort),
                          source: localDataSource,
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _pegarColunas(Function sort) {
    final List<DataColumn> colunas = [];
    colunas.add(
      DataColumn(
          label: const Text('Nome'),
          tooltip: 'Conteúdo para o campo nome',
          onSort: (int columnIndex, bool ascending) =>
              sort<String>((Funcao cat) => cat.nome, columnIndex, ascending)),
    );
    return colunas;
  }

  void _inserir() {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => FuncaoPersistePage(
                funcao: Funcao(), title: 'Função - Inserindo', operacao: 'I')))
        .then((_) async {
      await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Função - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.funcaoDao
            .consultarListaFiltro(_filtro!.campo!, _filtro!.valor!);
        setState(() {});
      }
    }
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxInformacao(
        context, 'Essa janela não possui relatório implementado');
  }

  Future _refrescarTela() async {
    await Sessao.db.funcaoDao.consultarLista();
    setState(() {});
  }
}

/// codigo referente a fonte de dados
class _LocalDataSource extends DataTableSource {
  final List<Funcao>? funcaoList;
  final BuildContext context;
  final Function refrescarTela;

  _LocalDataSource(this.funcaoList, this.context, this.refrescarTela);

  void _sort<T>(
      Comparable<T>? Function(Funcao funcao) getField, bool ascending) {
    funcaoList!.sort((Funcao a, Funcao b) {
      if (!ascending) {
        final Funcao c = a;
        a = b;
        b = c;
      }
      Comparable<T>? aValue = getField(a);
      Comparable<T>? bValue = getField(b);

      aValue ??= '' as Comparable<T>;
      bValue ??= '' as Comparable<T>;

      return Comparable.compare(aValue, bValue);
    });
  }

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= funcaoList!.length) return null;
    final Funcao funcao = funcaoList![index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(funcao.nome ?? ''), onTap: () {
          _detalharLocal(funcao, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => funcaoList!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharLocal(
    Funcao funcao, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
      .push(MaterialPageRoute(
          builder: (BuildContext context) => FuncaoPersistePage(
              funcao: funcao, title: 'Função - Editando', operacao: 'A')))
      .then((_) async {
    await refrescarTela();
  });
}
