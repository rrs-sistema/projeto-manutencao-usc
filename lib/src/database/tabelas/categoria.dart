import 'package:drift/drift.dart';

class Categorias extends Table {
  @override
  String get tableName => 'tb_categoria';

  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 180).named('nome')();
}
