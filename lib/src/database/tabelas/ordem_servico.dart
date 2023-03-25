import 'package:drift/drift.dart';

import './../app_db.dart';

class OrdemServicos extends Table {
  @override
  String get tableName => 'tb_ordem_servico';

  IntColumn get codigo => integer().autoIncrement().named('codigo')();
  TextColumn get codigoUsuario => text().named('codigo_usuario')();
  IntColumn get codigoCategoria => integer()
      .named('codigo_categoria')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_categoria(codigo)')();
  IntColumn get codigoLocal => integer()
      .named('codigo_local')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_local(codigo)')();
  IntColumn get codigoStatus =>
      integer().named('codigo_status').nullable().customConstraint(
          'NULLABLE REFERENCES tb_status_ordem_servico(codigo)')();

  TextColumn get descricaoProblema =>
      text().nullable().named('descricao_problema')();
  TextColumn get descricaoSolucao =>
      text().nullable().named('descricao_solucao')();
  DateTimeColumn get dataAbertura =>
      dateTime().nullable().named('data_abertura')();
  DateTimeColumn get dataEncerramento =>
      dateTime().nullable().named('data_encerramento')();
}

class OrdemServicoMontada {
  OrdemServico? ordemServico;
  Categoria? categoria;
  Local? local;
  StatusOrdemServico? statusOrdemServico;

  OrdemServicoMontada({
    this.ordemServico,
    this.categoria,
    this.local,
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


