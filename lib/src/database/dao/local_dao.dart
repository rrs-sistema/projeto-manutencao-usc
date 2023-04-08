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

  List<Local>? listaLocal;

  Future<List<Local>?> consultarLista() async {
    listaLocal = await select(locals).get()
      ..where((c) => c.deletado == 'N');
    return listaLocal;
  }

  Future<List<Local>?> consultarListaFiltro(String campo, String valor) async {
    listaLocal = await (customSelect(
        "SELECT * FROM tb_local WHERE $campo like '%$valor%' AND deletado = 'N'",
        readsFrom: {locals}).map((row) {
      return Local.fromData(row.data);
    }).get());
    return listaLocal;
  }

  Future<int> inserir(Local pObjeto) {
    return transaction(() async {
      return await into(locals).insert(pObjeto);
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

  static List<String> campos = <String>[
    'codigo',
    'nome',
  ];

  static List<String> colunas = <String>[
    'Código',
    'nome',
  ];
}
