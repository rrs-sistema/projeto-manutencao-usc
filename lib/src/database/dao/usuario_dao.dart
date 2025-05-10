import 'dart:developer';

import 'package:drift/drift.dart';
import 'package:manutencao_usc/src/infra/biblioteca.dart';

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
    listaUsuario = await select(usuarios).get()
      ..where((c) => c.deletado == 'N');
    return listaUsuario;
  }

  Future<Usuario?> consultarObjeto(int pId) {
    return (select(usuarios)..where((t) => t.codigo.equals(pId)))
        .getSingleOrNull();
  }

  Future<List<Usuario>?> consultarListaFiltro(
      String campo, String valor) async {
    listaUsuario = await (customSelect(
        "SELECT * FROM tb_usuario WHERE $campo like '%$valor%' AND deletado = 'N'",
        readsFrom: {usuarios}).map((row) {
      return Usuario.fromData(row.data);
    }).get());
    return listaUsuario;
  }

  Future<Usuario?> logar(String matricula, String senha) async {
    var senhaCifrada = Biblioteca.cifrar(senha);
    log('Senha cifrada--> $senhaCifrada');
    return (customSelect(
        "SELECT * FROM tb_usuario WHERE matricula = '$matricula' and senha = '$senhaCifrada' and deletado = 'N'",
        readsFrom: {usuarios}).map((row) {
      return Usuario.fromData(row.data);
    }).getSingleOrNull());
  }

  Future<Usuario?> consultarObjetoFiltro(String campo, String valor) async {
    return (customSelect(
        "SELECT * FROM tb_usuario WHERE $campo = '$valor' and deletado='N' ",
        readsFrom: {usuarios}).map((row) {
      return Usuario.fromData(row.data);
    }).getSingleOrNull());
  }

  Future<int> ultimoId() async {
    final resultado = await customSelect(
            "select MAX(codigo) as ULTIMO from tb_usuario WHERE deletado = 'N'")
        .getSingleOrNull();
    return resultado?.data["ULTIMO"] ?? 0;
  }

  Future<int> inserir(
      Usuario usuario, List<UsuarioPermissaoMontado> listaUsuarioPermissao) {
    return transaction(() async {
      usuario = usuario.copyWith(
          deletado: 'N',
          senha: Biblioteca.cifrar(usuario.senha!),
          celular: usuario.celular?.replaceAll(' ', '').replaceAll('-', ''));
      final idInserido = await into(usuarios).insert(usuario);
      usuario = usuario.copyWith(codigo: idInserido);
      await inserirFilhos('I', usuario, listaUsuarioPermissao);
      return idInserido;
    });
  }

  Future<bool> alterar(
      Usuario usuario, List<UsuarioPermissaoMontado> listaUsuarioPermissao) {
    return transaction(() async {
      var user = await consultarObjeto(usuario.codigo!);
      usuario = usuario.copyWith(senha: user!.senha!);
      await inserirFilhos('A', usuario, listaUsuarioPermissao);
      return update(usuarios).replace(usuario);
    });
  }

  Future<bool> excluir(Usuario pObjeto) {
    return transaction(() async {
      pObjeto = pObjeto.copyWith(deletado: 'S');
      return update(usuarios).replace(pObjeto);
    });
  }

  Future<void> inserirFilhos(String operacao, Usuario pObjeto,
      List<UsuarioPermissaoMontado> listaUsuarioPermissao) async {
    for (var permissaoMontada in listaUsuarioPermissao) {
      UsuarioPermissao usuarioPermissao = UsuarioPermissao(
          codigoPermissao: permissaoMontada.permissao!.codigo,
          codigoUsuario: pObjeto.codigo);
      if (operacao == 'A' && permissaoMontada.usuarioPermissao != null) {
        usuarioPermissao = usuarioPermissao.copyWith(
            codigo: permissaoMontada.usuarioPermissao!.codigo);
        await excluirFilhos(usuarioPermissao);
      }
      usuarioPermissao =
          usuarioPermissao.copyWith(codigoUsuario: pObjeto.codigo);
      await db.usuarioPermissaoDao.inserir(usuarioPermissao);
    }
  }

  Future<void> excluirFilhos(UsuarioPermissao? usuarioPermissao) async {
    await db.usuarioPermissaoDao.excluirCodigo(usuarioPermissao!.codigo!);
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
