import 'package:drift/drift.dart';

class StatusOrdemServicos extends Table {
  @override
  String get tableName => 'tb_status_ordem_servico';

  IntColumn get codigo =>
      integer().autoIncrement().nullable().named('codigo')();
  TextColumn get nome =>
      text().nullable().withLength(min: 3, max: 120).named('nome')();
}
