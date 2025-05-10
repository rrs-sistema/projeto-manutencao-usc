import 'package:drift/drift.dart';

class Sexos extends Table {
  @override
  String get tableName => 'tb_sexo';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 50).named('nome')();
  TextColumn get deletado =>
      text().nullable().withLength(min: 1, max: 1).named('deletado')();
}
