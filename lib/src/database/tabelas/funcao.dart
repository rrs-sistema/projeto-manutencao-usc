import 'package:drift/drift.dart';

class Funcaos extends Table {
  @override
  String get tableName => 'tb_funcao';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 180).named('nome')();
}
