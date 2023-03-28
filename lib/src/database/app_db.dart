import 'package:manutencao_usc/src/database/dao/local_sub_dao.dart';
import 'package:manutencao_usc/src/database/dao/usuario_dao.dart';
import 'package:manutencao_usc/src/database/tabelas/local_sub.dart';
import 'package:manutencao_usc/src/database/tabelas/usuario.dart';
import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'dart:io';

import './dao/status_ordem_servico_dao.dart';
import './tabelas/status_ordem_servico.dart';
import './tabelas/ordem_servico.dart';
import './tabelas/categoria.dart';
import './dao/categoria_dao.dart';
import './../infra/sessao.dart';
import './../infra/infra.dart';
import './dao/local_dao.dart';
import './tabelas/local.dart';
import './dao/dao.dart';

part 'app_db.g.dart';

LazyDatabase _opeConnection() {
  if (Biblioteca.isMobile()) {
    final executor = LazyDatabase(() async {
      final dataDir = await paths.getApplicationDocumentsDirectory();
      Sessao.caminhoBancoDados = p.join(dataDir.path, 'manutencao_usc.sqlite');
      final dbFile = File(Sessao.caminhoBancoDados);
      return NativeDatabase(dbFile, logStatements: true);
    });
    return executor;
  } else if (Platform.isWindows) {
    final executor = LazyDatabase(() async {
      final dataDir = await paths.getApplicationDocumentsDirectory();
      Sessao.caminhoBancoDados = p.join(dataDir.path, 'manutencao_usc.sqlite');
      final dbFile = File(Sessao.caminhoBancoDados);
      return NativeDatabase(dbFile, logStatements: true);
    });
    return executor;
  }
  return LazyDatabase(() async {
    return NativeDatabase.memory(logStatements: true);
  });
}

@DriftDatabase(tables: [
  OrdemServicos,
  Locals,
  LocalSubs,
  Categorias,
  StatusOrdemServicos,
  Usuarios
], daos: [
  OrdemServicoDao,
  LocalDao,
  LocalSubDao,
  CategoriaDao,
  StatusOrdemServicoDao,
  UsuarioDao
])
class AppDb extends _$AppDb {
  AppDb() : super(_opeConnection());

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        onCreate: (Migrator m) async {
          await m.createAll();
          await _popularBanco(this);
        },
        onUpgrade: (Migrator m, int from, int to) async {
          if (from == 1) {
            // await MigracaoParaSchema2(this).migrarParaSchema2(m, from, to);
          }
        },
      );

  Future<void> _popularBanco(AppDb db) async {
    var senha = Biblioteca.cifrar("53111");
    await db.customStatement(
        "INSERT INTO tb_usuario (codigo, matricula, nome, email, celular, senha) "
        "VALUES (1, '100001720212', 'Rivaldo Roberto', 'rivaldo.roberto@outlook.com', '41984221805', '$senha')");

    // DADOS INICIAIS DA TABELA DE LOCAIS
    await db.customStatement(
        "INSERT INTO tb_local (codigo, nome) VALUES (1, 'Salas')");
    await db.customStatement(
        "INSERT INTO tb_local (codigo, nome) VALUES (2, 'Banheiros')");
    await db.customStatement(
        "INSERT INTO tb_local (codigo, nome) VALUES (3, 'Administrativo')");

    // DADOS INICIAIS DA TABELA DE SUB-LOCAIS
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (1, '001')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (1, '002')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (2, 'Feminino 1º')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (2, 'Masculino 1º')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (2, 'Feminino 2º')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (2, 'Masculino 3º')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (2, 'Masculino 3º')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (3, 'Biblioteca')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (3, 'Sala dos professores')");
    // DADOS INICIAIS DA TABELA DE CATEGORIAS
    await db.customStatement(
        "INSERT INTO tb_categoria (codigo, nome) VALUES (1, 'Eletrica')");
    await db.customStatement(
        "INSERT INTO tb_categoria (codigo, nome) VALUES (2, 'Hidráulica')");

    // DADOS INICIAIS DA TABELA DE STATUS
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome) VALUES (1, 'Aberto')");
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome) VALUES (2, 'Em Andamento')");
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome) VALUES (3, 'Finalizado')");

    // DADOS INICIAIS DA TABELA DE ORDEM DE SERVIÇO
    /*
    await db.customStatement(
        "INSERT INTO tb_ordem_servico (codigo_usuario, codigo_local, codigo_categoria, "
        "codigo_status, descricao_problema, descricao_solucao, data_abertura, "
        "data_encerramento) "
        "VALUES (1, 1, 1, 1, '', NULL, 1679755680, NULL)");
        */
  }
}
