import 'package:drift/drift.dart';

import './../../database/app_db.dart';

class ColaboradorFuncaos extends Table {
  @override
  String get tableName => 'tb_colaborador_funcao';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  IntColumn get codigoColaborador => integer()
      .named('codigo_colaborador')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_colaborador(codigo)')();
  IntColumn get codigoFuncao => integer()
      .named('codigo_funcao')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_funcao(codigo)')();
  IntColumn get percentual => integer().nullable().named('percentual')();
}

class ColaboradorFuncaoMontado {
  ColaboradorFuncao? colaboradorFuncao;
  Colaborador? colaborador;
  Funcao? funcao;

  ColaboradorFuncaoMontado({
    this.colaboradorFuncao,
    this.colaborador,
    this.funcao,
  });
}
