import 'package:drift/drift.dart';
import 'package:manutencao_usc/src/database/app_db.dart';

class Usuarios extends Table {
  @override
  String get tableName => 'tb_usuario';

  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get matricula =>
      text().withLength(min: 3, max: 50).nullable().named('matricula')();
  TextColumn get senha =>
      text().nullable().withLength(min: 3, max: 254).named('senha')();
  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 180).named('nome')();
  TextColumn get email =>
      text().nullable().withLength(min: 3, max: 254).named('email')();
  TextColumn get celular =>
      text().nullable().withLength(min: 3, max: 15).named('celular')();
  TextColumn get deletado =>
      text().nullable().withLength(min: 1, max: 1).named('deletado')();
}

class UsuarioMontado {
  Usuario? usuario;
  List<UsuarioPermissao>? listaPermissao = [];

  UsuarioMontado({
    this.usuario,
    this.listaPermissao,
  });
}
