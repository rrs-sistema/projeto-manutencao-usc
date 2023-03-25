import 'package:flutter/material.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/gestures.dart';
import 'package:intl/intl.dart';
import 'package:manutencao_usc/src/database/dao/dao.dart';
import 'package:manutencao_usc/src/database/tabelas/ordem_servico.dart';
import 'package:manutencao_usc/src/infra/sessao.dart';
import 'package:manutencao_usc/src/view/shared/page/filtro_page.dart';

import './../../view/shared/caixas_de_dialogo.dart';
import './../../view/shared/gradiente_app.dart';
import './../../view/shared/view_util_lib.dart';
import './../../view/shared/widgets_caixa.dart';
import './../../view/shared/widgets_input.dart';
import './../../infra/atalhos_desktop_web.dart';
import './../../database/app_db.dart';
import './../../infra/infra.dart';
import './../../model/model.dart';

class OrdenServicoListaPage extends StatefulWidget {
  const OrdenServicoListaPage({Key? key}) : super(key: key);

  @override
  OrdenServicoListaPageState createState() => OrdenServicoListaPageState();
}

class OrdenServicoListaPageState extends State<OrdenServicoListaPage> {
  int? _rowsPerPage = Constantes.paginatedDataTableLinhasPorPagina;
  int? _sortColumnIndex;
  bool _sortAscending = true;
  Filtro? _filtro = Filtro();
  final _colunas = OrdemServicoDao.colunas;
  final _campos = OrdemServicoDao.campos;

  DateTime _mesAno = DateTime.now();
  String? _statusOrdensServico = 'Todos';
  double _totalPagar = 45;
  double _totaPendente = 20;
  double _totaAtendida = 25;
  List<OrdemServicoMontada>? _listaOrdensServicoMontada;

  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;

  final ScrollController controllerScroll = ScrollController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

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
    _listaOrdensServicoMontada =
        Sessao.db.ordemServicoDao.listaOrdemServicoMontada;

    final _OrdemServicoDataSource ordemServicoDataSource =
        _OrdemServicoDataSource(
            _listaOrdensServicoMontada, context, _refrescarTela);

    // ignore: no_leading_underscores_for_local_identifiers
    void _sort<T>(
        Comparable<T>? Function(OrdemServicoMontada ordensServicoMontada)
            getField,
        int columnIndex,
        bool ascending) {
      ordemServicoDataSource._sort<T>(getField, ascending);
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
        autofocus: true,
        child: Scaffold(
          drawerDragStartBehavior: DragStartBehavior.down,
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(Biblioteca.isDesktop()
                ? '${Constantes.nomeApp} - Ordens de Serviços'
                : Constantes.nomeApp),
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
            child: Padding(
              padding: const EdgeInsets.fromLTRB(10, 10, 90, 10),
              child: Row(
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: InputDecorator(
                      decoration: getInputDecoration('Mês/Ano Para o Filtro',
                          'Mês/Ano Para o Filtro', true,
                          cor: Constantes.primaryColor,
                          labelStyleHint: const TextStyle(
                            color: Colors.white,
                          ),
                          labelStyle: const TextStyle(color: Colors.white)),
                      child: DatePickerItem(
                        mascara: 'MM/yyyy',
                        dateTime: _mesAno,
                        firstDate: DateTime.parse('1900-01-01'),
                        lastDate: DateTime.parse('2050-01-01'),
                        onChanged: (DateTime? value) {
                          _mesAno = value!;
                          _refrescarTela();
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    flex: 1,
                    child: InputDecorator(
                      decoration: getInputDecoration(
                          'Status da orderm', 'Status da orderm', true,
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          paddingVertical: 1),
                      isEmpty: _statusOrdensServico == null,
                      child: getDropDownButton(_statusOrdensServico,
                          (String? newValue) {
                        _statusOrdensServico = newValue;
                        _refrescarTela();
                      }, <String>[
                        'Todos',
                        'Aberto',
                        'Em andamento',
                        'Pendente',
                      ]),
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: _refrescarTela,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: BackdropScaffold(
                appBar: BackdropAppBar(
                  title: Text(Biblioteca.isDesktop()
                      ? 'Relação - Ordens de Serviços'
                      : 'Ordens de Serviços'),
                  actions: const <Widget>[
                    BackdropToggleButton(
                      icon: AnimatedIcons.list_view,
                    ),
                  ],
                ),
                stickyFrontLayer: true,
                backLayer: getResumoAtendimento(context),
                frontLayer: Scrollbar(
                  controller: controllerScroll,
                  child: _listaOrdensServicoMontada == null
                      ? const Center(child: CircularProgressIndicator())
                      : ListView(
                          controller: controllerScroll,
                          padding: const EdgeInsets.all(
                              Constantes.paddingListViewListaPage),
                          children: <Widget>[
                            PaginatedDataTable(
                                rowsPerPage: _rowsPerPage!,
                                onRowsPerPageChanged: (int? value) {
                                  setState(() {
                                    _rowsPerPage = value;
                                  });
                                },
                                sortColumnIndex: _sortColumnIndex,
                                sortAscending: _sortAscending,
                                columns: <DataColumn>[
                                  DataColumn(
                                    label: const Text('Status da OS'),
                                    tooltip: 'Status da ordem de serviço',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<String>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .statusOrdemServico?.nome,
                                            columnIndex,
                                            ascending),
                                  ),
                                  DataColumn(
                                    label: const Text('Categoria'),
                                    tooltip: 'Categoria da ordem de serviço',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<String>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .categoria?.nome,
                                            columnIndex,
                                            ascending),
                                  ),
                                  DataColumn(
                                    label: const Text('Local'),
                                    tooltip: 'Local do problema ocorrido',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<String>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .local?.nome,
                                            columnIndex,
                                            ascending),
                                  ),
                                  DataColumn(
                                    label: const Text('Data de Abertura'),
                                    tooltip: 'Data de Abertura',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<DateTime>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .ordemServico!.dataAbertura,
                                            columnIndex,
                                            ascending),
                                  ),
                                  DataColumn(
                                    label: const Text('Descrição do problema'),
                                    tooltip: 'Descrição do problema apontado',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<String>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .ordemServico!
                                                    .descricaoProblema,
                                            columnIndex,
                                            ascending),
                                  ),
                                  DataColumn(
                                    label: const Text('Solução do problema'),
                                    tooltip: 'Solução do problema apontado',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<String>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .ordemServico!
                                                    .descricaoSolucao,
                                            columnIndex,
                                            ascending),
                                  ),
                                ],
                                source: ordemServicoDataSource),
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

  Widget getResumoAtendimento(BuildContext context) {
    return Scrollbar(
      child: SingleChildScrollView(
        dragStartBehavior: DragStartBehavior.down,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Card(
          color: Colors.white,
          elevation: 10,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 10.0),
              getItemResumoValor(
                descricao: 'Total geral: ',
                valor: Constantes.formatoDecimalValor.format(_totalPagar),
                corFundo: Colors.blue.shade100,
              ),
              getItemResumoValor(
                descricao: 'Total Pendente: ',
                valor: Constantes.formatoDecimalValor.format(_totaPendente),
                corFundo: Colors.red.shade100,
              ),
              getItemResumoValor(
                descricao: 'Total Atendida: ',
                valor: Constantes.formatoDecimalValor.format(_totaAtendida),
                corFundo: Colors.green.shade100,
              ),
              const SizedBox(height: 10.0),
            ],
          ),
        ),
      ),
    );
  }

  void _inserir() {
    showInSnackBar(
        'Deve abrir a tela para cadastrar nova ordem de serviço',
        corTexto: Colors.black,
        corFundo: Colors.white,
        context);
    /*
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => ContasPagarPersistePage(
                ordemServicoMontada: OrdemServicoMontada(
                  fornecedor: Fornecedor(
                    id: null,
                  ),
                  contasPagar: ContasPagar(
                    id: null,
                    dataVencimento: DateTime.now(),
                  ),
                ),
                title: 'Contas a Pagar - Inserindo',
                operacao: 'I')))
        .then((_) async {
      await _refrescarTela();
    });
    */
  }

  void _chamarFiltro() async {
    _filtro = await Navigator.push(
        context,
        MaterialPageRoute(
          builder: (BuildContext context) => FiltroPage(
            title: 'Ordem de Serviço - Filtro',
            colunas: _colunas,
            campoPesquisaPadrao: 'Nome',
            filtroPadrao: true,
          ),
          fullscreenDialog: true,
        ));
    if (_filtro != null) {
      if (_filtro!.campo != null) {
        _filtro!.campo = _campos[int.parse(_filtro!.campo!)];
        await Sessao.db.ordemServicoDao
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
    _listaOrdensServicoMontada = await Sessao.db.ordemServicoDao
        .consultarListaMontado(
            mes: _mesAno.month,
            ano: _mesAno.year,
            status: _statusOrdensServico);
    _atualizarTotais();
    setState(() {});
  }

  _atualizarTotais() {
    _totalPagar = 0;
    _totaPendente = 0;
    _totaAtendida = 0;
    for (OrdemServicoMontada ordemServicoMontada
        in _listaOrdensServicoMontada!) {
      if (ordemServicoMontada.ordemServico!.codigoStatus == 0) {
        _totalPagar = _totalPagar + 1;
      } else if (ordemServicoMontada.ordemServico!.codigoStatus == 1) {
        _totaPendente = _totaPendente + 1;
      }
      _totaAtendida = _totaAtendida + 1;
    }
  }
}

/// codigo referente a fonte de dados
class _OrdemServicoDataSource extends DataTableSource {
  final List<OrdemServicoMontada>? listaOrdensServico;
  final BuildContext context;
  final Function refrescarTela;

  _OrdemServicoDataSource(
      this.listaOrdensServico, this.context, this.refrescarTela);

  void _sort<T>(
      Comparable<T>? Function(OrdemServicoMontada contasPagar) getField,
      bool ascending) {
    listaOrdensServico!.sort((OrdemServicoMontada a, OrdemServicoMontada b) {
      if (!ascending) {
        final OrdemServicoMontada c = a;
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
    notifyListeners();
  }

  final int _selectedCount = 0;

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= listaOrdensServico!.length) return null;
    OrdemServicoMontada ordemServicoMontado = listaOrdensServico![index];
    final OrdemServico ordemServico = ordemServicoMontado.ordemServico!;
    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Text(ordemServicoMontado.statusOrdemServico!.nome), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(ordemServicoMontado.categoria!.nome), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(ordemServicoMontado.local!.nome), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(
            Text(ordemServico.dataAbertura != null
                ? DateFormat('dd/MM/yyyy').format(ordemServico.dataAbertura!)
                : ''), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(ordemServico.descricaoProblema ?? ''), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(ordemServico.descricaoSolucao ?? ''), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
      ],
    );
  }

  @override
  int get rowCount => listaOrdensServico!.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;
}

void _detalharOdemServico(OrdemServicoMontada ordemServicoMontada,
    BuildContext context, Function refrescarTela) {
  showInSnackBar(
      'Deve abrir a tela de detalhe da ordem de serviço',
      corTexto: Colors.black,
      corFundo: Colors.white,
      context);
  /*
  Navigator.of(context)
      .push(MaterialPageRoute(
          builder: (BuildContext context) => ContasPagarPersistePage(
              ordemServicoMontada: ordemServicoMontada,
              title: 'Contas a Pagar - Editando',
              operacao: 'A')))
      .then((_) async {
    await refrescarTela();
  });
  */
}
