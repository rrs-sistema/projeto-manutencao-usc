import 'package:drift/drift.dart';
import 'package:manutencao_usc/src/database/tabelas/categoria.dart';
import 'package:manutencao_usc/src/database/tabelas/local.dart';
import 'package:manutencao_usc/src/database/tabelas/local_sub.dart';
import 'package:manutencao_usc/src/database/tabelas/status_ordem_servico.dart';
import 'package:manutencao_usc/src/database/tabelas/usuario.dart';
import 'package:manutencao_usc/src/infra/sessao.dart';

import '../tabelas/ordem_servico.dart';
import './../../database/app_db.dart';

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

  Future<List<OrdemServicoMontada>?> consultarListaMontado(
      {int? codigo, int? mes, int? ano, String? status}) async {
    final consulta = select(ordemServicos).join([
      leftOuterJoin(
          usuarios, usuarios.codigo.equalsExp(ordemServicos.codigoUsuario)),
      leftOuterJoin(locals, locals.codigo.equalsExp(ordemServicos.codigoLocal)),
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
      final status = row.readTableOrNull(statusOrdemServicos);

      return OrdemServicoMontada(
          ordemServico: ordemServico,
          usuario: usuario,
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

  Future<OrdemServico> pegaUltimaOrdemServico() async {
    final resultado = await customSelect(
            "select * from tb_ordem_servico order by codigo desc LIMIT 1;")
        .getSingleOrNull();
    return OrdemServico.fromData(resultado!.data);
  }

  Future<int> inserir(OrdemServicoMontada pObjeto) {
    return transaction(() async {
      pObjeto.ordemServico = pObjeto.ordemServico!.copyWith(
          dataAbertura: DateTime.now(), codigoStatus: 1, codigoUsuario: 1);
      return await into(ordemServicos).insert(pObjeto.ordemServico!);
    });
  }

  Future<bool> alterar(OrdemServicoMontada pObjeto) {
    return transaction(() async {
      return update(ordemServicos).replace(pObjeto.ordemServico!);
    });
  }

  Future<int> excluir(OrdemServicoMontada pObjeto) {
    return transaction(() async {
      return delete(ordemServicos).delete(pObjeto.ordemServico!);
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
