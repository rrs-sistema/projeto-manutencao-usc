import 'dart:convert';
// ignore: depend_on_referenced_packages
import 'package:recase/recase.dart';
import 'package:flutter/material.dart';

import './../../../view/shared/caixas_de_dialogo.dart';
import './../../../view/shared/gradiente_app.dart';
import './../../../infra/atalhos_desktop_web.dart';
import './../../../infra/biblioteca.dart';
import './../../../infra/sessao.dart';
import './../../../model/model.dart';

class LookupLocalPage extends StatefulWidget {
  final String? title;
  final List<String?>? colunas;
  final List<String>? campos;
  final String? rota;
  final String? campoPesquisaPadrao;
  final String? valorPesquisaPadrao;
  final String? filtroAdicional;
  final Function? metodoConsultaCallBack;
  final Function? metodoCadastroCallBack;
  final bool permiteCadastro;

  // ignore: todo
  // TODO: limitar a quantidade de registros para não deixar a consulta lenta
  const LookupLocalPage(
      {Key? key,
      this.title,
      this.colunas,
      this.campos,
      this.rota,
      this.campoPesquisaPadrao,
      this.valorPesquisaPadrao,
      this.metodoConsultaCallBack,
      this.metodoCadastroCallBack,
      this.filtroAdicional,
      this.permiteCadastro = false})
      : super(key: key);

  @override
  LookupLocalPageState createState() => LookupLocalPageState();
}

class LookupLocalPageState extends State<LookupLocalPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  static Map<String, dynamic> _resultadoFiltro = {};
  static bool _dadosCarregados = true;
  String? _campoFiltro;
  final List<DataRow> _rowList = [];
  final _valorFiltroController = TextEditingController();
  final _focusNode = FocusNode();

  Map<LogicalKeySet, Intent>? _shortcutMap;
  Map<Type, Action<Intent>>? _actionMap;
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
    if (widget.campoPesquisaPadrao != null) {
      _campoFiltro =
          widget.colunas![widget.campos!.indexOf(widget.campoPesquisaPadrao!)];
    }
    if (widget.valorPesquisaPadrao != null) {
      _valorFiltroController.text = widget.valorPesquisaPadrao!;
      WidgetsBinding.instance.addPostFrameCallback((_) => _efetuarConsulta());
    }
    _focusNode.requestFocus();
    if (controllerScroll.hasClients) {
      controllerScroll.jumpTo(50.0);
    }
  }

  void _tratarAcoesAtalhos(AtalhoTelaIntent intent) {
    switch (intent.type) {
      case AtalhoTelaType.escape:
        Navigator.pop(context);
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FocusableActionDetector(
      actions: _actionMap,
      shortcuts: _shortcutMap,
      child: Focus(
        autofocus: true,
        child: Scaffold(
          key: _scaffoldKey,
          appBar: AppBar(
            title: Text(widget.title!),
            centerTitle:
                Biblioteca.isTelaPequena(context) == true ? true : false,
            actions: _getActions(),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: gradienteApp(),
              ),
            ),
          ),
          body: SafeArea(
            child: ListView(
              controller: controllerScroll,
              padding: const EdgeInsets.all(16.0),
              children: <Widget>[
                InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Coluna',
                    hintText: 'Selecione a coluna para o filtro',
                    contentPadding: EdgeInsets.zero,
                  ),
                  isEmpty: _campoFiltro == null,
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: _campoFiltro,
                    onChanged: (String? newValue) {
                      setState(() {
                        _campoFiltro = newValue;
                      });
                    },
                    items: widget.colunas!
                        .map<DropdownMenuItem<String>>((String? value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value!),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(height: 1.0),
                Container(
                  height: 90.0,
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  alignment: Alignment.bottomLeft,
                  child: TextField(
                    focusNode: _focusNode,
                    onSubmitted: (value) async {
                      await _efetuarConsulta();
                    },
                    controller: _valorFiltroController,
                    decoration: const InputDecoration(
                      labelText: 'Valor',
                      hintText: 'Informe o valor do filtro para a consulta',
                      filled: true,
                    ),
                  ),
                ),
                const SizedBox(height: 10.0),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.all(8.0),
                  child: _dadosCarregados == false
                      ? const Center(child: CircularProgressIndicator())
                      : DataTable(columns: _getColumns(), rows: _rowList),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future _efetuarConsulta() async {
    if (_campoFiltro == null) {
      showInSnackBar('Por favor, selecione a coluna para o filtro', context);
      _focusNode.requestFocus();
    } else {
      if (_valorFiltroController.text == '') {
        showInSnackBar('Por favor, informe um valor para o filtro', context);
        _focusNode.requestFocus();
      } else {
        // refresca a tela
        setState(() {
          _dadosCarregados = false;
        });
        _rowList.clear();
        var filtro = Filtro();
        filtro.campo = widget.campos![widget.colunas!.indexOf(_campoFiltro)];
        filtro.valor = _valorFiltroController.text;
        filtro.condicao = 'cont';
        filtro.where = widget.filtroAdicional;
        await widget.metodoConsultaCallBack!(filtro.campo, filtro.valor);
        await _carregarDados(filtro);
      }
    }
  }

  Future _carregarDados(Filtro filtro) async {
    var listaDadosJson = json.decode(Sessao.retornoJsonLookup) as List<dynamic>;

    // faz o laço na lista de registros da consulta
    for (var objetoJson in listaDadosJson) {
      // cria o array que vai armazenar as celulas - cada linha da tabela possui um array de celulas
      List<DataCell> celulas = [];

      /// compara os campos do objeto Json com as colunas desejadas para a datatable e
      /// preenche os campos de acordo
      for (var i = 0; i < widget.campos!.length; i++) {
        var nomeCampoTabela = widget.campos![i].camelCase;
        for (var j = 0; j < objetoJson.length; j++) {
          var nomeCampoJson = objetoJson.keys.toList()[j];
          if (nomeCampoJson == nomeCampoTabela) {
            var conteudoCampo = objetoJson.values.toList()[j];
            DataCell celula = DataCell(
                Text(Biblioteca.formatarCampoLookup(conteudoCampo.toString(),
                    formatoTimeStamp: nomeCampoJson.contains('data'))),
                onTap: () {
              _resultadoFiltro = objetoJson;
              Navigator.pop(context, _resultadoFiltro);
            });
            celulas.add(celula);
          }
        }
      }
      _rowList.add(DataRow(cells: celulas));
    }
    // refresca a tela
    setState(() {
      _dadosCarregados = true;
    });
    _focusNode.requestFocus();
  }

  List<DataColumn> _getColumns() {
    List<DataColumn> lista = [];
    for (var i = 0; i < widget.colunas!.length; i++) {
      lista.add(DataColumn(label: Text(widget.colunas![i]!)));
    }
    return lista;
  }

  List<Widget> _getActions() {
    List<Widget> botoes = [];
    botoes.add(
      IconButton(
        icon: const Icon(Icons.search, color: Colors.white),
        onPressed: () async {
          await _efetuarConsulta();
        },
      ),
    );

    if (widget.permiteCadastro) {
      botoes.add(
        IconButton(
          icon: const Icon(Icons.add, color: Colors.white),
          onPressed: widget.metodoCadastroCallBack as void Function()?,
        ),
      );
    }

    return botoes;
  }
}
