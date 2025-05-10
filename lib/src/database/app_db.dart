import 'package:path_provider/path_provider.dart' as paths;
import 'package:path/path.dart' as p;
import 'package:drift/native.dart';
import 'package:drift/drift.dart';
import 'dart:io';

import './dao/status_ordem_servico_dao.dart';
import './tabelas/status_ordem_servico.dart';
import './dao/colaborador_funcao_dao.dart';
import './tabelas/colaborador_funcao.dart';
import './dao/usuario_permissao_dao.dart';
import './tabelas/usuario_permissao.dart';
import './tabelas/ordem_servico.dart';
import './dao/estado_civil_dao.dart';
import './tabelas/estado_civil.dart';
import './tabelas/colaborador.dart';
import './dao/colaborador_dao.dart';
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
import './dao/funcao_dao.dart';
import './tabelas/funcao.dart';
import './dao/local_dao.dart';
import './tabelas/local.dart';
import './dao/sexo_dao.dart';
import './tabelas/sexo.dart';
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
  Sexos,
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
  SexoDao,
  EstadoCivilDao,
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
        "INSERT INTO tb_local (codigo, nome, deletado) VALUES (1, 'Salas', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local (codigo, nome, deletado) VALUES (2, 'Banheiros', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local (codigo, nome, deletado) VALUES (3, 'Administrativo', 'N')");

    // DADOS INICIAIS DA TABELA DE SEXO
    await db.customStatement(
        "INSERT INTO tb_sexo (codigo, nome, deletado) VALUES (1, 'Masculino', 'N')");
    await db.customStatement(
        "INSERT INTO tb_sexo (codigo, nome, deletado) VALUES (2, 'Feminino', 'N')");

    // DADOS INICIAIS DA TABELA DE SUB-LOCAIS
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (1, '001', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (1, '002', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (2, 'Feminino 1º', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (2, 'Masculino 1º', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (2, 'Feminino 2º', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (2, 'Masculino 3º', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (2, 'Masculino 3º', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (3, 'Biblioteca', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (3, 'Sala dos professores', 'N')");
    await db.customStatement(
        "INSERT INTO tb_local_sub (codigo_local, nome, deletado) VALUES (3, 'Cozinha', 'N')");

    // DADOS INICIAIS DA TABELA DE ESTADO CIVIL
    await db.customStatement(
        "INSERT INTO tb_estado_civil (codigo, nome, deletado) VALUES (1, 'Solteiro', 'N')");
    await db.customStatement(
        "INSERT INTO tb_estado_civil (codigo, nome, deletado) VALUES (2, 'Casado', 'N')");
    await db.customStatement(
        "INSERT INTO tb_estado_civil (codigo, nome, deletado) VALUES (3, 'Separado', 'N')");
    await db.customStatement(
        "INSERT INTO tb_estado_civil (codigo, nome, deletado) VALUES (4, 'Divorciado', 'N')");
    await db.customStatement(
        "INSERT INTO tb_estado_civil (codigo, nome, deletado) VALUES (5, 'Viúvo', 'N')");

    // DADOS INICIAIS DA TABELA DE CATEGORIAS
    await db.customStatement(
        "INSERT INTO tb_categoria (codigo, nome, deletado) VALUES (1, 'Eletrica', 'N')");
    await db.customStatement(
        "INSERT INTO tb_categoria (codigo, nome, deletado) VALUES (2, 'Hidráulica', 'N')");

    // DADOS INICIAIS DA TABELA DE FUNÇÃO
    await db.customStatement(
        "INSERT INTO tb_funcao (codigo, nome, deletado) VALUES (1, 'Diretor', 'N')");
    await db.customStatement(
        "INSERT INTO tb_funcao (codigo, nome, deletado) VALUES (2, 'Professor', 'N')");
    await db.customStatement(
        "INSERT INTO tb_funcao (codigo, nome, deletado) VALUES (3, 'Encanador', 'N')");
    await db.customStatement(
        "INSERT INTO tb_funcao (codigo, nome, deletado) VALUES (4, 'Eletricista', 'N')");

    // DADOS INICIAIS DA TABELA DE STATUS
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome, deletado) VALUES (1, 'Aberto', 'N')");
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome, deletado) VALUES (2, 'Em Andamento', 'N')");
    await db.customStatement(
        "INSERT INTO tb_status_ordem_servico (codigo, nome, deletado) VALUES (3, 'Finalizado', 'N')");

    // DADOS INICIAIS DA TABELA DE PERMISSÃO
    await db.customStatement(
        "INSERT INTO tb_permissao (codigo, nome, descricao, deletado) VALUES (1, 'ROLE_SUPORTE_APP', 'Desenvolvedor do APP - acessos liberados a tudo', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (codigo, nome, descricao, deletado) VALUES (2, 'ROLE_ADMINISTRADOR', 'Admistrador - acessos a todas funcionalidades do sistema', 'N')");
    //Dados da tabela de PERMISSAO PARA: categoria
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_CADASTRAR_CATEGORIA', 'Permissão para cadastrar as categorias', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_ALTERAR_CATEGORIA', 'Permissão para alterar as categorias', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_DELETAR_CATEGORIA', 'Permissão para deletar as categorias', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_PESQUISAR_CATEGORIA', 'Permissão para pesquisar as categorias', 'N')");

    //Dados da tabela de PERMISSAO PARA: area/local/sublocal
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_CADASTRAR_LOCAL', 'Permissão para cadastrar áreas, local, sublocal', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_ALTERAR_LOCAL', 'Permissão para alterar áreas, local, sublocal', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_DELETAR_LOCAL', 'Permissão para deletar áreas, local, sublocal', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_PESQUISAR_LOCAL', 'Permissão para pesquisar áreas, local, sublocal', 'N')");

    //Dados da tabela de PERMISSAO PARA: status da ordem de serviço
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_CADASTRAR_STATUS_ORDEM_SERVICO', 'Permissão para cadastrar os status da ordem de serviço', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_ALTERAR_STATUS_ORDEM_SERVICO', 'Permissão para alterar os status da ordem de serviço', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_DELETAR_STATUS_ORDEM_SERVICO', 'Permissão para deletar os status da ordem de serviço', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_PESQUISAR_STATUS_ORDEM_SERVICO', 'Permissão para pesquisar os status da ordem de serviço', 'N')");

    //Dados da tabela de PERMISSAO PARA: ordem de serviço
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_CADASTRAR_ORDEM_SERVICO', 'Permissão para cadastrar as ordem de serviços', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_ALTERAR_ORDEM_SERVICO', 'Permissão para alterar as ordem de serviços', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_DELETAR_ORDEM_SERVICO', 'Permissão para deletar as ordem de serviços', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_PESQUISAR_SUA_ORDEM_SERVICO', 'Permissão para pesquisar apenas suas ordem de serviços', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_PESQUISAR_TODAS_ORDEM_SERVICO', 'Permissão para pesquisar todas as ordem de serviços', 'N')");

    //Dados da tabela de PERMISSAO PARA: usuário
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_CADASTRAR_USUARIO', 'Permissão para cadastrar os usuários', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_ALTERAR_USUARIO', 'Permissão para alterar os usuários', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_DELETAR_USUARIO', 'Permissão para deletar os usuários', 'N')");
    await db.customStatement(
        "INSERT INTO tb_permissao (nome, descricao, deletado) VALUES ('ROLE_PESQUISAR_USUARIO', 'Permissão para pesquisar os usuários', 'N')");

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
