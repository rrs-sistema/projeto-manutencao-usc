import 'package:drift/drift.dart';

import '../tabelas/sexo.dart';
import './../app_db.dart';

part 'sexo_dao.g.dart';

@DriftAccessor(tables: [
  Sexos,
])
class SexoDao extends DatabaseAccessor<AppDb> with _$SexoDaoMixin {
  final AppDb db;

  SexoDao(this.db) : super(db);

  List<Sexo>? listaSexo;

  Future<List<Sexo>?> consultarLista() async {
    listaSexo = await select(sexos).get();
    return listaSexo;
  }

  Future<List<Sexo>?> consultarListaFiltro(String campo, String valor) async {
    listaSexo = await (customSelect(
        "SELECT * FROM tb_sexo WHERE $campo like '%$valor%' AND deletado = 'N'",
        readsFrom: {sexos}).map((row) {
      return Sexo.fromData(row.data);
    }).get());
    return listaSexo;
  }

  Future<int> inserir(Sexo pObjeto) {
    return transaction(() async {
      return await into(sexos).insert(pObjeto);
    });
  }

  Future<bool> alterar(Sexo pObjeto) {
    return transaction(() async {
      return update(sexos).replace(pObjeto);
    });
  }

  Future<bool> excluir(Sexo pObjeto) {
    return transaction(() async {
      pObjeto = pObjeto.copyWith(deletado: 'S');
      return update(sexos).replace(pObjeto);
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
