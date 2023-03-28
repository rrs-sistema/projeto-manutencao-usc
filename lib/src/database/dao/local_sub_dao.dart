import 'package:drift/drift.dart';

import '../tabelas/local_sub.dart';
import '../tabelas/local.dart';
import './../app_db.dart';

part 'local_sub_dao.g.dart';

@DriftAccessor(tables: [Locals, LocalSubs])
class LocalSubDao extends DatabaseAccessor<AppDb> with _$LocalSubDaoMixin {
  final AppDb db;

  LocalSubDao(this.db) : super(db);
  List<LocalSub>? listaLocal;
  List<LocalSubMontado>? listaLocalSubMontado;

  Future<List<LocalSub>?> consultarLista() async {
    listaLocal = await select(localSubs).get();
    return listaLocal;
  }

  Future<List<LocalSubMontado>?> consultarListaMontado(
      {String? campo, dynamic valor}) async {
    final consulta = select(localSubs).join([
      leftOuterJoin(locals, locals.codigo.equalsExp(localSubs.codigoLocal)),
    ]);
    if (campo != null && campo != '') {
      final coluna =
          localSubs.$columns.where(((coluna) => coluna.$name == campo)).first;
      if (coluna is TextColumn) {
        consulta.where((coluna as TextColumn).like('%$valor%'));
      } else if (coluna is IntColumn) {
        consulta.where(coluna.equals(int.tryParse(valor)));
      } else if (coluna is RealColumn) {
        consulta.where(coluna.equals(double.tryParse(valor)));
      }
    }
    listaLocalSubMontado = await consulta.map((row) {
      final localSub = row.readTableOrNull(localSubs);
      final local = row.readTableOrNull(locals);

      return LocalSubMontado(localSub: localSub, local: local);
    }).get();
    return listaLocalSubMontado;
  }

  Stream<List<LocalSub>> observarLista() => select(localSubs).watch();

  Future<LocalSub?> consultarObjeto(int pId) {
    return (select(localSubs)..where((t) => t.codigo.equals(pId)))
        .getSingleOrNull();
  }

  Future<List<LocalSub>?> consultarListaFiltro(
      String campo, String valor) async {
    listaLocal = await (customSelect(
        "SELECT * FROM tb_local_sub WHERE $campo like '%$valor%'",
        readsFrom: {localSubs}).map((row) {
      return LocalSub.fromData(row.data);
    }).get());
    return listaLocal;
  }

  Future<int> inserir(LocalSub pObjeto) {
    return transaction(() async {
      return await into(localSubs).insert(pObjeto);
    });
  }

  Future<bool> alterar(LocalSub pObjeto) {
    return transaction(() async {
      return update(localSubs).replace(pObjeto);
    });
  }

  Future<int> excluir(LocalSub pObjeto) {
    return transaction(() async {
      return delete(localSubs).delete(pObjeto);
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
