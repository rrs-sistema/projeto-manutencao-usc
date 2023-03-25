import 'package:drift/drift.dart';

class Categorias extends Table {
  @override
  String get tableName => 'tb_categoria';

  IntColumn get codigo => integer().autoIncrement().named('codigo')();
  TextColumn get nome => text().named('nome')();
}
