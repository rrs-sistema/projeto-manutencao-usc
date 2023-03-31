import 'package:drift/drift.dart';
import 'package:shared_preferences/shared_preferences.dart';

import './../tabelas/status_ordem_servico.dart';
import './../tabelas/ordem_servico.dart';
import './../tabelas/categoria.dart';
import './../tabelas/local_sub.dart';
import './../tabelas/usuario.dart';
import './../../infra/sessao.dart';
import './../tabelas/local.dart';
import './../app_db.dart';

part 'ordem_servico_dao.g.dart';

@DriftAccessor(tables: [
  OrdemServicos,
  Categorias,
  Locals,
  LocalSubs,
  StatusOrdemServicos,
  Usuarios
])
class OrdemServicoDao extends DatabaseAccessor<AppDb>
    with _$OrdemServicoDaoMixin {
  final AppDb db;

  OrdemServicoDao(this.db) : super(db);

  List<OrdemServicoMontada>? listaOrdemServicoMontada;
  List<OrdemServico>? listaOrdemServico;

  Future<List<OrdemServico>?> consultarLista() => select(ordemServicos).get();

  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  Future<List<OrdemServicoMontada>?> consultarListaMontado(
      {int? codigo, int? mes, int? ano, String? status}) async {
    final consulta = select(ordemServicos).join([
      leftOuterJoin(
          usuarios, usuarios.codigo.equalsExp(ordemServicos.codigoUsuario)),
      leftOuterJoin(locals, locals.codigo.equalsExp(ordemServicos.codigoLocal)),
      //leftOuterJoin(localSubs, localSubs.codigoLocal.equalsExp(locals.codigo)),
      leftOuterJoin(
        localSubs,
        localSubs.codigo.equalsExp(ordemServicos.codigoSubLocal),
      ),
      leftOuterJoin(categorias,
          categorias.codigo.equalsExp(ordemServicos.codigoCategoria)),
      leftOuterJoin(statusOrdemServicos,
          statusOrdemServicos.codigo.equalsExp(ordemServicos.codigoStatus)),
    ]);
    if (codigo != null) {
      consulta.where(ordemServicos.codigo.equals(codigo));
    } else if (mes != null && ano != null) {
      consulta.where(ordemServicos.dataAbertura.month.equals(mes));
      consulta.where(ordemServicos.dataAbertura.year.equals(ano));
    }
    if (status != null && status.isNotEmpty) {
      var statusReal = await Sessao.db.statusOrdemServicoDao
          .consultarListaFiltro('nome', status);
      if (statusReal != null && statusReal.isNotEmpty) {
        consulta.where(ordemServicos.codigoStatus.equals(statusReal[0].codigo));
      }
    }
    listaOrdemServicoMontada = await consulta.map((row) {
      final ordemServico = row.readTableOrNull(ordemServicos);
      final usuario = row.readTableOrNull(usuarios);
      final categoria = row.readTableOrNull(categorias);
      final local = row.readTableOrNull(locals);
      final localSub = row.readTableOrNull(localSubs);
      final status = row.readTableOrNull(statusOrdemServicos);

      return OrdemServicoMontada(
          ordemServico: ordemServico,
          usuario: usuario,
          categoria: categoria,
          local: local,
          localSub: localSub,
          statusOrdemServico: status);
    }).get();
    return listaOrdemServicoMontada;
  }

  Future<List<OrdemServico>?> consultarListaFiltro(
      String campo, String valor) async {
    listaOrdemServico = (await (customSelect(
            "SELECT * FROM tb_ordem_servico WHERE $campo like '%$valor%'",
            readsFrom: {ordemServicos}).map((row) {
      return OrdemServico.fromData(row.data);
    }).get()))
        .cast<OrdemServico>();
    return listaOrdemServico;
  }

  Future<OrdemServico?> pegaUltimaOrdemServico() async {
    final resultado = await customSelect(
            "select * from tb_ordem_servico order by codigo desc LIMIT 1;")
        .getSingleOrNull();
    if (resultado == null) return null;
    return OrdemServico.fromData(resultado.data);
  }

  Future<int> inserir(OrdemServico ordemServico) {
    return transaction(() async {
      final SharedPreferences prefs = await _prefs;
      dynamic codigoUsuario = prefs.get("codigoUsuario");
      if (codigoUsuario != null || codigoUsuario > 0) {
        return 0;
      }
      ordemServico = ordemServico.copyWith(
          dataAbertura: DateTime.now(),
          codigoStatus: 1,
          codigoUsuario: codigoUsuario);
      return await into(ordemServicos).insert(ordemServico);
    });
  }

  Future<bool> alterar(OrdemServico ordemServico) {
    return transaction(() async {
      return update(ordemServicos).replace(ordemServico);
    });
  }

  Future<int> excluir(OrdemServico ordemServico) {
    return transaction(() async {
      return delete(ordemServicos).delete(ordemServico);
    });
  }

  static List<String> campos = <String>[
    'codigo',
    'data_abertura',
    'data_encerramento',
    'descricao_problema',
    'descricao_solucao',
  ];

  static List<String> colunas = <String>[
    'Código',
    'Data de Abertura',
    'Data de Atendimento',
    'Descrição do problema',
    'Descrição da solução',
  ];
}
