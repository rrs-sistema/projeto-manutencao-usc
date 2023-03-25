import 'package:drift/drift.dart';

import '../tabelas/local.dart';
import './../app_db.dart';

part 'local_dao.g.dart';

@DriftAccessor(tables: [
  Locals,
])
class LocalDao extends DatabaseAccessor<AppDb> with _$LocalDaoMixin {
  final AppDb db;

  LocalDao(this.db) : super(db);

  Future<List<Local>?> consultarLista() => select(locals).get();

  Future<int> ultimoId() async {
    final resultado =
        await customSelect("select MAX(codigo) as ULTIMO from tb_local")
            .getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  }

  Future<int> inserir(Local pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(codigo: maxId + 1);
      final idInserido = await into(locals).insert(pObjeto);
      return idInserido;
    });
  }

  Future<bool> alterar(Local pObjeto) {
    return transaction(() async {
      return update(locals).replace(pObjeto);
    });
  }

  Future<int> excluir(Local pObjeto) {
    return transaction(() async {
      return delete(locals).delete(pObjeto);
    });
  }
}
