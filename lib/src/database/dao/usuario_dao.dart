import 'package:drift/drift.dart';

import './../tabelas/usuario_permissao.dart';
import './../tabelas/usuario.dart';
import './../app_db.dart';

part 'usuario_dao.g.dart';

@DriftAccessor(tables: [Usuarios, UsuarioPermissaos])
class UsuarioDao extends DatabaseAccessor<AppDb> with _$UsuarioDaoMixin {
  final AppDb db;

  UsuarioDao(this.db) : super(db);
  List<Usuario>? listaUsuario;
  List<UsuarioMontado>? listaUsuarioMontado;

  //Future<List<Usuario>?> consultarLista() => select(usuarios).get();
  Future<List<Usuario>?> consultarLista() async {
    listaUsuario = await select(usuarios).get();
    return listaUsuario;
  }

  Future<List<Usuario>?> consultarListaFiltro(
      String campo, String valor) async {
    listaUsuario = await (customSelect(
        "SELECT * FROM tb_usuario WHERE $campo like '%$valor%'",
        readsFrom: {usuarios}).map((row) {
      return Usuario.fromData(row.data);
    }).get());
    return listaUsuario;
  }

  Future<Usuario?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect(
        "SELECT * FROM tb_usuario WHERE $campo = '$valor' and deletado='N' ORDER BY nome",
        readsFrom: {usuarios}).map((row) {
      return Usuario.fromData(row.data);
    }).getSingleOrNull());
  }

  Future<int> ultimoId() async {
    final resultado =
        await customSelect("select MAX(codigo) as ULTIMO from tb_usuario")
            .getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  }

  Future<int> inserir(
      Usuario usuario, List<UsuarioPermissaoMontado> listaUsuarioPermissao) {
    return transaction(() async {
      await inserirFilhos(usuario, listaUsuarioPermissao);
      return await into(usuarios).insert(usuario);
    });
  }

  Future<bool> alterar(
      Usuario usuario, List<UsuarioPermissaoMontado> listaUsuarioPermissao) {
    return transaction(() async {
      await inserirFilhos(usuario, listaUsuarioPermissao);
      return update(usuarios).replace(usuario);
    });
  }

  Future<int> excluir(Usuario usuario) {
    usuario = usuario.copyWith(deletado: 'S');
    return transaction(() async {
      return delete(usuarios).delete(usuario);
    });
  }

  Future<void> inserirFilhos(Usuario pObjeto,
      List<UsuarioPermissaoMontado> listaUsuarioPermissao) async {
    for (var objeto in listaUsuarioPermissao) {
      //await into(usuarioPermissaos).insert(objeto);
    }
  }

  static List<String> campos = <String>[
    'codigo',
    'matricula',
    'nome',
    'email',
  ];

  static List<String> colunas = <String>[
    'Código',
    'Matricula',
    'nome',
    'email',
  ];
}
