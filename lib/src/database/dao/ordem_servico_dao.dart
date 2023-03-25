import 'package:drift/drift.dart';
import 'package:manutencao_usc/src/database/tabelas/categoria.dart';
import 'package:manutencao_usc/src/database/tabelas/local.dart';
import 'package:manutencao_usc/src/database/tabelas/status_ordem_servico.dart';

import '../tabelas/ordem_servico.dart';
import './../../database/app_db.dart';

part 'ordem_servico_dao.g.dart';

@DriftAccessor(tables: [OrdemServicos, Categorias, Locals, StatusOrdemServicos])
class OrdemServicoDao extends DatabaseAccessor<AppDb>
    with _$OrdemServicoDaoMixin {
  final AppDb db;

  OrdemServicoDao(this.db) : super(db);

  List<OrdemServicoMontada>? listaOrdemServicoMontada;
  List<OrdemServico>? listaOrdemServico;

  Future<List<OrdemServico>?> consultarLista() => select(ordemServicos).get();

  Future<List<OrdemServicoMontada>?> consultarListaMontado(
      {int? mes, int? ano, String? status}) async {
    final consulta = select(ordemServicos).join([
      leftOuterJoin(locals, locals.codigo.equalsExp(ordemServicos.codigoLocal)),
      leftOuterJoin(categorias,
          categorias.codigo.equalsExp(ordemServicos.codigoCategoria)),
      leftOuterJoin(statusOrdemServicos,
          statusOrdemServicos.codigo.equalsExp(ordemServicos.codigoStatus)),
    ]);
    if (mes != null && ano != null) {
      consulta.where(ordemServicos.dataAbertura.month.equals(mes));
      consulta.where(ordemServicos.dataAbertura.year.equals(ano));
    }
    if (status != null) {
      switch (status) {
        case 'Aberto':
          consulta.where(ordemServicos.codigoStatus.equals(1));
          break;
        case 'Em andamento':
          consulta.where(ordemServicos.codigoStatus.equals(2));
          break;
        case 'Pendente':
          consulta.where(ordemServicos.codigoStatus.equals(3));
          break;
        default:
          consulta.where(ordemServicos.codigoStatus.isBiggerThanValue(0));
      }
    }
    listaOrdemServicoMontada = await consulta.map((row) {
      final ordemServico = row.readTableOrNull(ordemServicos);
      final categoria = row.readTableOrNull(categorias);
      final local = row.readTableOrNull(locals);
      final status = row.readTableOrNull(statusOrdemServicos);

      return OrdemServicoMontada(
          ordemServico: ordemServico,
          categoria: categoria,
          local: local,
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

  Future<int> ultimoId() async {
    final resultado =
        await customSelect("select MAX(codigo) as ULTIMO from tb_ordem_servico")
            .getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  }

  Future<int> inserir(OrdemServico pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(codigo: maxId + 1);
      final idInserido = await into(ordemServicos).insert(pObjeto);
      return idInserido;
    });
  }

  Future<bool> alterar(OrdemServico pObjeto) {
    return transaction(() async {
      return update(ordemServicos).replace(pObjeto);
    });
  }

  Future<int> excluir(OrdemServico pObjeto) {
    return transaction(() async {
      return delete(ordemServicos).delete(pObjeto);
    });
  }

  static List<String> campos = <String>[
    'ID',
    'DATA_ABERTURA',
    'DATA_ATENDIMENTO',
    'CATEGORIA',
    'LOCAL',
    'DESCRICAO_PROBLEMA',
    'NOME_USUARIO',
    'CONTATO_EMAIL',
    'CONTATO_CELULAR',
    'STATUS_ORDERM_SERVICO',
  ];

  static List<String> colunas = <String>[
    'Id',
    'Data de Abertura',
    'Data de Atendimento',
    'Categoria',
    'Local',
    'Problema',
    'Usuário',
    'Celular',
    'E-mail',
    'Status da OS',
  ];
}
