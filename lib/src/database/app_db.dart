import 'package:manutencao_usc/src/database/dao/colaborador_dao.dart';
import 'package:manutencao_usc/src/database/dao/colaborador_funcao_dao.dart';
import 'package:manutencao_usc/src/database/dao/funcao_dao.dart';
import 'package:manutencao_usc/src/database/tabelas/colaborador.dart';
import 'package:manutencao_usc/src/database/tabelas/colaborador_funcao.dart';
import 'package:manutencao_usc/src/database/tabelas/estado_civil.dart';
import 'package:manutencao_usc/src/database/tabelas/funcao.dart';
import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'dart:io';

import './dao/status_ordem_servico_dao.dart';
import './tabelas/status_ordem_servico.dart';
import './dao/usuario_permissao_dao.dart';
import './tabelas/usuario_permissao.dart';
import './tabelas/ordem_servico.dart';
import './tabelas/permissao.dart';
import './dao/permissao_dao.dart';
import './tabelas/local_sub.dart';
import './tabelas/categoria.dart';
import './dao/categoria_dao.dart';
import './dao/local_sub_dao.dart';
import './../infra/sessao.dart';
import './tabelas/usuario.dart';
import './dao/usuario_dao.dart';
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
  Usuarios,
  Permissaos,
  UsuarioPermissaos,
  EstadoCivils,
  Colaboradors,
  Funcaos,
  ColaboradorFuncaos,
], daos: [
  OrdemServicoDao,
  LocalDao,
  LocalSubDao,
  CategoriaDao,
  StatusOrdemServicoDao,
  UsuarioDao,
  PermissaoDao,
  UsuarioPermissaoDao,
  FuncaoDao,
  ColaboradorDao,
  ColaboradorFuncaoDao
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
    var senha = Biblioteca.cifrar("153111");
    await db.customStatement(
        "INSERT INTO tb_usuario (codigo, matricula, nome, email, celular, senha, deletado) "
        "VALUES (1, '100001720212', 'Rivaldo Roberto', 'rivaldo.roberto@outlook.com', '41984221805', '$senha', 'N')");

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
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome) VALUES (3, 'Cozinha')");

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

    // DADOS INICIAIS DA TABELA DE PERMISSÃO
    await db.customStatement(
        "INSERT INTO tb_permissao (codigo, nome, descricao) VALUES (1, 'ROLE_SUPORTE_APP', 'Desenvolvedor do APP - acessos liberados a tudo')");
    await db.customStatement(
        "INSERT INTO tb_permissao (codigo, nome, descricao) VALUES (2, 'ROLE_ADMINISTRADOR', 'Admistrador - acessos a todas funcionalidades do sistema')");
    //Dados da tabela de PERMISSAO PARA: categoria
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_CADASTRAR_CATEGORIA', 'Permissão para cadastrar as categorias')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_ALTERAR_CATEGORIA', 'Permissão para alterar as categorias')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_DELETAR_CATEGORIA', 'Permissão para deletar as categorias')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_PESQUISAR_CATEGORIA', 'Permissão para pesquisar as categorias')");

    //Dados da tabela de PERMISSAO PARA: area/local/sublocal
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_CADASTRAR_LOCAL', 'Permissão para cadastrar áreas, local, sublocal')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_ALTERAR_LOCAL', 'Permissão para alterar áreas, local, sublocal')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_DELETAR_LOCAL', 'Permissão para deletar áreas, local, sublocal')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_PESQUISAR_LOCAL', 'Permissão para pesquisar áreas, local, sublocal')");

    //Dados da tabela de PERMISSAO PARA: status da ordem de serviço
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_CADASTRAR_STATUS_ORDEM_SERVICO', 'Permissão para cadastrar os status da ordem de serviço')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_ALTERAR_STATUS_ORDEM_SERVICO', 'Permissão para alterar os status da ordem de serviço')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_DELETAR_STATUS_ORDEM_SERVICO', 'Permissão para deletar os status da ordem de serviço')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_PESQUISAR_STATUS_ORDEM_SERVICO', 'Permissão para pesquisar os status da ordem de serviço')");

    //Dados da tabela de PERMISSAO PARA: ordem de serviço
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_CADASTRAR_ORDEM_SERVICO', 'Permissão para cadastrar as ordem de serviços')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_ALTERAR_ORDEM_SERVICO', 'Permissão para alterar as ordem de serviços')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_DELETAR_ORDEM_SERVICO', 'Permissão para deletar as ordem de serviços')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_PESQUISAR_SUA_ORDEM_SERVICO', 'Permissão para pesquisar apenas suas ordem de serviços')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_PESQUISAR_TODAS_ORDEM_SERVICO', 'Permissão para pesquisar todas as ordem de serviços')");

    //Dados da tabela de PERMISSAO PARA: usuário
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_CADASTRAR_USUARIO', 'Permissão para cadastrar os usuários')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_ALTERAR_USUARIO', 'Permissão para alterar os usuários')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_DELETAR_USUARIO', 'Permissão para deletar os usuários')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao) VALUES ('ROLE_PESQUISAR_USUARIO', 'Permissão para pesquisar os usuários')");

    // DADOS INICIAIS DA TABELA DE USUARIO_PERMISSAO
    await db.customStatement(
        "INSERT INTO tb_usuario_permissao (codigo_usuario, codigo_permissao) VALUES (1, 1)");

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
