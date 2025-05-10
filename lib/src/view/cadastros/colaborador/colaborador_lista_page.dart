import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../view/shared/page/filtro_page.dart';
import './../../../model/transiente/transiente.dart';
import './../../../database/dao/colaborador_dao.dart';
import './../../../database/tabelas/colaborador.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../view/shared/view_util_lib.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../view/shared/botoes.dart';
import './colaborador_persiste_page.dart';
import './../../../database/app_db.dart';
import './../../../infra/sessao.dart';
import './../../../infra/infra.dart';

class ColaboradorListaPage extends StatefulWidget {
  const ColaboradorListaPage({Key? key}) : super(key: key);

  @override
  ColaboradorListaPageState createState() => ColaboradorListaPageState();
}

class ColaboradorListaPageState extends State<ColaboradorListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = ColaboradorDao.colunas;
  final _campos = ColaboradorDao.campos;

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
    final listaSubLocal = Sessao.db.colaboradorDao.listaColaboradorMontado;

    final _ColaboradorMontadoDataSource colaboradorMontadoDataSource =
        _ColaboradorMontadoDataSource(listaSubLocal, context, _refrescarTela);

    // ignore: no_leading_underscores_for_local_identifiers
    void _sort<T>(
        Comparable<T>? Function(ColaboradorMontado subLocalMontado) getField,
        int columnIndex,
        bool ascending) {
      colaboradorMontadoDataSource._sort<T>(getField, ascending);
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
        key: const Key('colaboradorLista'),
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: const Text('Cadastro - Colaborador'),
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
              child: listaSubLocal == null
                  ? const Center(child: CircularProgressIndicator())
                  : ListView(
                      controller: controllerScroll,
                      padding: const EdgeInsets.all(
                          Constantes.paddingListViewListaPage),
                      children: <Widget>[
                        PaginatedDataTable(
                          header: const Text('Relação - Colaborador'),
                          rowsPerPage: _rowsPerPage!,
                          onRowsPerPageChanged: (int? value) {
                            setState(() {
                              _rowsPerPage = value;
                            });
                          },
                          sortColumnIndex: _sortColumnIndex,
                          sortAscending: _sortAscending,
                          columns: _pegarColunas(_sort),
                          source: colaboradorMontadoDataSource,
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
              (ColaboradorMontado grupo) => grupo.colaborador!.nome,
              columnIndex,
              ascending)),
    );
    colunas.add(
      DataColumn(
          label: const Text('Sexo'),
          tooltip: 'Sexo',
          onSort: (int columnIndex, bool ascending) => sort<String>(
              (ColaboradorMontado genero) => genero.sexo!.nome,
              columnIndex,
              ascending)),
    );
    colunas.add(
      DataColumn(
          label: const Text('Estado civil'),
          tooltip: 'Estado civil',
          onSort: (int columnIndex, bool ascending) => sort<String>(
              (ColaboradorMontado estCivil) => estCivil.estadoCivil!.nome,
              columnIndex,
              ascending)),
    );
    colunas.add(
      DataColumn(
          label: const Text('Admissão'),
          tooltip: 'Admissão',
          onSort: (int columnIndex, bool ascending) => sort<String>(
              (ColaboradorMontado estCivil) => estCivil.estadoCivil!.nome,
              columnIndex,
              ascending)),
    );
    return colunas;
  }

  void _inserir() {
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => ColaboradorPersistePage(
                montado: ColaboradorMontado(
                  sexo: Sexo(),
                  estadoCivil: EstadoCivil(),
                  colaborador: Colaborador(),
                ),
                title: 'Colaborador - Inserindo',
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
            title: 'Colaborador - Filtro',
            colunas: _colunas,
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.colaboradorDao.consultarListaMontado(
            campo: _filtro!.campo, valor: _filtro!.valor);
        setState(() {});
      }
    }
  }

  Future _gerarRelatorio() async {
    gerarDialogBoxInformacao(
        context, 'Essa janela não possui relatório implementado');
  }

  Future _refrescarTela() async {
    await Sessao.db.colaboradorDao.consultarListaMontado();
    setState(() {});
  }
}

/// codigo referente a fonte de dados
class _ColaboradorMontadoDataSource extends DataTableSource {
  final List<ColaboradorMontado>? listaMontado;
  final BuildContext context;
  final Function refrescarTela;

  _ColaboradorMontadoDataSource(
      this.listaMontado, this.context, this.refrescarTela);

  void _sort<T>(
      Comparable<T>? Function(ColaboradorMontado subLocalMontado) getField,
      bool ascending) {
    listaMontado!.sort((ColaboradorMontado a, ColaboradorMontado b) {
      if (!ascending) {
        final ColaboradorMontado c = a;
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
    if (index >= listaMontado!.length) return null;
    final ColaboradorMontado montado = listaMontado![index];
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(montado.colaborador?.nome ?? ''), onTap: () {
          _detalharMontado(montado, context, refrescarTela);
        }),
        DataCell(Text(montado.sexo?.nome ?? ''), onTap: () {
          _detalharMontado(montado, context, refrescarTela);
        }),
        DataCell(Text(montado.estadoCivil?.nome ?? ''), onTap: () {
          _detalharMontado(montado, context, refrescarTela);
        }),
        DataCell(
            Text(montado.colaborador?.dataAdmissao != null
                ? DateFormat('dd/MM/yyyy')
                    .format(montado.colaborador!.dataAdmissao!)
                : ''), onTap: () {
          _detalharMontado(montado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaMontado!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharMontado(
    ColaboradorMontado montado, BuildContext context, Function refrescarTela) {
  Navigator.of(context)
      .push(MaterialPageRoute(
          builder: (BuildContext context) => ColaboradorPersistePage(
              montado: montado,
              title: 'Colaborador - Editando',
              operacao: 'A')))
      .then((_) async {
    await refrescarTela();
  });
}
