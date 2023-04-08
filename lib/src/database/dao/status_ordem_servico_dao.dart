import 'package:drift/drift.dart';

import '../tabelas/status_ordem_servico.dart';
import './../app_db.dart';

part 'status_ordem_servico_dao.g.dart';

@DriftAccessor(tables: [
  StatusOrdemServicos,
])
class StatusOrdemServicoDao extends DatabaseAccessor<AppDb>
    with _$StatusOrdemServicoDaoMixin {
  final AppDb db;

  StatusOrdemServicoDao(this.db) : super(db);

  List<StatusOrdemServico>? listaStatus;

  Future<List<StatusOrdemServico>?> consultarLista() async {
    listaStatus = await select(statusOrdemServicos).get()
      ..where((c) => c.deletado == 'N');
    return listaStatus;
  }

  Future<List<StatusOrdemServico>?> consultarListaFiltro(
      String campo, String valor) async {
    listaStatus = await (customSelect(
        "SELECT * FROM tb_status_ordem_servico WHERE $campo like '%$valor%' AND deletado = 'N'",
        readsFrom: {statusOrdemServicos}).map((row) {
      return StatusOrdemServico.fromData(row.data);
    }).get());
    return listaStatus;
  }

  Future<int> inserir(StatusOrdemServico pObjeto) {
    return transaction(() async {
      return await into(statusOrdemServicos).insert(pObjeto);
    });
  }

  Future<bool> alterar(StatusOrdemServico pObjeto) {
    return transaction(() async {
      return update(statusOrdemServicos).replace(pObjeto);
    });
  }

  Future<int> excluir(StatusOrdemServico pObjeto) {
    return transaction(() async {
      return delete(statusOrdemServicos).delete(pObjeto);
    });
  }

  static List<String> campos = <String>[
    'codigo',
    'nome',
  ];

  static List<String> colunas = <String>[
    'Código',
    'nome',
  ];
}
