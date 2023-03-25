import 'package:drift/drift.dart';

import '../tabelas/usuario.dart';
import './../app_db.dart';

part 'usuario_dao.g.dart';

@DriftAccessor(tables: [
  Usuarios,
])
class UsuarioDao extends DatabaseAccessor<AppDb> with _$UsuarioDaoMixin {
  final AppDb db;

  UsuarioDao(this.db) : super(db);

  Future<List<Usuario>?> consultarLista() => select(usuarios).get();

  Future<int> ultimoId() async {
    final resultado =
        await customSelect("select MAX(codigo) as ULTIMO from tb_usuario")
            .getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  }

  Future<int> inserir(Usuario pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(codigo: maxId + 1);
      final idInserido = await into(usuarios).insert(pObjeto);
      return idInserido;
    });
  }

  Future<bool> alterar(Usuario pObjeto) {
    return transaction(() async {
      return update(usuarios).replace(pObjeto);
    });
  }

  Future<int> excluir(Usuario pObjeto) {
    return transaction(() async {
      return delete(usuarios).delete(pObjeto);
    });
  }
}
