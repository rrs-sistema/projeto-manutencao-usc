import 'package:drift/drift.dart';

import '../tabelas/colaborador_funcao.dart';
import '../tabelas/colaborador.dart';
import '../tabelas/funcao.dart';
import './../app_db.dart';

part 'colaborador_funcao_dao.g.dart';

@DriftAccessor(tables: [Colaboradors, Funcaos, ColaboradorFuncaos])
class ColaboradorFuncaoDao extends DatabaseAccessor<AppDb>
    with _$ColaboradorFuncaoDaoMixin {
  final AppDb db;

  ColaboradorFuncaoDao(this.db) : super(db);

  List<ColaboradorFuncao>? listaPermissao;
  List<ColaboradorFuncaoMontado>? listaPermissaoMontado;

  Future<List<ColaboradorFuncao>?> consultarLista() async {
    listaPermissao = await select(colaboradorFuncaos).get();
    return listaPermissao;
  }

  Future<List<ColaboradorFuncaoMontado>?> consultarListaMontado(
      {String? campo, dynamic valor}) async {
    final consulta = select(colaboradorFuncaos).join([
      leftOuterJoin(colaboradors,
          colaboradors.codigo.equalsExp(colaboradorFuncaos.codigoColaborador)),
      leftOuterJoin(
          funcaos, funcaos.codigo.equalsExp(colaboradorFuncaos.codigoFuncao)),
    ]);
    if (campo != null && campo != '' && valor != null) {
      final coluna = colaboradorFuncaos.$columns
          .where(((coluna) => coluna.$name == campo))
          .first;
      if (coluna is TextColumn) {
        consulta.where((coluna as TextColumn).like('%$valor%'));
      } else if (coluna is IntColumn) {
        consulta.where(coluna.equals(int.tryParse(valor)));
      } else if (coluna is RealColumn) {
        consulta.where(coluna.equals(double.tryParse(valor)));
      }
    }
    listaPermissaoMontado = await consulta.map((row) {
      final colabFuncao = row.readTableOrNull(colaboradorFuncaos);
      final colab = row.readTableOrNull(colaboradors);
      final function = row.readTableOrNull(funcaos);

      return ColaboradorFuncaoMontado(
          colaboradorFuncao: colabFuncao, colaborador: colab, funcao: function);
    }).get();
    return listaPermissaoMontado;
  }

  Stream<List<ColaboradorFuncao>> observarLista() =>
      select(colaboradorFuncaos).watch();

  Future<ColaboradorFuncao?> consultarObjeto(int pId) {
    return (select(colaboradorFuncaos)..where((t) => t.codigo.equals(pId)))
        .getSingleOrNull();
  }

  Future<List<ColaboradorFuncao>?> consultarListaFiltro(
      String campo, String valor) async {
    listaPermissao = await (customSelect(
        "SELECT * FROM tb_colaborador_funcao WHERE $campo like '%$valor%'",
        readsFrom: {colaboradorFuncaos}).map((row) {
      return ColaboradorFuncao.fromData(row.data);
    }).get());
    return listaPermissao;
  }

  Future<int> inserir(ColaboradorFuncao pObjeto) {
    return transaction(() async {
      return await into(colaboradorFuncaos).insert(pObjeto);
    });
  }

  Future<bool> alterar(ColaboradorFuncao pObjeto) {
    return transaction(() async {
      return update(colaboradorFuncaos).replace(pObjeto);
    });
  }

  Future<int> excluir(ColaboradorFuncao pObjeto) {
    return transaction(() async {
      return delete(colaboradorFuncaos).delete(pObjeto);
    });
  }

  Future<void> excluirCodigo(int codigo) {
    return transaction(() async {
      (delete(colaboradorFuncaos)..where((t) => t.codigo.equals(codigo))).go();
    });
  }

  static List<String> campos = <String>[
    'codigo',
    'codigo_colaborador',
    'codigo_funcao',
    'percentual',
  ];

  static List<String> colunas = <String>[
    'Código',
    'Código do colaborador',
    'Código da função',
    'Percentual',
  ];
}
