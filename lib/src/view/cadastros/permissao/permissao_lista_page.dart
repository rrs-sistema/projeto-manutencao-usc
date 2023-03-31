import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../view/shared/page/filtro_page.dart';
import './../../../model/transiente/transiente.dart';
import './../../../database/dao/permissao_dao.dart';
import './../../../view/shared/view_util_lib.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../view/shared/botoes.dart';
import './../../../database/app_db.dart';
import './../../../infra/sessao.dart';
import './../../../infra/infra.dart';

class PermissaoListaPage extends StatefulWidget {
  const PermissaoListaPage({Key? key}) : super(key: key);

  @override
  PermissaoListaPageState createState() => PermissaoListaPageState();
}

class PermissaoListaPageState extends State<PermissaoListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;

  Filtro? _filtro = Filtro();
  final _colunas = PermissaoDao.colunas;
  final _campos = PermissaoDao.campos;

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
        // _inserir();
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
    final listaPermissao = Sessao.db.permissaoDao.listaPermissao;

    final _PermissaoDataSource permissaoDataSource =
        _PermissaoDataSource(listaPermissao, context, _refrescarTela);

    // ignore: no_leading_underscores_for_local_identifiers
    void _sort<T>(Comparable<T>? Function(Permissao permissao) getField,
        int columnIndex, bool ascending) {
      permissaoDataSource._sort<T>(getField, ascending);
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
        key: const Key('permissaoLista'),
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Cadastro - Permissão'),
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
              child: listaPermissao == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      controller: controllerScroll,
                      padding: const EdgeInsets.all(
                          Constantes.paddingListViewListaPage),
                      children: <Widget>[
                        PaginatedDataTable(
                          header: const Text('Relação - Permissao do usuário'),
                          rowsPerPage: _rowsPerPage!,
                          onRowsPerPageChanged: (int? value) {
                            setState(() {
                              _rowsPerPage = value;
                            });
                          },
                          sortColumnIndex: _sortColumnIndex,
                          sortAscending: _sortAscending,
                          columns: _pegarColunas(_sort),
                          source: permissaoDataSource,
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
    // colunas.add(
    //   DataColumn(
    //       label: const Text('Nome'),
    //       tooltip: 'Conteúdo para o campo nome',
    //       onSort: (int columnIndex, bool ascending) => sort<String>(
    //           (Permissao obj) => obj.nome, columnIndex, ascending)),
    // );
    colunas.add(
      DataColumn(
          label: const Text('Descrição'),
          tooltip: 'Conteúdo para o campo descrição',
          onSort: (int columnIndex, bool ascending) => sort<String>(
              (Permissao obj) => obj.descricao, columnIndex, ascending)),
    );
    return colunas;
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Categoria - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.permissaoDao
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
    await Sessao.db.permissaoDao.consultarLista();
    setState(() {});
  }
}

/// codigo referente a fonte de dados
class _PermissaoDataSource extends DataTableSource {
  final List<Permissao>? listaPermissao;
  final BuildContext context;
  final Function refrescarTela;

  _PermissaoDataSource(this.listaPermissao, this.context, this.refrescarTela);

  void _sort<T>(
      Comparable<T>? Function(Permissao permissao) getField, bool ascending) {
    listaPermissao!.sort((Permissao a, Permissao b) {
      if (!ascending) {
        final Permissao c = a;
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
    if (index >= listaPermissao!.length) return null;
    final Permissao permissao = listaPermissao![index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        //DataCell(Text(permissao.nome ?? '')),
        DataCell(Text(permissao.descricao ?? '')),
      ],
    );
  }

  @override
  int get rowCount => listaPermissao!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}
