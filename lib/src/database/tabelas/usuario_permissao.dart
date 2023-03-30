import 'package:drift/drift.dart';

import './../../database/app_db.dart';

class UsuarioPermissaos extends Table {
  @override
  String get tableName => 'tb_usuario_permissao';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  IntColumn get codigoUsuario => integer()
      .named('codigo_usuario')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_usuario(codigo)')();
  IntColumn get codigoPermissao => integer()
      .named('codigo_permissao')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_permissao(codigo)')();
}

class UsuarioPermissaoMontado {
  UsuarioPermissao? usuarioPermissao;
  Usuario? usuario;
  Permissao? permissao;

  UsuarioPermissaoMontado({
    this.usuarioPermissao,
    this.usuario,
    this.permissao,
  });
}
