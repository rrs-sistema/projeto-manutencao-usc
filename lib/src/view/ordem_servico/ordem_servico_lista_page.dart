import 'package:brasil_fields/brasil_fields.dart';
import 'package:backdrop/backdrop.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';

import './../ordem_servico/ordem_servico_persiste_page.dart';
import './../../database/tabelas/ordem_servico.dart';
import './../../infra/atalhos_desktop_web.dart';
import './../shared/caixas_de_dialogo.dart';
import '../shared/page/filtro_page.dart';
import './../shared/gradiente_app.dart';
import './../shared/view_util_lib.dart';
import './../shared/widgets_caixa.dart';
import './../shared/widgets_input.dart';
import './../../database/dao/dao.dart';
import './../../database/app_db.dart';
import './../../infra/sessao.dart';
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
  int _totalGeral = 0;
  int _totaEmAndamento = 0;
  int _totaFinalizada = 0;
  List<OrdemServicoMontada>? _listaOrdensServicoMontada;
  final List<String> _listaStatus = ['Todos'];

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
    WidgetsBinding.instance.addPostFrameCallback((_) => _getStatus());
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
                      decoration: getInputDecoration(
                          Biblioteca.isDesktop()
                              ? 'Mês/ano para o filtro'
                              : 'Mês/ano',
                          Biblioteca.isDesktop()
                              ? 'Mês/ano para o filtro'
                              : 'Mês/ano',
                          true,
                          cor: Constantes.primaryColor,
                          labelStyleHint: const TextStyle(color: Colors.white),
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          )),
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
                          Biblioteca.isDesktop()
                              ? 'Status da ordem de serviço'
                              : 'Status da O.S.',
                          Biblioteca.isDesktop()
                              ? 'Status da ordem de serviço'
                              : 'Status da O.S.',
                          true,
                          labelStyle: const TextStyle(
                            color: Colors.white,
                          ),
                          paddingVertical: 1),
                      isEmpty: _statusOrdensServico == null,
                      child: getDropDownButton(_statusOrdensServico,
                          colorTextStyle: Colors.white, (String? newValue) {
                        _statusOrdensServico = newValue;
                        _refrescarTela();
                      }, _listaStatus),
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
                                    label: const Center(
                                      child: Text(
                                        'Status',
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
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
                                    label: const Text('Área'),
                                    tooltip: 'Área do problema ocorrido',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<String>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .localSub?.nome,
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
                                    label: const Text('Usuário nome'),
                                    tooltip: 'Quem abriu a ordem de serviço',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<String>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .usuario!.nome,
                                            columnIndex,
                                            ascending),
                                  ),
                                  DataColumn(
                                    label: const Text('Usuário celular'),
                                    tooltip: 'Celular do usuário',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<String>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .usuario!.celular,
                                            columnIndex,
                                            ascending),
                                  ),
                                  DataColumn(
                                    label: const Text('Usuário email'),
                                    tooltip: 'E-mail do usuário',
                                    onSort: (int columnIndex, bool ascending) =>
                                        _sort<String>(
                                            (OrdemServicoMontada
                                                    ordensServicoMontada) =>
                                                ordensServicoMontada
                                                    .usuario!.email,
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
                valor: '$_totalGeral',
                corFundo: Colors.blue.shade100,
              ),
              getItemResumoValor(
                descricao: 'Total em andamento: ',
                valor: '$_totaEmAndamento',
                corFundo: Colors.red.shade100,
              ),
              getItemResumoValor(
                descricao: 'Total finalizada: ',
                valor: '$_totaFinalizada',
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
    Navigator.of(context)
        .push(MaterialPageRoute(
            builder: (BuildContext context) => OrdemServicoPersistePage(
                osMontada: OrdemServicoMontada(
                    ordemServico: OrdemServico(),
                    categoria: Categoria(),
                    local: Local(),
                    localSub: LocalSub(),
                    statusOrdemServico: StatusOrdemServico()),
                title: 'Ordem de Serviço - Inserindo',
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

  Future _getStatus() async {
    var listStatusOs = await Sessao.db.statusOrdemServicoDao.consultarLista();
    for (var status in listStatusOs!) {
      _listaStatus.add(status.nome!);
    }
    _atualizarTotais();
    setState(() {});
  }

  _atualizarTotais() {
    if (_listaOrdensServicoMontada == null) return;
    _totalGeral = _listaOrdensServicoMontada!.length;
    _totaEmAndamento = 0;
    _totaFinalizada = 0;
    for (OrdemServicoMontada ordemServicoMontada
        in _listaOrdensServicoMontada!) {
      if (ordemServicoMontada.statusOrdemServico!.nome!
          .toLowerCase()
          .contains('andamento')) {
        _totaEmAndamento = _totaEmAndamento + 1;
      } else if (ordemServicoMontada.statusOrdemServico!.nome!
          .toLowerCase()
          .contains('finaliza')) {
        _totaFinalizada = _totaFinalizada + 1;
      }
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
    final Usuario usuario = ordemServicoMontado.usuario!;
    final StatusOrdemServico status = ordemServicoMontado.statusOrdemServico!;

    Icon iconSituacao = const Icon(
      FontAwesomeIcons.circleCheck,
      color: Colors.red,
    );

    if (status.nome!.toLowerCase().contains('finalizado')) {
      iconSituacao = const Icon(
        FontAwesomeIcons.squareCheck,
        color: Colors.green, //check-square-o
      );
    }
    if (status.nome!.toLowerCase().contains('andamento')) {
      iconSituacao = const Icon(
        FontAwesomeIcons.circlePlay,
        color: Colors.blue,
      );
    }

    return DataRow.byIndex(
      index: index,
      cells: <DataCell>[
        DataCell(Center(child: iconSituacao), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(ordemServicoMontado.categoria?.nome ?? ''), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(ordemServicoMontado.local?.nome ?? ''), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(ordemServicoMontado.localSub?.nome ?? ''), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(
            Text(ordemServico.dataAbertura != null
                ? DateFormat('dd/MM/yyyy').format(ordemServico.dataAbertura!)
                : ''), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(usuario.nome ?? ''), onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(UtilBrasilFields.obterTelefone(usuario.celular ?? '')),
            onTap: () {
          _detalharOdemServico(ordemServicoMontado, context, refrescarTela);
        }),
        DataCell(Text(usuario.email ?? ''), onTap: () {
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
  Navigator.of(context)
      .push(MaterialPageRoute(
          builder: (BuildContext context) => OrdemServicoPersistePage(
              osMontada: ordemServicoMontada,
              title: 'Ordem de Serviço - Editando',
              operacao: 'A')))
      .then((_) async {
    await refrescarTela();
  });
}
