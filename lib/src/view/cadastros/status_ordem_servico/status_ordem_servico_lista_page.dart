import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import './../../../database/app_db.dart';
import './../../../database/dao/categoria_dao.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../infra/infra.dart';
import './../../../infra/sessao.dart';
import './../../../model/transiente/transiente.dart';
import './../../../view/shared/botoes.dart';
import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../view/shared/page/filtro_page.dart';
import './../../../view/shared/view_util_lib.dart';

import 'status_ordem_servico_persiste_page.dart';

class StatusOrdemServicoListaPage extends StatefulWidget {
  const StatusOrdemServicoListaPage({Key? key}) : super(key: key);

  @override
  LocalListaPageState createState() => LocalListaPageState();
}

class LocalListaPageState extends State<StatusOrdemServicoListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = CategoriaDao.colunas;
  final _campos = CategoriaDao.campos;

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
    final listaStatus = Sessao.db.statusOrdemServicoDao.listaStatus;

    final _StatusDataSource statusDataSource =
        _StatusDataSource(listaStatus, context, _refrescarTela);

    // ignore: no_leading_underscores_for_local_identifiers
    void _sort<T>(
        Comparable<T>? Function(StatusOrdemServico categoria) getField,
        int columnIndex,
        bool ascending) {
      statusDataSource._sort<T>(getField, ascending);
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
        key: const Key('statusOSLista'),
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Cadastro - Status da Ordem de Serviço'),
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
              child: listaStatus == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      controller: controllerScroll,
                      padding: const EdgeInsets.all(
                          Constantes.paddingListViewListaPage),
                      children: <Widget>[
                        PaginatedDataTable(
                          header: const Text(
                              'Relação - Status da Ordem de Serviço'),
                          rowsPerPage: _rowsPerPage!,
                          onRowsPerPageChanged: (int? value) {
                            setState(() {
                              _rowsPerPage = value;
                            });
                          },
                          sortColumnIndex: _sortColumnIndex,
                          sortAscending: _sortAscending,
                          columns: _pegarColunas(_sort),
                          source: statusDataSource,
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
          onSort: (int columnIndex, bool ascending) => sort<String>(
              (StatusOrdemServico cat) => cat.nome, columnIndex, ascending)),
    );
    return colunas;
  }

  void _inserir() {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => StatusOrdemServicoPersistePage(
                status: StatusOrdemServico(codigo: 0, nome: ''),
                title: 'Status da Ordem de Serviço - Inserindo',
                operacao: 'I')))
        .then((_) async {
      await _refrescarTela();
    });
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Status da Ordem de Serviço - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.statusOrdemServicoDao
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
    await Sessao.db.statusOrdemServicoDao.consultarLista();
    setState(() {});
  }
}

/// codigo referente a fonte de dados
class _StatusDataSource extends DataTableSource {
  final List<StatusOrdemServico>? listaProdutoGrupo;
  final BuildContext context;
  final Function refrescarTela;

  _StatusDataSource(this.listaProdutoGrupo, this.context, this.refrescarTela);

  void _sort<T>(Comparable<T>? Function(StatusOrdemServico categoria) getField,
      bool ascending) {
    listaProdutoGrupo!.sort((StatusOrdemServico a, StatusOrdemServico b) {
      if (!ascending) {
        final StatusOrdemServico c = a;
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
    if (index >= listaProdutoGrupo!.length) return null;
    final StatusOrdemServico categoria = listaProdutoGrupo![index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(categoria.nome ?? ''), onTap: () {
          _detalharProdutoGrupo(categoria, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaProdutoGrupo!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharProdutoGrupo(StatusOrdemServico categoria, BuildContext context,
    Function refrescarTela) {
  Navigator.of(context)
      .push(MaterialPageRoute(
          builder: (BuildContext context) => StatusOrdemServicoPersistePage(
              status: categoria,
              title: 'Status da Ordem de Serviço - Editando',
              operacao: 'A')))
      .then((_) async {
    await refrescarTela();
  });
}
