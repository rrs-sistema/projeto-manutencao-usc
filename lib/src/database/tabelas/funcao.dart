import 'package:drift/drift.dart';

class Funcaos extends Table {
  @override
  String get tableName => 'tb_funcao';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 180).named('nome')();
  TextColumn get cbo => text().nullable().withLength(max: 15).named('cbo')();
  TextColumn get descricao =>
      text().nullable().withLength(max: 450).named('descricao')();
  TextColumn get deletado =>
      text().nullable().withLength(min: 1, max: 1).named('deletado')();
}
