import 'package:drift/drift.dart';
import 'package:manutencao_usc/src/database/app_db.dart';

class LocalSubs extends Table {
  @override
  String get tableName => 'tb_local_sub';
  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  IntColumn get codigoLocal => integer()
      .named('codigo_local')
      .nullable()
      .customConstraint('NULLABLE REFERENCES tb_local(codigo)')();

  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 180).named('nome')();
  TextColumn get descricao =>
      text().nullable().withLength(max: 255).named('descricao')();
}

class LocalSubMontado {
  LocalSub? localSub;
  Local? local;

  LocalSubMontado({
    this.localSub,
    this.local,
  });
}
