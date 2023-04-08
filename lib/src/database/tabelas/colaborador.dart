import 'package:drift/drift.dart';
import './../../database/app_db.dart';

class Colaboradors extends Table {
  @override
  String get tableName => 'tb_colaborador';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get matricula =>
      text().nullable().withLength(min: 3, max: 20).named('matricula')();
  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 180).named('nome')();
  DateTimeColumn get dataAdmissao =>
      dateTime().nullable().named('data_admissao')();
  TextColumn get ativo =>
      text().nullable().withLength(min: 1, max: 1).named('ativo')();
}

class ColaboradorMontado {
  ColaboradorFuncao? colaboradorFuncao;
  Funcao? funcao;

  ColaboradorMontado({
    this.colaboradorFuncao,
    this.funcao,
  });
}
