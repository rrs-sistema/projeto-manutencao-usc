import 'package:drift/drift.dart';

import '../tabelas/colaborador.dart';
import './../app_db.dart';

part 'colaborador_dao.g.dart';

@DriftAccessor(tables: [
  Colaboradors,
])
class ColaboradorDao extends DatabaseAccessor<AppDb>
    with _$ColaboradorDaoMixin {
  final AppDb db;

  ColaboradorDao(this.db) : super(db);

  List<Colaborador>? listaColaborador;

  Future<List<Colaborador>?> consultarLista() async {
    listaColaborador = await select(colaboradors).get();
    return listaColaborador;
  }

  Future<List<Colaborador>?> consultarListaFiltro(
      String campo, String valor) async {
    listaColaborador = await (customSelect(
        "SELECT * FROM tb_colaborador WHERE $campo like '%$valor%'",
        readsFrom: {colaboradors}).map((row) {
      return Colaborador.fromData(row.data);
    }).get());
    return listaColaborador;
  }

  Future<int> inserir(Colaborador pObjeto) {
    return transaction(() async {
      return await into(colaboradors).insert(pObjeto);
    });
  }

  Future<bool> alterar(Colaborador pObjeto) {
    return transaction(() async {
      return update(colaboradors).replace(pObjeto);
    });
  }

  Future<int> excluir(Colaborador pObjeto) {
    return transaction(() async {
      return delete(colaboradors).delete(pObjeto);
    });
  }

  static List<String> campos = <String>[
    'codigo',
    'nome',
    'matricula',
    'data_admissao',
    'ativo',
  ];

  static List<String> colunas = <String>[
    'Código',
    'Nome',
    'Matricula',
    'Admissão',
    'ativo',
  ];
}
