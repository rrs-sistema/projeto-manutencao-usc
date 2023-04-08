import 'package:drift/drift.dart';
import './../../database/app_db.dart';

class Colaboradors extends Table {
  @override
  String get tableName => 'tb_colaborador';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  IntColumn get codigoEstadoCivil => integer()
      .named('codigo_estado_civil')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_estado_civil(codigo)')();
  TextColumn get matricula =>
      text().nullable().withLength(max: 20).named('matricula')();
  TextColumn get nome =>
      text().nullable().withLength(min: 5, max: 180).named('nome')();
  TextColumn get sexo =>
      text().nullable().withLength(min: 1, max: 1).named('sexo')();
  TextColumn get email =>
      text().nullable().withLength(max: 254).named('email')();
  TextColumn get celular =>
      text().nullable().withLength(max: 15).named('celular')();
  TextColumn get telefone =>
      text().nullable().withLength(max: 15).named('telefone')();
  DateTimeColumn get dataAdmissao =>
      dateTime().nullable().named('data_admissao')();
  DateTimeColumn get dataDemissao =>
      dateTime().nullable().named('data_demissao')();
  TextColumn get deletado =>
      text().nullable().withLength(min: 1, max: 1).named('deletado')();
}

class ColaboradorMontado {
  ColaboradorFuncao? colaboradorFuncao;
  Funcao? funcao;

  ColaboradorMontado({
    this.colaboradorFuncao,
    this.funcao,
  });
}
