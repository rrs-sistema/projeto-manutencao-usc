import 'package:drift/drift.dart';

import '../tabelas/estado_civil.dart';
import './../app_db.dart';

part 'estado_civil_dao.g.dart';

@DriftAccessor(tables: [
  EstadoCivils,
])
class EstadoCivilDao extends DatabaseAccessor<AppDb>
    with _$EstadoCivilDaoMixin {
  final AppDb db;

  EstadoCivilDao(this.db) : super(db);

  List<EstadoCivil>? listaLocal;

  Future<List<EstadoCivil>?> consultarLista() async {
    listaLocal = await select(estadoCivils).get();
    return listaLocal;
  }

  Future<List<EstadoCivil>?> consultarListaFiltro(
      String campo, String valor) async {
    listaLocal = await (customSelect(
        "SELECT * FROM tb_local WHERE $campo like '%$valor%' AND deletado = 'N'",
        readsFrom: {estadoCivils}).map((row) {
      return EstadoCivil.fromData(row.data);
    }).get());
    return listaLocal;
  }

  Future<int> inserir(EstadoCivil pObjeto) {
    return transaction(() async {
      return await into(estadoCivils).insert(pObjeto);
    });
  }

  Future<bool> alterar(EstadoCivil pObjeto) {
    return transaction(() async {
      return update(estadoCivils).replace(pObjeto);
    });
  }

  Future<int> excluir(EstadoCivil pObjeto) {
    return transaction(() async {
      return delete(estadoCivils).delete(pObjeto);
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
