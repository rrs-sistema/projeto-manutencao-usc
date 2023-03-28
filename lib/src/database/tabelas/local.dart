import 'package:drift/drift.dart';

class Locals extends Table {
  @override
  String get tableName => 'tb_local';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get nome => text().nullable().named('nome')();
}
