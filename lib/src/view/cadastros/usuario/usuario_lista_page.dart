import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:manutencao_usc/src/database/app_db.dart';
import 'package:manutencao_usc/src/database/dao/usuario_dao.dart';
import 'package:manutencao_usc/src/database/tabelas/usuario.dart';

import 'package:manutencao_usc/src/infra/infra.dart';
import 'package:manutencao_usc/src/infra/atalhos_desktop_web.dart';
import 'package:manutencao_usc/src/infra/sessao.dart';

import 'package:manutencao_usc/src/model/model.dart';
import 'package:manutencao_usc/src/view/cadastros/usuario/usuario_page.dart';
import 'package:manutencao_usc/src/view/shared/gradiente_app.dart';

import 'package:manutencao_usc/src/view/shared/view_util_lib.dart';
import 'package:manutencao_usc/src/view/shared/botoes.dart';
import 'package:manutencao_usc/src/view/shared/caixas_de_dialogo.dart';
import 'package:manutencao_usc/src/view/shared/page/filtro_page.dart';

class UsuarioListaPage extends StatefulWidget {
  const UsuarioListaPage({Key? key}) : super(key: key);

  @override
  UsuarioListaPageState createState() => UsuarioListaPageState();
}

class UsuarioListaPageState extends State<UsuarioListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = UsuarioDao.colunas;
  final _campos = UsuarioDao.campos;

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
    final listaProdutoMontado = Sessao.db.usuarioDao.listaUsuario;

    final _ProdutoDataSource produtoDataSource =
        _ProdutoDataSource(listaProdutoMontado, context, _refrescarTela);

    // ignore: no_leading_underscores_for_local_identifiers
    void _sort<T>(Comparable<T>? Function(Usuario usuarioMontado) getField,
        int columnIndex, bool ascending) {
      produtoDataSource._sort<T>(getField, ascending);
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
        key: const Key('usuarioLista'),
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Cadastro - Usuario'),
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
              // isAlwaysShown: true,
              controller: controllerScroll,
              child: listaProdutoMontado == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      controller: controllerScroll,
                      padding: const EdgeInsets.all(
                          Constantes.paddingListViewListaPage),
                      children: <Widget>[
                        PaginatedDataTable(
                          header: const Text('Relação - Usuário'),
                          rowsPerPage: _rowsPerPage!,
                          onRowsPerPageChanged: (int? value) {
                            setState(() {
                              _rowsPerPage = value;
                            });
                          },
                          sortColumnIndex: _sortColumnIndex,
                          sortAscending: _sortAscending,
                          columns: _pegarColunas(_sort),
                          source: produtoDataSource,
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
        tooltip: 'Conteúdo para o campo nom',
        onSort: (int columnIndex, bool ascending) => sort<String>(
            (Usuario usuarioMontado) => usuarioMontado.nome,
            columnIndex,
            ascending),
      ),
    );
    colunas.add(
      DataColumn(
        label: const Text('Matricula'),
        tooltip: 'Conteúdo para o campo matricula',
        onSort: (int columnIndex, bool ascending) => sort<String>(
            (Usuario usuarioMontado) => usuarioMontado.matricula,
            columnIndex,
            ascending),
      ),
    );
    colunas.add(
      DataColumn(
        label: const Text('E-mail'),
        tooltip: 'Conteúdo para o campo email',
        onSort: (int columnIndex, bool ascending) => sort<String>(
            (Usuario usuarioMontado) => usuarioMontado.email,
            columnIndex,
            ascending),
      ),
    );
    colunas.add(
      DataColumn(
        label: const Text('Celular'),
        tooltip: 'Conteúdo para o campo celular',
        onSort: (int columnIndex, bool ascending) => sort<String>(
            (Usuario usuarioMontado) => usuarioMontado.celular,
            columnIndex,
            ascending),
      ),
    );
    return colunas;
  }

  void _inserir() {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => UsuarioPage(
                usuarioMontado: Usuario(
                  deletado: 'N',
                ),
                title: 'Usuário - Inserindo',
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
            title: 'Usuário - Filtro',
            colunas: _colunas,
            campoPesquisaPadrao: 'Nome',
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.usuarioDao
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
    await Sessao.db.usuarioDao.consultarLista();
    setState(() {});
  }
}

/// codigo referente a fonte de dados
class _ProdutoDataSource extends DataTableSource {
  final List<Usuario>? listaProduto;
  final BuildContext context;
  final Function refrescarTela;

  _ProdutoDataSource(this.listaProduto, this.context, this.refrescarTela);

  void _sort<T>(
      Comparable<T>? Function(Usuario produto) getField, bool ascending) {
    listaProduto!.sort((Usuario a, Usuario b) {
      if (!ascending) {
        final Usuario c = a;
        a = b;
        b = c;
      }
      Comparable<T>? aValue = getField(a);
      Comparable<T>? bValue = getField(b);

      try {
        aValue ??= '' as Comparable<T>;
        bValue ??= '' as Comparable<T>;
      } catch (e) {
        return 1;
      }

      return Comparable.compare(aValue, bValue);
    });
  }

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    // assert(index >= 0);
    if (index >= listaProduto!.length) return null;
    return DataRow.byIndex(
      index: index,
      cells: _pegarCelulas(index),
    );
  }

  List<DataCell> _pegarCelulas(int index) {
    final Usuario usuarioMontado = listaProduto![index];
    final Usuario produto = usuarioMontado;
    List<DataCell> celulas = [];
    celulas.add(
      DataCell(Text(produto.nome ?? ''), onTap: () {
        _detalharProduto(usuarioMontado, context, refrescarTela);
      }),
    );
    celulas.add(
      DataCell(Text(produto.matricula ?? ''), onTap: () {
        _detalharProduto(usuarioMontado, context, refrescarTela);
      }),
    );
    celulas.add(
      DataCell(Text(produto.email ?? ''), onTap: () {
        _detalharProduto(usuarioMontado, context, refrescarTela);
      }),
    );
    celulas.add(
      DataCell(Text(produto.celular ?? ''), onTap: () {
        _detalharProduto(usuarioMontado, context, refrescarTela);
      }),
    );
    return celulas;
  }

  @override
  int get rowCount => listaProduto!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharProduto(
    Usuario usuarioMontado, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
      .push(MaterialPageRoute(
          builder: (BuildContext context) => UsuarioPage(
              usuarioMontado: usuarioMontado,
              title: 'Usuário - Editando',
              operacao: 'A')))
      .then((_) async {
    await refrescarTela();
  });
}
