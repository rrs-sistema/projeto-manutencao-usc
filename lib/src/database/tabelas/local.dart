import 'package:drift/drift.dart';

class Locals extends Table {
  @override
  String get tableName => 'tb_local';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 180).named('nome')();
  TextColumn get deletado =>
      text().nullable().withLength(min: 1, max: 1).named('deletado')();
}
