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

  Future<List<StatusOrdemServico>?> consultarLista() =>
      select(statusOrdemServicos).get();

  Future<int> ultimoId() async {
    final resultado = await customSelect(
            "select MAX(codigo) as ULTIMO from tb_status_ordem_servico")
        .getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  }

  Future<int> inserir(StatusOrdemServico pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(codigo: maxId + 1);
      final idInserido = await into(statusOrdemServicos).insert(pObjeto);
      return idInserido;
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
}
