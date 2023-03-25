import 'package:manutencao_usc/src/database/dao/usuario_dao.dart';
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
  Categorias,
  StatusOrdemServicos,
  Usuarios
], daos: [
  OrdemServicoDao,
  LocalDao,
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
    // DADOS INICIAIS DA TABELA DE LOCAIS
    await db.customStatement(
        "INSERT INTO tb_local (codigo, nome) VALUES (1, 'Sala 307')");
    await db.customStatement(
        "INSERT INTO tb_local (codigo, nome) VALUES (2, 'Banheiro Feminino 2º Andar')");
    await db.customStatement("INSERT INTO tb_local (nome) VALUES ('Outros')");

    // DADOS INICIAIS DA TABELA DE CATEGORIAS
    await db.customStatement(
        "INSERT INTO tb_categoria (codigo, nome) VALUES (1, 'Eletrica')");
    await db.customStatement(
        "INSERT INTO tb_categoria (codigo, nome) VALUES (2, 'Hidráulica')");
    await db
        .customStatement("INSERT INTO tb_categoria (nome) VALUES ('Outros')");

    // DADOS INICIAIS DA TABELA DE STATUS
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome) VALUES (1, 'Aberto')");
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome) VALUES (2, 'Em Andamento')");
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome) VALUES (3, 'Finalizado')");
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome) VALUES (4, 'Rejeitado')");
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (nome) VALUES ('Outros')");

    // DADOS INICIAIS DA TABELA DE ORDEM DE SERVIÇO
    await db.customStatement(
        "INSERT INTO tb_ordem_servico (codigo_usuario, codigo_local, codigo_categoria, "
        "codigo_status, descricao_problema, descricao_solucao, data_abertura, "
        "data_encerramento) "
        "VALUES (1, 1, 1, 1, '', NULL, 1679755680, NULL)");
  }
}
