import 'package:drift/drift.dart';

import '../tabelas/estado_civil.dart';
import '../tabelas/colaborador.dart';
import '../tabelas/sexo.dart';
import './../app_db.dart';

part 'colaborador_dao.g.dart';

@DriftAccessor(tables: [Colaboradors, EstadoCivils, Sexos])
class ColaboradorDao extends DatabaseAccessor<AppDb>
    with _$ColaboradorDaoMixin {
  final AppDb db;

  ColaboradorDao(this.db) : super(db);

  List<Colaborador>? listaColaborador;
  List<ColaboradorMontado>? listaColaboradorMontado;

  Future<List<Colaborador>?> consultarLista() async {
    listaColaborador = await select(colaboradors).get()
      ..where((c) => c.deletado == 'N');
    return listaColaborador;
  }

  Future<List<Colaborador>?> consultarListaFiltro(
      String campo, String valor) async {
    listaColaborador = await (customSelect(
        "SELECT * FROM tb_colaborador WHERE $campo like '%$valor%' AND deletado = 'N'",
        readsFrom: {colaboradors}).map((row) {
      return Colaborador.fromData(row.data);
    }).get());
    return listaColaborador;
  }

  Future<List<ColaboradorMontado>?> consultarListaMontado(
      {String? campo, dynamic valor}) async {
    final consulta = select(colaboradors).join([
      leftOuterJoin(estadoCivils,
          estadoCivils.codigo.equalsExp(colaboradors.codigoEstadoCivil)),
      leftOuterJoin(sexos, sexos.codigo.equalsExp(colaboradors.codigoSexo)),
    ]);
    if (campo != null && campo != '') {
      final coluna = colaboradors.$columns
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
    listaColaboradorMontado = await consulta.map((row) {
      final colab = row.readTableOrNull(colaboradors);
      final estadoCivil = row.readTableOrNull(estadoCivils);
      final sexo = row.readTableOrNull(sexos);
      return ColaboradorMontado(
          colaborador: colab, sexo: sexo, estadoCivil: estadoCivil);
    }).get();
    return listaColaboradorMontado;
  }

  Future<int> inserir(Colaborador pObjeto) {
    return transaction(() async {
      pObjeto = pObjeto.copyWith(deletado: 'N');
      return await into(colaboradors).insert(pObjeto);
    });
  }

  Future<bool> alterar(Colaborador pObjeto) {
    return transaction(() async {
      return update(colaboradors).replace(pObjeto);
    });
  }

  Future<bool> excluir(Colaborador pObjeto) {
    return transaction(() async {
      pObjeto = pObjeto.copyWith(deletado: 'S');
      return update(colaboradors).replace(pObjeto);
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
