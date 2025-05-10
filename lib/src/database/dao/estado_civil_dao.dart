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

  List<EstadoCivil>? listaEstadoCivil;

  Future<List<EstadoCivil>?> consultarLista() async {
    listaEstadoCivil = await select(estadoCivils).get();
    return listaEstadoCivil;
  }

  Future<List<EstadoCivil>?> consultarListaFiltro(
      String campo, String valor) async {
    listaEstadoCivil = await (customSelect(
        "SELECT * FROM tb_estado_civil WHERE $campo like '%$valor%' AND deletado = 'N'",
        readsFrom: {estadoCivils}).map((row) {
      return EstadoCivil.fromData(row.data);
    }).get());
    return listaEstadoCivil;
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

  Future<bool> excluir(EstadoCivil pObjeto) {
    return transaction(() async {
      pObjeto = pObjeto.copyWith(deletado: 'S');
      return update(estadoCivils).replace(pObjeto);
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
