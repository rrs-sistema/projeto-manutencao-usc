import 'package:drift/drift.dart';

import '../tabelas/categoria.dart';
import './../app_db.dart';

part 'categoria_dao.g.dart';

@DriftAccessor(tables: [
  Categorias,
])
class CategoriaDao extends DatabaseAccessor<AppDb> with _$CategoriaDaoMixin {
  final AppDb db;

  CategoriaDao(this.db) : super(db);

  Future<List<Categoria>?> consultarLista() => select(categorias).get();

  Future<int> ultimoId() async {
    final resultado =
        await customSelect("select MAX(codigo) as ULTIMO from tb_categoria")
            .getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  }

  Future<int> inserir(Categoria pObjeto) {
    return transaction(() async {
      final maxId = await ultimoId();
      pObjeto = pObjeto.copyWith(codigo: maxId + 1);
      final idInserido = await into(categorias).insert(pObjeto);
      return idInserido;
    });
  }

  Future<bool> alterar(Categoria pObjeto) {
    return transaction(() async {
      return update(categorias).replace(pObjeto);
    });
  }

  Future<int> excluir(Categoria pObjeto) {
    return transaction(() async {
      return delete(categorias).delete(pObjeto);
    });
  }
}
