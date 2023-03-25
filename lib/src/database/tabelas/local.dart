import 'package:drift/drift.dart';

class Locals extends Table {
  @override
  String get tableName => 'tb_local';
  IntColumn get codigo => integer().autoIncrement().named('codigo')();
  TextColumn get nome => text().named('nome')();
}
