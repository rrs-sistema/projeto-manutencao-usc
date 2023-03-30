import 'package:drift/drift.dart';

import '../tabelas/permissao.dart';
import './../app_db.dart';

part 'permissao_dao.g.dart';

@DriftAccessor(tables: [
  Permissaos,
])
class PermissaoDao extends DatabaseAccessor<AppDb> with _$PermissaoDaoMixin {
  final AppDb db;

  PermissaoDao(this.db) : super(db);

  List<Permissao>? listaPermissao;

  Future<List<Permissao>?> consultarLista() async {
    listaPermissao = await select(permissaos).get();
    return listaPermissao;
  }

  Future<List<Permissao>?> consultarListaFiltro(
      String campo, String valor) async {
    listaPermissao = await (customSelect(
        "SELECT * FROM tb_permissao WHERE $campo like '%$valor%'",
        readsFrom: {permissaos}).map((row) {
      return Permissao.fromData(row.data);
    }).get());
    return listaPermissao;
  }

  Future<int> inserir(Permissao pObjeto) {
    return transaction(() async {
      return await into(permissaos).insert(pObjeto);
    });
  }

  Future<bool> alterar(Permissao pObjeto) {
    return transaction(() async {
      return update(permissaos).replace(pObjeto);
    });
  }

  Future<int> excluir(Permissao pObjeto) {
    return transaction(() async {
      return delete(permissaos).delete(pObjeto);
    });
  }

  static List<String> campos = <String>[
    'nome',
    'descricao',
  ];

  static List<String> colunas = <String>[
    'nome',
    'descricao',
  ];
}
