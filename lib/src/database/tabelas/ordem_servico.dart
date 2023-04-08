import 'package:drift/drift.dart';

import './../app_db.dart';

class OrdemServicos extends Table {
  @override
  String get tableName => 'tb_ordem_servico';

  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  IntColumn get codigoUsuario => integer()
      .named('codigo_usuario')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_usuario(codigo)')();

  IntColumn get codigoColaborador => integer()
      .named('codigo_colaborador')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_colaborador(codigo)')();

  IntColumn get codigoCategoria => integer()
      .named('codigo_categoria')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_categoria(codigo)')();
  IntColumn get codigoLocal => integer()
      .named('codigo_local')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_local(codigo)')();

  IntColumn get codigoSubLocal => integer()
      .named('codigo_sub_local')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_local_sub(codigo)')();

  IntColumn get codigoStatus =>
      integer().named('codigo_status').nullable().customConstraint(
          'NULLABLE REFERENCES tb_status_ordem_servico(codigo)')();

  TextColumn get descricaoProblema =>
      text().nullable().withLength(max: 500).named('descricao_problema')();
  TextColumn get descricaoSolucao =>
      text().nullable().withLength(max: 650).named('descricao_solucao')();
  DateTimeColumn get dataAbertura =>
      dateTime().nullable().named('data_abertura')();
  DateTimeColumn get dataEncerramento =>
      dateTime().nullable().named('data_encerramento')();
  TextColumn get deletado =>
      text().nullable().withLength(min: 1, max: 1).named('deletado')();
}

class OrdemServicoMontada {
  OrdemServico? ordemServico;
  Usuario? usuario;
  Categoria? categoria;
  Local? local;
  LocalSub? localSub;
  StatusOrdemServico? statusOrdemServico;

  OrdemServicoMontada({
    this.ordemServico,
    this.usuario,
    this.categoria,
    this.local,
    this.localSub,
    this.statusOrdemServico,
  });
}

  /*

  String? descricaoProblema;
  String? descricaoSolucao;
  DateTime? dataAbertura;
  DateTime? dataEncerramento;

  Categoria? categoria;
  Local? cocal;
  Status? status;
  */


