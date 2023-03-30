import 'package:drift/drift.dart';

class Permissaos extends Table {
  @override
  String get tableName => 'tb_permissao';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 50).named('nome')();
  TextColumn get descricao =>
      text().nullable().withLength(max: 255).named('descricao')();
}
