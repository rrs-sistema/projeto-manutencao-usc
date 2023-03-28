import 'package:drift/drift.dart';

class Usuarios extends Table {
  @override
  String get tableName => 'tb_usuario';

  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get matricula => text().nullable().named('matricula')();
  TextColumn get senha => text().nullable().named('senha')();
  TextColumn get nome => text().nullable().named('nome')();
  TextColumn get email => text().nullable().named('email')();
  TextColumn get celular => text().nullable().named('celular')();
}
