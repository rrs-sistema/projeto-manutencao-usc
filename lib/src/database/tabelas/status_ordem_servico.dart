import 'package:drift/drift.dart';

class StatusOrdemServicos extends Table {
  @override
  String get tableName => 'tb_status_ordem_servico';

  IntColumn get codigo => integer().autoIncrement().named('codigo')();
  TextColumn get nome => text().named('nome')();
}
