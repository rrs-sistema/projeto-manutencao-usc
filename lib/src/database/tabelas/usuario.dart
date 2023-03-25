import 'package:drift/drift.dart';

class Usuarios extends Table {
  @override
  String get tableName => 'tb_usuario';

  IntColumn get codigo => integer().autoIncrement().named('codigo')();
  TextColumn get matricula => text().named('matricula')();
  TextColumn get senha => text().named('senha')();
  TextColumn get nome => text().named('nome')();
  TextColumn get email => text().named('email')();
  TextColumn get celular => text().named('celular')();
}
