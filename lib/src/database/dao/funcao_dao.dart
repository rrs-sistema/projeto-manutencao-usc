import 'package:drift/drift.dart';

import '../tabelas/funcao.dart';
import './../app_db.dart';

part 'funcao_dao.g.dart';

@DriftAccessor(tables: [
  Funcaos,
])
class FuncaoDao extends DatabaseAccessor<AppDb> with _$FuncaoDaoMixin {
  final AppDb db;

  FuncaoDao(this.db) : super(db);

  List<Funcao>? listaLocal;

  Future<List<Funcao>?> consultarLista() async {
    listaLocal = await select(funcaos).get()
      ..where((c) => c.deletado == 'N');
    return listaLocal;
  }

  Future<List<Funcao>?> consultarListaFiltro(String campo, String valor) async {
    listaLocal = await (customSelect(
        "SELECT * FROM tb_funcao WHERE $campo like '%$valor%' AND deletado = 'N'",
        readsFrom: {funcaos}).map((row) {
      return Funcao.fromData(row.data);
    }).get());
    return listaLocal;
  }

  Future<int> inserir(Funcao pObjeto) {
    return transaction(() async {
      return await into(funcaos).insert(pObjeto);
    });
  }

  Future<bool> alterar(Funcao pObjeto) {
    return transaction(() async {
      return update(funcaos).replace(pObjeto);
    });
  }

  Future<int> excluir(Funcao pObjeto) {
    return transaction(() async {
      return delete(funcaos).delete(pObjeto);
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
