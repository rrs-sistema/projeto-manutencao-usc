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

  List<Categoria>? listaCategoria;

  Future<List<Categoria>?> consultarLista() async {
    listaCategoria = await select(categorias).get();
    return listaCategoria;
  }

  Future<List<Categoria>?> consultarListaFiltro(
      String campo, String valor) async {
    listaCategoria = await (customSelect(
        "SELECT * FROM tb_categoria WHERE $campo like '%$valor%'",
        readsFrom: {categorias}).map((row) {
      return Categoria.fromData(row.data);
    }).get());
    return listaCategoria;
  }

  Future<int> inserir(Categoria pObjeto) {
    return transaction(() async {
      return await into(categorias).insert(pObjeto);
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

  static List<String> campos = <String>[
    'codigo',
    'nome',
  ];

  static List<String> colunas = <String>[
    'Código',
    'nome',
  ];
}
