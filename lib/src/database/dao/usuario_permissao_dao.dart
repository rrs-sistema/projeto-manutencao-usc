import 'package:drift/drift.dart';

import '../tabelas/usuario_permissao.dart';
import '../tabelas/permissao.dart';
import '../tabelas/usuario.dart';
import './../app_db.dart';

part 'usuario_permissao_dao.g.dart';

@DriftAccessor(tables: [Usuarios, Permissaos, UsuarioPermissaos])
class UsuarioPermissaoDao extends DatabaseAccessor<AppDb>
    with _$UsuarioPermissaoDaoMixin {
  final AppDb db;

  UsuarioPermissaoDao(this.db) : super(db);

  List<UsuarioPermissao>? listaPermissao;
  List<UsuarioPermissaoMontado>? listaPermissaoMontado;

  Future<List<UsuarioPermissao>?> consultarLista() async {
    listaPermissao = await select(usuarioPermissaos).get();
    return listaPermissao;
  }

  Future<List<UsuarioPermissaoMontado>?> consultarListaMontado(
      {String? campo, dynamic valor}) async {
    final consulta = select(usuarioPermissaos).join([
      leftOuterJoin(
          usuarios, usuarios.codigo.equalsExp(usuarioPermissaos.codigoUsuario)),
      leftOuterJoin(permissaos,
          permissaos.codigo.equalsExp(usuarioPermissaos.codigoPermissao)),
    ]);
    if (campo != null && campo != '' && valor != null) {
      final coluna = usuarioPermissaos.$columns
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
      final userPermissao = row.readTableOrNull(usuarioPermissaos);
      final user = row.readTableOrNull(usuarios);
      final permission = row.readTableOrNull(permissaos);

      return UsuarioPermissaoMontado(
          usuarioPermissao: userPermissao,
          usuario: user,
          permissao: permission);
    }).get();
    return listaPermissaoMontado;
  }

  Stream<List<UsuarioPermissao>> observarLista() =>
      select(usuarioPermissaos).watch();

  Future<UsuarioPermissao?> consultarObjeto(int pId) {
    return (select(usuarioPermissaos)..where((t) => t.codigo.equals(pId)))
        .getSingleOrNull();
  }

  Future<List<UsuarioPermissao>?> consultarListaFiltro(
      String campo, String valor) async {
    listaPermissao = await (customSelect(
        "SELECT * FROM tb_usuario_permissao WHERE $campo like '%$valor%'",
        readsFrom: {usuarioPermissaos}).map((row) {
      return UsuarioPermissao.fromData(row.data);
    }).get());
    return listaPermissao;
  }

  Future<int> inserir(UsuarioPermissao pObjeto) {
    return transaction(() async {
      return await into(usuarioPermissaos).insert(pObjeto);
    });
  }

  Future<bool> alterar(UsuarioPermissao pObjeto) {
    return transaction(() async {
      return update(usuarioPermissaos).replace(pObjeto);
    });
  }

  Future<int> excluir(UsuarioPermissao pObjeto) {
    return transaction(() async {
      return delete(usuarioPermissaos).delete(pObjeto);
    });
  }

  Future<void> excluirCodigo(int codigo) {
    return transaction(() async {
      (delete(usuarioPermissaos)..where((t) => t.codigo.equals(codigo))).go();
    });
  }

  static List<String> campos = <String>[
    'codigo',
    'codigo_usuario',
    'codigo_permissao',
  ];

  static List<String> colunas = <String>[
    'Código',
    'Código do usuário',
    'Código da permissão',
  ];
}
