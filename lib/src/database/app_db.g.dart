// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class OrdemServico extends DataClass implements Insertable<OrdemServico> {
  final int? codigo;
  final int? codigoUsuario;
  final int? codigoColaborador;
  final int? codigoCategoria;
  final int? codigoLocal;
  final int? codigoSubLocal;
  final int? codigoStatus;
  final String? descricaoProblema;
  final String? descricaoSolucao;
  final DateTime? dataAbertura;
  final DateTime? dataEncerramento;
  final String? deletado;
  OrdemServico(
      {this.codigo,
      this.codigoUsuario,
      this.codigoColaborador,
      this.codigoCategoria,
      this.codigoLocal,
      this.codigoSubLocal,
      this.codigoStatus,
      this.descricaoProblema,
      this.descricaoSolucao,
      this.dataAbertura,
      this.dataEncerramento,
      this.deletado});
  factory OrdemServico.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return OrdemServico(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      codigoUsuario: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_usuario']),
      codigoColaborador: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}codigo_colaborador']),
      codigoCategoria: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_categoria']),
      codigoLocal: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_local']),
      codigoSubLocal: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_sub_local']),
      codigoStatus: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_status']),
      descricaoProblema: const StringType().mapFromDatabaseResponse(
          data['${effectivePrefix}descricao_problema']),
      descricaoSolucao: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}descricao_solucao']),
      dataAbertura: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data_abertura']),
      dataEncerramento: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data_encerramento']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || codigoUsuario != null) {
      map['codigo_usuario'] = Variable<int?>(codigoUsuario);
    }
    if (!nullToAbsent || codigoColaborador != null) {
      map['codigo_colaborador'] = Variable<int?>(codigoColaborador);
    }
    if (!nullToAbsent || codigoCategoria != null) {
      map['codigo_categoria'] = Variable<int?>(codigoCategoria);
    }
    if (!nullToAbsent || codigoLocal != null) {
      map['codigo_local'] = Variable<int?>(codigoLocal);
    }
    if (!nullToAbsent || codigoSubLocal != null) {
      map['codigo_sub_local'] = Variable<int?>(codigoSubLocal);
    }
    if (!nullToAbsent || codigoStatus != null) {
      map['codigo_status'] = Variable<int?>(codigoStatus);
    }
    if (!nullToAbsent || descricaoProblema != null) {
      map['descricao_problema'] = Variable<String?>(descricaoProblema);
    }
    if (!nullToAbsent || descricaoSolucao != null) {
      map['descricao_solucao'] = Variable<String?>(descricaoSolucao);
    }
    if (!nullToAbsent || dataAbertura != null) {
      map['data_abertura'] = Variable<DateTime?>(dataAbertura);
    }
    if (!nullToAbsent || dataEncerramento != null) {
      map['data_encerramento'] = Variable<DateTime?>(dataEncerramento);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  OrdemServicosCompanion toCompanion(bool nullToAbsent) {
    return OrdemServicosCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      codigoUsuario: codigoUsuario == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoUsuario),
      codigoColaborador: codigoColaborador == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoColaborador),
      codigoCategoria: codigoCategoria == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoCategoria),
      codigoLocal: codigoLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoLocal),
      codigoSubLocal: codigoSubLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoSubLocal),
      codigoStatus: codigoStatus == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoStatus),
      descricaoProblema: descricaoProblema == null && nullToAbsent
          ? const Value.absent()
          : Value(descricaoProblema),
      descricaoSolucao: descricaoSolucao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricaoSolucao),
      dataAbertura: dataAbertura == null && nullToAbsent
          ? const Value.absent()
          : Value(dataAbertura),
      dataEncerramento: dataEncerramento == null && nullToAbsent
          ? const Value.absent()
          : Value(dataEncerramento),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory OrdemServico.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdemServico(
      codigo: serializer.fromJson<int?>(json['codigo']),
      codigoUsuario: serializer.fromJson<int?>(json['codigoUsuario']),
      codigoColaborador: serializer.fromJson<int?>(json['codigoColaborador']),
      codigoCategoria: serializer.fromJson<int?>(json['codigoCategoria']),
      codigoLocal: serializer.fromJson<int?>(json['codigoLocal']),
      codigoSubLocal: serializer.fromJson<int?>(json['codigoSubLocal']),
      codigoStatus: serializer.fromJson<int?>(json['codigoStatus']),
      descricaoProblema:
          serializer.fromJson<String?>(json['descricaoProblema']),
      descricaoSolucao: serializer.fromJson<String?>(json['descricaoSolucao']),
      dataAbertura: serializer.fromJson<DateTime?>(json['dataAbertura']),
      dataEncerramento:
          serializer.fromJson<DateTime?>(json['dataEncerramento']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'codigoUsuario': serializer.toJson<int?>(codigoUsuario),
      'codigoColaborador': serializer.toJson<int?>(codigoColaborador),
      'codigoCategoria': serializer.toJson<int?>(codigoCategoria),
      'codigoLocal': serializer.toJson<int?>(codigoLocal),
      'codigoSubLocal': serializer.toJson<int?>(codigoSubLocal),
      'codigoStatus': serializer.toJson<int?>(codigoStatus),
      'descricaoProblema': serializer.toJson<String?>(descricaoProblema),
      'descricaoSolucao': serializer.toJson<String?>(descricaoSolucao),
      'dataAbertura': serializer.toJson<DateTime?>(dataAbertura),
      'dataEncerramento': serializer.toJson<DateTime?>(dataEncerramento),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  OrdemServico copyWith(
          {int? codigo,
          int? codigoUsuario,
          int? codigoColaborador,
          int? codigoCategoria,
          int? codigoLocal,
          int? codigoSubLocal,
          int? codigoStatus,
          String? descricaoProblema,
          String? descricaoSolucao,
          DateTime? dataAbertura,
          DateTime? dataEncerramento,
          String? deletado}) =>
      OrdemServico(
        codigo: codigo ?? this.codigo,
        codigoUsuario: codigoUsuario ?? this.codigoUsuario,
        codigoColaborador: codigoColaborador ?? this.codigoColaborador,
        codigoCategoria: codigoCategoria ?? this.codigoCategoria,
        codigoLocal: codigoLocal ?? this.codigoLocal,
        codigoSubLocal: codigoSubLocal ?? this.codigoSubLocal,
        codigoStatus: codigoStatus ?? this.codigoStatus,
        descricaoProblema: descricaoProblema ?? this.descricaoProblema,
        descricaoSolucao: descricaoSolucao ?? this.descricaoSolucao,
        dataAbertura: dataAbertura ?? this.dataAbertura,
        dataEncerramento: dataEncerramento ?? this.dataEncerramento,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('OrdemServico(')
          ..write('codigo: $codigo, ')
          ..write('codigoUsuario: $codigoUsuario, ')
          ..write('codigoColaborador: $codigoColaborador, ')
          ..write('codigoCategoria: $codigoCategoria, ')
          ..write('codigoLocal: $codigoLocal, ')
          ..write('codigoSubLocal: $codigoSubLocal, ')
          ..write('codigoStatus: $codigoStatus, ')
          ..write('descricaoProblema: $descricaoProblema, ')
          ..write('descricaoSolucao: $descricaoSolucao, ')
          ..write('dataAbertura: $dataAbertura, ')
          ..write('dataEncerramento: $dataEncerramento, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      codigo,
      codigoUsuario,
      codigoColaborador,
      codigoCategoria,
      codigoLocal,
      codigoSubLocal,
      codigoStatus,
      descricaoProblema,
      descricaoSolucao,
      dataAbertura,
      dataEncerramento,
      deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdemServico &&
          other.codigo == this.codigo &&
          other.codigoUsuario == this.codigoUsuario &&
          other.codigoColaborador == this.codigoColaborador &&
          other.codigoCategoria == this.codigoCategoria &&
          other.codigoLocal == this.codigoLocal &&
          other.codigoSubLocal == this.codigoSubLocal &&
          other.codigoStatus == this.codigoStatus &&
          other.descricaoProblema == this.descricaoProblema &&
          other.descricaoSolucao == this.descricaoSolucao &&
          other.dataAbertura == this.dataAbertura &&
          other.dataEncerramento == this.dataEncerramento &&
          other.deletado == this.deletado);
}

class OrdemServicosCompanion extends UpdateCompanion<OrdemServico> {
  final Value<int?> codigo;
  final Value<int?> codigoUsuario;
  final Value<int?> codigoColaborador;
  final Value<int?> codigoCategoria;
  final Value<int?> codigoLocal;
  final Value<int?> codigoSubLocal;
  final Value<int?> codigoStatus;
  final Value<String?> descricaoProblema;
  final Value<String?> descricaoSolucao;
  final Value<DateTime?> dataAbertura;
  final Value<DateTime?> dataEncerramento;
  final Value<String?> deletado;
  const OrdemServicosCompanion({
    this.codigo = const Value.absent(),
    this.codigoUsuario = const Value.absent(),
    this.codigoColaborador = const Value.absent(),
    this.codigoCategoria = const Value.absent(),
    this.codigoLocal = const Value.absent(),
    this.codigoSubLocal = const Value.absent(),
    this.codigoStatus = const Value.absent(),
    this.descricaoProblema = const Value.absent(),
    this.descricaoSolucao = const Value.absent(),
    this.dataAbertura = const Value.absent(),
    this.dataEncerramento = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  OrdemServicosCompanion.insert({
    this.codigo = const Value.absent(),
    this.codigoUsuario = const Value.absent(),
    this.codigoColaborador = const Value.absent(),
    this.codigoCategoria = const Value.absent(),
    this.codigoLocal = const Value.absent(),
    this.codigoSubLocal = const Value.absent(),
    this.codigoStatus = const Value.absent(),
    this.descricaoProblema = const Value.absent(),
    this.descricaoSolucao = const Value.absent(),
    this.dataAbertura = const Value.absent(),
    this.dataEncerramento = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<OrdemServico> custom({
    Expression<int?>? codigo,
    Expression<int?>? codigoUsuario,
    Expression<int?>? codigoColaborador,
    Expression<int?>? codigoCategoria,
    Expression<int?>? codigoLocal,
    Expression<int?>? codigoSubLocal,
    Expression<int?>? codigoStatus,
    Expression<String?>? descricaoProblema,
    Expression<String?>? descricaoSolucao,
    Expression<DateTime?>? dataAbertura,
    Expression<DateTime?>? dataEncerramento,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (codigoUsuario != null) 'codigo_usuario': codigoUsuario,
      if (codigoColaborador != null) 'codigo_colaborador': codigoColaborador,
      if (codigoCategoria != null) 'codigo_categoria': codigoCategoria,
      if (codigoLocal != null) 'codigo_local': codigoLocal,
      if (codigoSubLocal != null) 'codigo_sub_local': codigoSubLocal,
      if (codigoStatus != null) 'codigo_status': codigoStatus,
      if (descricaoProblema != null) 'descricao_problema': descricaoProblema,
      if (descricaoSolucao != null) 'descricao_solucao': descricaoSolucao,
      if (dataAbertura != null) 'data_abertura': dataAbertura,
      if (dataEncerramento != null) 'data_encerramento': dataEncerramento,
      if (deletado != null) 'deletado': deletado,
    });
  }

  OrdemServicosCompanion copyWith(
      {Value<int?>? codigo,
      Value<int?>? codigoUsuario,
      Value<int?>? codigoColaborador,
      Value<int?>? codigoCategoria,
      Value<int?>? codigoLocal,
      Value<int?>? codigoSubLocal,
      Value<int?>? codigoStatus,
      Value<String?>? descricaoProblema,
      Value<String?>? descricaoSolucao,
      Value<DateTime?>? dataAbertura,
      Value<DateTime?>? dataEncerramento,
      Value<String?>? deletado}) {
    return OrdemServicosCompanion(
      codigo: codigo ?? this.codigo,
      codigoUsuario: codigoUsuario ?? this.codigoUsuario,
      codigoColaborador: codigoColaborador ?? this.codigoColaborador,
      codigoCategoria: codigoCategoria ?? this.codigoCategoria,
      codigoLocal: codigoLocal ?? this.codigoLocal,
      codigoSubLocal: codigoSubLocal ?? this.codigoSubLocal,
      codigoStatus: codigoStatus ?? this.codigoStatus,
      descricaoProblema: descricaoProblema ?? this.descricaoProblema,
      descricaoSolucao: descricaoSolucao ?? this.descricaoSolucao,
      dataAbertura: dataAbertura ?? this.dataAbertura,
      dataEncerramento: dataEncerramento ?? this.dataEncerramento,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (codigoUsuario.present) {
      map['codigo_usuario'] = Variable<int?>(codigoUsuario.value);
    }
    if (codigoColaborador.present) {
      map['codigo_colaborador'] = Variable<int?>(codigoColaborador.value);
    }
    if (codigoCategoria.present) {
      map['codigo_categoria'] = Variable<int?>(codigoCategoria.value);
    }
    if (codigoLocal.present) {
      map['codigo_local'] = Variable<int?>(codigoLocal.value);
    }
    if (codigoSubLocal.present) {
      map['codigo_sub_local'] = Variable<int?>(codigoSubLocal.value);
    }
    if (codigoStatus.present) {
      map['codigo_status'] = Variable<int?>(codigoStatus.value);
    }
    if (descricaoProblema.present) {
      map['descricao_problema'] = Variable<String?>(descricaoProblema.value);
    }
    if (descricaoSolucao.present) {
      map['descricao_solucao'] = Variable<String?>(descricaoSolucao.value);
    }
    if (dataAbertura.present) {
      map['data_abertura'] = Variable<DateTime?>(dataAbertura.value);
    }
    if (dataEncerramento.present) {
      map['data_encerramento'] = Variable<DateTime?>(dataEncerramento.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdemServicosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('codigoUsuario: $codigoUsuario, ')
          ..write('codigoColaborador: $codigoColaborador, ')
          ..write('codigoCategoria: $codigoCategoria, ')
          ..write('codigoLocal: $codigoLocal, ')
          ..write('codigoSubLocal: $codigoSubLocal, ')
          ..write('codigoStatus: $codigoStatus, ')
          ..write('descricaoProblema: $descricaoProblema, ')
          ..write('descricaoSolucao: $descricaoSolucao, ')
          ..write('dataAbertura: $dataAbertura, ')
          ..write('dataEncerramento: $dataEncerramento, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $OrdemServicosTable extends OrdemServicos
    with TableInfo<$OrdemServicosTable, OrdemServico> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdemServicosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codigoUsuarioMeta =
      const VerificationMeta('codigoUsuario');
  @override
  late final GeneratedColumn<int?> codigoUsuario = GeneratedColumn<int?>(
      'codigo_usuario', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_usuario(codigo)');
  final VerificationMeta _codigoColaboradorMeta =
      const VerificationMeta('codigoColaborador');
  @override
  late final GeneratedColumn<int?> codigoColaborador = GeneratedColumn<int?>(
      'codigo_colaborador', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_colaborador(codigo)');
  final VerificationMeta _codigoCategoriaMeta =
      const VerificationMeta('codigoCategoria');
  @override
  late final GeneratedColumn<int?> codigoCategoria = GeneratedColumn<int?>(
      'codigo_categoria', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_categoria(codigo)');
  final VerificationMeta _codigoLocalMeta =
      const VerificationMeta('codigoLocal');
  @override
  late final GeneratedColumn<int?> codigoLocal = GeneratedColumn<int?>(
      'codigo_local', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_local(codigo)');
  final VerificationMeta _codigoSubLocalMeta =
      const VerificationMeta('codigoSubLocal');
  @override
  late final GeneratedColumn<int?> codigoSubLocal = GeneratedColumn<int?>(
      'codigo_sub_local', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_local_sub(codigo)');
  final VerificationMeta _codigoStatusMeta =
      const VerificationMeta('codigoStatus');
  @override
  late final GeneratedColumn<int?> codigoStatus = GeneratedColumn<int?>(
      'codigo_status', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints:
          'NULLABLE REFERENCES tb_status_ordem_servico(codigo)');
  final VerificationMeta _descricaoProblemaMeta =
      const VerificationMeta('descricaoProblema');
  @override
  late final GeneratedColumn<String?> descricaoProblema =
      GeneratedColumn<String?>('descricao_problema', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 500),
          type: const StringType(),
          requiredDuringInsert: false);
  final VerificationMeta _descricaoSolucaoMeta =
      const VerificationMeta('descricaoSolucao');
  @override
  late final GeneratedColumn<String?> descricaoSolucao =
      GeneratedColumn<String?>('descricao_solucao', aliasedName, true,
          additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 650),
          type: const StringType(),
          requiredDuringInsert: false);
  final VerificationMeta _dataAberturaMeta =
      const VerificationMeta('dataAbertura');
  @override
  late final GeneratedColumn<DateTime?> dataAbertura =
      GeneratedColumn<DateTime?>('data_abertura', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _dataEncerramentoMeta =
      const VerificationMeta('dataEncerramento');
  @override
  late final GeneratedColumn<DateTime?> dataEncerramento =
      GeneratedColumn<DateTime?>('data_encerramento', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        codigo,
        codigoUsuario,
        codigoColaborador,
        codigoCategoria,
        codigoLocal,
        codigoSubLocal,
        codigoStatus,
        descricaoProblema,
        descricaoSolucao,
        dataAbertura,
        dataEncerramento,
        deletado
      ];
  @override
  String get aliasedName => _alias ?? 'tb_ordem_servico';
  @override
  String get actualTableName => 'tb_ordem_servico';
  @override
  VerificationContext validateIntegrity(Insertable<OrdemServico> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('codigo_usuario')) {
      context.handle(
          _codigoUsuarioMeta,
          codigoUsuario.isAcceptableOrUnknown(
              data['codigo_usuario']!, _codigoUsuarioMeta));
    }
    if (data.containsKey('codigo_colaborador')) {
      context.handle(
          _codigoColaboradorMeta,
          codigoColaborador.isAcceptableOrUnknown(
              data['codigo_colaborador']!, _codigoColaboradorMeta));
    }
    if (data.containsKey('codigo_categoria')) {
      context.handle(
          _codigoCategoriaMeta,
          codigoCategoria.isAcceptableOrUnknown(
              data['codigo_categoria']!, _codigoCategoriaMeta));
    }
    if (data.containsKey('codigo_local')) {
      context.handle(
          _codigoLocalMeta,
          codigoLocal.isAcceptableOrUnknown(
              data['codigo_local']!, _codigoLocalMeta));
    }
    if (data.containsKey('codigo_sub_local')) {
      context.handle(
          _codigoSubLocalMeta,
          codigoSubLocal.isAcceptableOrUnknown(
              data['codigo_sub_local']!, _codigoSubLocalMeta));
    }
    if (data.containsKey('codigo_status')) {
      context.handle(
          _codigoStatusMeta,
          codigoStatus.isAcceptableOrUnknown(
              data['codigo_status']!, _codigoStatusMeta));
    }
    if (data.containsKey('descricao_problema')) {
      context.handle(
          _descricaoProblemaMeta,
          descricaoProblema.isAcceptableOrUnknown(
              data['descricao_problema']!, _descricaoProblemaMeta));
    }
    if (data.containsKey('descricao_solucao')) {
      context.handle(
          _descricaoSolucaoMeta,
          descricaoSolucao.isAcceptableOrUnknown(
              data['descricao_solucao']!, _descricaoSolucaoMeta));
    }
    if (data.containsKey('data_abertura')) {
      context.handle(
          _dataAberturaMeta,
          dataAbertura.isAcceptableOrUnknown(
              data['data_abertura']!, _dataAberturaMeta));
    }
    if (data.containsKey('data_encerramento')) {
      context.handle(
          _dataEncerramentoMeta,
          dataEncerramento.isAcceptableOrUnknown(
              data['data_encerramento']!, _dataEncerramentoMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  OrdemServico map(Map<String, dynamic> data, {String? tablePrefix}) {
    return OrdemServico.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $OrdemServicosTable createAlias(String alias) {
    return $OrdemServicosTable(attachedDatabase, alias);
  }
}

class Local extends DataClass implements Insertable<Local> {
  final int? codigo;
  final String? nome;
  final String? deletado;
  Local({this.codigo, this.nome, this.deletado});
  factory Local.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Local(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  LocalsCompanion toCompanion(bool nullToAbsent) {
    return LocalsCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory Local.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Local(
      codigo: serializer.fromJson<int?>(json['codigo']),
      nome: serializer.fromJson<String?>(json['nome']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'nome': serializer.toJson<String?>(nome),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  Local copyWith({int? codigo, String? nome, String? deletado}) => Local(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('Local(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome, deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Local &&
          other.codigo == this.codigo &&
          other.nome == this.nome &&
          other.deletado == this.deletado);
}

class LocalsCompanion extends UpdateCompanion<Local> {
  final Value<int?> codigo;
  final Value<String?> nome;
  final Value<String?> deletado;
  const LocalsCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  LocalsCompanion.insert({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<Local> custom({
    Expression<int?>? codigo,
    Expression<String?>? nome,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
      if (deletado != null) 'deletado': deletado,
    });
  }

  LocalsCompanion copyWith(
      {Value<int?>? codigo, Value<String?>? nome, Value<String?>? deletado}) {
    return LocalsCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalsCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $LocalsTable extends Locals with TableInfo<$LocalsTable, Local> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 180),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [codigo, nome, deletado];
  @override
  String get aliasedName => _alias ?? 'tb_local';
  @override
  String get actualTableName => 'tb_local';
  @override
  VerificationContext validateIntegrity(Insertable<Local> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  Local map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Local.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocalsTable createAlias(String alias) {
    return $LocalsTable(attachedDatabase, alias);
  }
}

class LocalSub extends DataClass implements Insertable<LocalSub> {
  final int? codigo;
  final int? codigoLocal;
  final String? nome;
  final String? deletado;
  LocalSub({this.codigo, this.codigoLocal, this.nome, this.deletado});
  factory LocalSub.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return LocalSub(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      codigoLocal: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_local']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || codigoLocal != null) {
      map['codigo_local'] = Variable<int?>(codigoLocal);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  LocalSubsCompanion toCompanion(bool nullToAbsent) {
    return LocalSubsCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      codigoLocal: codigoLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoLocal),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory LocalSub.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LocalSub(
      codigo: serializer.fromJson<int?>(json['codigo']),
      codigoLocal: serializer.fromJson<int?>(json['codigoLocal']),
      nome: serializer.fromJson<String?>(json['nome']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'codigoLocal': serializer.toJson<int?>(codigoLocal),
      'nome': serializer.toJson<String?>(nome),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  LocalSub copyWith(
          {int? codigo, int? codigoLocal, String? nome, String? deletado}) =>
      LocalSub(
        codigo: codigo ?? this.codigo,
        codigoLocal: codigoLocal ?? this.codigoLocal,
        nome: nome ?? this.nome,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('LocalSub(')
          ..write('codigo: $codigo, ')
          ..write('codigoLocal: $codigoLocal, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, codigoLocal, nome, deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LocalSub &&
          other.codigo == this.codigo &&
          other.codigoLocal == this.codigoLocal &&
          other.nome == this.nome &&
          other.deletado == this.deletado);
}

class LocalSubsCompanion extends UpdateCompanion<LocalSub> {
  final Value<int?> codigo;
  final Value<int?> codigoLocal;
  final Value<String?> nome;
  final Value<String?> deletado;
  const LocalSubsCompanion({
    this.codigo = const Value.absent(),
    this.codigoLocal = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  LocalSubsCompanion.insert({
    this.codigo = const Value.absent(),
    this.codigoLocal = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<LocalSub> custom({
    Expression<int?>? codigo,
    Expression<int?>? codigoLocal,
    Expression<String?>? nome,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (codigoLocal != null) 'codigo_local': codigoLocal,
      if (nome != null) 'nome': nome,
      if (deletado != null) 'deletado': deletado,
    });
  }

  LocalSubsCompanion copyWith(
      {Value<int?>? codigo,
      Value<int?>? codigoLocal,
      Value<String?>? nome,
      Value<String?>? deletado}) {
    return LocalSubsCompanion(
      codigo: codigo ?? this.codigo,
      codigoLocal: codigoLocal ?? this.codigoLocal,
      nome: nome ?? this.nome,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (codigoLocal.present) {
      map['codigo_local'] = Variable<int?>(codigoLocal.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalSubsCompanion(')
          ..write('codigo: $codigo, ')
          ..write('codigoLocal: $codigoLocal, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $LocalSubsTable extends LocalSubs
    with TableInfo<$LocalSubsTable, LocalSub> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $LocalSubsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codigoLocalMeta =
      const VerificationMeta('codigoLocal');
  @override
  late final GeneratedColumn<int?> codigoLocal = GeneratedColumn<int?>(
      'codigo_local', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_local(codigo)');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 180),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [codigo, codigoLocal, nome, deletado];
  @override
  String get aliasedName => _alias ?? 'tb_local_sub';
  @override
  String get actualTableName => 'tb_local_sub';
  @override
  VerificationContext validateIntegrity(Insertable<LocalSub> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('codigo_local')) {
      context.handle(
          _codigoLocalMeta,
          codigoLocal.isAcceptableOrUnknown(
              data['codigo_local']!, _codigoLocalMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  LocalSub map(Map<String, dynamic> data, {String? tablePrefix}) {
    return LocalSub.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $LocalSubsTable createAlias(String alias) {
    return $LocalSubsTable(attachedDatabase, alias);
  }
}

class Categoria extends DataClass implements Insertable<Categoria> {
  final int? codigo;
  final String? nome;
  final String? deletado;
  Categoria({this.codigo, this.nome, this.deletado});
  factory Categoria.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Categoria(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory Categoria.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      codigo: serializer.fromJson<int?>(json['codigo']),
      nome: serializer.fromJson<String?>(json['nome']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'nome': serializer.toJson<String?>(nome),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  Categoria copyWith({int? codigo, String? nome, String? deletado}) =>
      Categoria(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome, deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.codigo == this.codigo &&
          other.nome == this.nome &&
          other.deletado == this.deletado);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int?> codigo;
  final Value<String?> nome;
  final Value<String?> deletado;
  const CategoriasCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<Categoria> custom({
    Expression<int?>? codigo,
    Expression<String?>? nome,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
      if (deletado != null) 'deletado': deletado,
    });
  }

  CategoriasCompanion copyWith(
      {Value<int?>? codigo, Value<String?>? nome, Value<String?>? deletado}) {
    return CategoriasCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $CategoriasTable extends Categorias
    with TableInfo<$CategoriasTable, Categoria> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CategoriasTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 180),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [codigo, nome, deletado];
  @override
  String get aliasedName => _alias ?? 'tb_categoria';
  @override
  String get actualTableName => 'tb_categoria';
  @override
  VerificationContext validateIntegrity(Insertable<Categoria> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  Categoria map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Categoria.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $CategoriasTable createAlias(String alias) {
    return $CategoriasTable(attachedDatabase, alias);
  }
}

class StatusOrdemServico extends DataClass
    implements Insertable<StatusOrdemServico> {
  final int? codigo;
  final String? nome;
  final String? deletado;
  StatusOrdemServico({this.codigo, this.nome, this.deletado});
  factory StatusOrdemServico.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return StatusOrdemServico(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  StatusOrdemServicosCompanion toCompanion(bool nullToAbsent) {
    return StatusOrdemServicosCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory StatusOrdemServico.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatusOrdemServico(
      codigo: serializer.fromJson<int?>(json['codigo']),
      nome: serializer.fromJson<String?>(json['nome']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'nome': serializer.toJson<String?>(nome),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  StatusOrdemServico copyWith({int? codigo, String? nome, String? deletado}) =>
      StatusOrdemServico(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('StatusOrdemServico(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome, deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatusOrdemServico &&
          other.codigo == this.codigo &&
          other.nome == this.nome &&
          other.deletado == this.deletado);
}

class StatusOrdemServicosCompanion extends UpdateCompanion<StatusOrdemServico> {
  final Value<int?> codigo;
  final Value<String?> nome;
  final Value<String?> deletado;
  const StatusOrdemServicosCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  StatusOrdemServicosCompanion.insert({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<StatusOrdemServico> custom({
    Expression<int?>? codigo,
    Expression<String?>? nome,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
      if (deletado != null) 'deletado': deletado,
    });
  }

  StatusOrdemServicosCompanion copyWith(
      {Value<int?>? codigo, Value<String?>? nome, Value<String?>? deletado}) {
    return StatusOrdemServicosCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatusOrdemServicosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $StatusOrdemServicosTable extends StatusOrdemServicos
    with TableInfo<$StatusOrdemServicosTable, StatusOrdemServico> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $StatusOrdemServicosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 120),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [codigo, nome, deletado];
  @override
  String get aliasedName => _alias ?? 'tb_status_ordem_servico';
  @override
  String get actualTableName => 'tb_status_ordem_servico';
  @override
  VerificationContext validateIntegrity(Insertable<StatusOrdemServico> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  StatusOrdemServico map(Map<String, dynamic> data, {String? tablePrefix}) {
    return StatusOrdemServico.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $StatusOrdemServicosTable createAlias(String alias) {
    return $StatusOrdemServicosTable(attachedDatabase, alias);
  }
}

class Usuario extends DataClass implements Insertable<Usuario> {
  final int? codigo;
  final String? matricula;
  final String? senha;
  final String? nome;
  final String? email;
  final String? celular;
  final String? deletado;
  Usuario(
      {this.codigo,
      this.matricula,
      this.senha,
      this.nome,
      this.email,
      this.celular,
      this.deletado});
  factory Usuario.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Usuario(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      matricula: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}matricula']),
      senha: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}senha']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      celular: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}celular']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || matricula != null) {
      map['matricula'] = Variable<String?>(matricula);
    }
    if (!nullToAbsent || senha != null) {
      map['senha'] = Variable<String?>(senha);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String?>(email);
    }
    if (!nullToAbsent || celular != null) {
      map['celular'] = Variable<String?>(celular);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      matricula: matricula == null && nullToAbsent
          ? const Value.absent()
          : Value(matricula),
      senha:
          senha == null && nullToAbsent ? const Value.absent() : Value(senha),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      celular: celular == null && nullToAbsent
          ? const Value.absent()
          : Value(celular),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      codigo: serializer.fromJson<int?>(json['codigo']),
      matricula: serializer.fromJson<String?>(json['matricula']),
      senha: serializer.fromJson<String?>(json['senha']),
      nome: serializer.fromJson<String?>(json['nome']),
      email: serializer.fromJson<String?>(json['email']),
      celular: serializer.fromJson<String?>(json['celular']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'matricula': serializer.toJson<String?>(matricula),
      'senha': serializer.toJson<String?>(senha),
      'nome': serializer.toJson<String?>(nome),
      'email': serializer.toJson<String?>(email),
      'celular': serializer.toJson<String?>(celular),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  Usuario copyWith(
          {int? codigo,
          String? matricula,
          String? senha,
          String? nome,
          String? email,
          String? celular,
          String? deletado}) =>
      Usuario(
        codigo: codigo ?? this.codigo,
        matricula: matricula ?? this.matricula,
        senha: senha ?? this.senha,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        celular: celular ?? this.celular,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('codigo: $codigo, ')
          ..write('matricula: $matricula, ')
          ..write('senha: $senha, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('celular: $celular, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(codigo, matricula, senha, nome, email, celular, deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.codigo == this.codigo &&
          other.matricula == this.matricula &&
          other.senha == this.senha &&
          other.nome == this.nome &&
          other.email == this.email &&
          other.celular == this.celular &&
          other.deletado == this.deletado);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int?> codigo;
  final Value<String?> matricula;
  final Value<String?> senha;
  final Value<String?> nome;
  final Value<String?> email;
  final Value<String?> celular;
  final Value<String?> deletado;
  const UsuariosCompanion({
    this.codigo = const Value.absent(),
    this.matricula = const Value.absent(),
    this.senha = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.celular = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.codigo = const Value.absent(),
    this.matricula = const Value.absent(),
    this.senha = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.celular = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<Usuario> custom({
    Expression<int?>? codigo,
    Expression<String?>? matricula,
    Expression<String?>? senha,
    Expression<String?>? nome,
    Expression<String?>? email,
    Expression<String?>? celular,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (matricula != null) 'matricula': matricula,
      if (senha != null) 'senha': senha,
      if (nome != null) 'nome': nome,
      if (email != null) 'email': email,
      if (celular != null) 'celular': celular,
      if (deletado != null) 'deletado': deletado,
    });
  }

  UsuariosCompanion copyWith(
      {Value<int?>? codigo,
      Value<String?>? matricula,
      Value<String?>? senha,
      Value<String?>? nome,
      Value<String?>? email,
      Value<String?>? celular,
      Value<String?>? deletado}) {
    return UsuariosCompanion(
      codigo: codigo ?? this.codigo,
      matricula: matricula ?? this.matricula,
      senha: senha ?? this.senha,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      celular: celular ?? this.celular,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (matricula.present) {
      map['matricula'] = Variable<String?>(matricula.value);
    }
    if (senha.present) {
      map['senha'] = Variable<String?>(senha.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (email.present) {
      map['email'] = Variable<String?>(email.value);
    }
    if (celular.present) {
      map['celular'] = Variable<String?>(celular.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuariosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('matricula: $matricula, ')
          ..write('senha: $senha, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('celular: $celular, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $UsuariosTable extends Usuarios with TableInfo<$UsuariosTable, Usuario> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuariosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _matriculaMeta = const VerificationMeta('matricula');
  @override
  late final GeneratedColumn<String?> matricula = GeneratedColumn<String?>(
      'matricula', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _senhaMeta = const VerificationMeta('senha');
  @override
  late final GeneratedColumn<String?> senha = GeneratedColumn<String?>(
      'senha', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 254),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 180),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 254),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _celularMeta = const VerificationMeta('celular');
  @override
  late final GeneratedColumn<String?> celular = GeneratedColumn<String?>(
      'celular', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 15),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [codigo, matricula, senha, nome, email, celular, deletado];
  @override
  String get aliasedName => _alias ?? 'tb_usuario';
  @override
  String get actualTableName => 'tb_usuario';
  @override
  VerificationContext validateIntegrity(Insertable<Usuario> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('matricula')) {
      context.handle(_matriculaMeta,
          matricula.isAcceptableOrUnknown(data['matricula']!, _matriculaMeta));
    }
    if (data.containsKey('senha')) {
      context.handle(
          _senhaMeta, senha.isAcceptableOrUnknown(data['senha']!, _senhaMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('celular')) {
      context.handle(_celularMeta,
          celular.isAcceptableOrUnknown(data['celular']!, _celularMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  Usuario map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Usuario.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsuariosTable createAlias(String alias) {
    return $UsuariosTable(attachedDatabase, alias);
  }
}

class Permissao extends DataClass implements Insertable<Permissao> {
  final int? codigo;
  final String? nome;
  final String? descricao;
  final String? deletado;
  Permissao({this.codigo, this.nome, this.descricao, this.deletado});
  factory Permissao.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Permissao(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      descricao: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}descricao']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String?>(descricao);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  PermissaosCompanion toCompanion(bool nullToAbsent) {
    return PermissaosCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory Permissao.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Permissao(
      codigo: serializer.fromJson<int?>(json['codigo']),
      nome: serializer.fromJson<String?>(json['nome']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'nome': serializer.toJson<String?>(nome),
      'descricao': serializer.toJson<String?>(descricao),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  Permissao copyWith(
          {int? codigo, String? nome, String? descricao, String? deletado}) =>
      Permissao(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
        descricao: descricao ?? this.descricao,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('Permissao(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome, descricao, deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Permissao &&
          other.codigo == this.codigo &&
          other.nome == this.nome &&
          other.descricao == this.descricao &&
          other.deletado == this.deletado);
}

class PermissaosCompanion extends UpdateCompanion<Permissao> {
  final Value<int?> codigo;
  final Value<String?> nome;
  final Value<String?> descricao;
  final Value<String?> deletado;
  const PermissaosCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  PermissaosCompanion.insert({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.descricao = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<Permissao> custom({
    Expression<int?>? codigo,
    Expression<String?>? nome,
    Expression<String?>? descricao,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
      if (descricao != null) 'descricao': descricao,
      if (deletado != null) 'deletado': deletado,
    });
  }

  PermissaosCompanion copyWith(
      {Value<int?>? codigo,
      Value<String?>? nome,
      Value<String?>? descricao,
      Value<String?>? deletado}) {
    return PermissaosCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      descricao: descricao ?? this.descricao,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String?>(descricao.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('PermissaosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('descricao: $descricao, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $PermissaosTable extends Permissaos
    with TableInfo<$PermissaosTable, Permissao> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PermissaosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _descricaoMeta = const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String?> descricao = GeneratedColumn<String?>(
      'descricao', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 255),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [codigo, nome, descricao, deletado];
  @override
  String get aliasedName => _alias ?? 'tb_permissao';
  @override
  String get actualTableName => 'tb_permissao';
  @override
  VerificationContext validateIntegrity(Insertable<Permissao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  Permissao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Permissao.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $PermissaosTable createAlias(String alias) {
    return $PermissaosTable(attachedDatabase, alias);
  }
}

class UsuarioPermissao extends DataClass
    implements Insertable<UsuarioPermissao> {
  final int? codigo;
  final int? codigoUsuario;
  final int? codigoPermissao;
  UsuarioPermissao({this.codigo, this.codigoUsuario, this.codigoPermissao});
  factory UsuarioPermissao.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return UsuarioPermissao(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      codigoUsuario: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_usuario']),
      codigoPermissao: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_permissao']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || codigoUsuario != null) {
      map['codigo_usuario'] = Variable<int?>(codigoUsuario);
    }
    if (!nullToAbsent || codigoPermissao != null) {
      map['codigo_permissao'] = Variable<int?>(codigoPermissao);
    }
    return map;
  }

  UsuarioPermissaosCompanion toCompanion(bool nullToAbsent) {
    return UsuarioPermissaosCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      codigoUsuario: codigoUsuario == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoUsuario),
      codigoPermissao: codigoPermissao == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoPermissao),
    );
  }

  factory UsuarioPermissao.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UsuarioPermissao(
      codigo: serializer.fromJson<int?>(json['codigo']),
      codigoUsuario: serializer.fromJson<int?>(json['codigoUsuario']),
      codigoPermissao: serializer.fromJson<int?>(json['codigoPermissao']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'codigoUsuario': serializer.toJson<int?>(codigoUsuario),
      'codigoPermissao': serializer.toJson<int?>(codigoPermissao),
    };
  }

  UsuarioPermissao copyWith(
          {int? codigo, int? codigoUsuario, int? codigoPermissao}) =>
      UsuarioPermissao(
        codigo: codigo ?? this.codigo,
        codigoUsuario: codigoUsuario ?? this.codigoUsuario,
        codigoPermissao: codigoPermissao ?? this.codigoPermissao,
      );
  @override
  String toString() {
    return (StringBuffer('UsuarioPermissao(')
          ..write('codigo: $codigo, ')
          ..write('codigoUsuario: $codigoUsuario, ')
          ..write('codigoPermissao: $codigoPermissao')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, codigoUsuario, codigoPermissao);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UsuarioPermissao &&
          other.codigo == this.codigo &&
          other.codigoUsuario == this.codigoUsuario &&
          other.codigoPermissao == this.codigoPermissao);
}

class UsuarioPermissaosCompanion extends UpdateCompanion<UsuarioPermissao> {
  final Value<int?> codigo;
  final Value<int?> codigoUsuario;
  final Value<int?> codigoPermissao;
  const UsuarioPermissaosCompanion({
    this.codigo = const Value.absent(),
    this.codigoUsuario = const Value.absent(),
    this.codigoPermissao = const Value.absent(),
  });
  UsuarioPermissaosCompanion.insert({
    this.codigo = const Value.absent(),
    this.codigoUsuario = const Value.absent(),
    this.codigoPermissao = const Value.absent(),
  });
  static Insertable<UsuarioPermissao> custom({
    Expression<int?>? codigo,
    Expression<int?>? codigoUsuario,
    Expression<int?>? codigoPermissao,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (codigoUsuario != null) 'codigo_usuario': codigoUsuario,
      if (codigoPermissao != null) 'codigo_permissao': codigoPermissao,
    });
  }

  UsuarioPermissaosCompanion copyWith(
      {Value<int?>? codigo,
      Value<int?>? codigoUsuario,
      Value<int?>? codigoPermissao}) {
    return UsuarioPermissaosCompanion(
      codigo: codigo ?? this.codigo,
      codigoUsuario: codigoUsuario ?? this.codigoUsuario,
      codigoPermissao: codigoPermissao ?? this.codigoPermissao,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (codigoUsuario.present) {
      map['codigo_usuario'] = Variable<int?>(codigoUsuario.value);
    }
    if (codigoPermissao.present) {
      map['codigo_permissao'] = Variable<int?>(codigoPermissao.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UsuarioPermissaosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('codigoUsuario: $codigoUsuario, ')
          ..write('codigoPermissao: $codigoPermissao')
          ..write(')'))
        .toString();
  }
}

class $UsuarioPermissaosTable extends UsuarioPermissaos
    with TableInfo<$UsuarioPermissaosTable, UsuarioPermissao> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UsuarioPermissaosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codigoUsuarioMeta =
      const VerificationMeta('codigoUsuario');
  @override
  late final GeneratedColumn<int?> codigoUsuario = GeneratedColumn<int?>(
      'codigo_usuario', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_usuario(codigo)');
  final VerificationMeta _codigoPermissaoMeta =
      const VerificationMeta('codigoPermissao');
  @override
  late final GeneratedColumn<int?> codigoPermissao = GeneratedColumn<int?>(
      'codigo_permissao', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_permissao(codigo)');
  @override
  List<GeneratedColumn> get $columns =>
      [codigo, codigoUsuario, codigoPermissao];
  @override
  String get aliasedName => _alias ?? 'tb_usuario_permissao';
  @override
  String get actualTableName => 'tb_usuario_permissao';
  @override
  VerificationContext validateIntegrity(Insertable<UsuarioPermissao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('codigo_usuario')) {
      context.handle(
          _codigoUsuarioMeta,
          codigoUsuario.isAcceptableOrUnknown(
              data['codigo_usuario']!, _codigoUsuarioMeta));
    }
    if (data.containsKey('codigo_permissao')) {
      context.handle(
          _codigoPermissaoMeta,
          codigoPermissao.isAcceptableOrUnknown(
              data['codigo_permissao']!, _codigoPermissaoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  UsuarioPermissao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return UsuarioPermissao.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $UsuarioPermissaosTable createAlias(String alias) {
    return $UsuarioPermissaosTable(attachedDatabase, alias);
  }
}

class Sexo extends DataClass implements Insertable<Sexo> {
  final int? codigo;
  final String? nome;
  final String? deletado;
  Sexo({this.codigo, this.nome, this.deletado});
  factory Sexo.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Sexo(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  SexosCompanion toCompanion(bool nullToAbsent) {
    return SexosCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory Sexo.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Sexo(
      codigo: serializer.fromJson<int?>(json['codigo']),
      nome: serializer.fromJson<String?>(json['nome']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'nome': serializer.toJson<String?>(nome),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  Sexo copyWith({int? codigo, String? nome, String? deletado}) => Sexo(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('Sexo(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome, deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Sexo &&
          other.codigo == this.codigo &&
          other.nome == this.nome &&
          other.deletado == this.deletado);
}

class SexosCompanion extends UpdateCompanion<Sexo> {
  final Value<int?> codigo;
  final Value<String?> nome;
  final Value<String?> deletado;
  const SexosCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  SexosCompanion.insert({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<Sexo> custom({
    Expression<int?>? codigo,
    Expression<String?>? nome,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
      if (deletado != null) 'deletado': deletado,
    });
  }

  SexosCompanion copyWith(
      {Value<int?>? codigo, Value<String?>? nome, Value<String?>? deletado}) {
    return SexosCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('SexosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $SexosTable extends Sexos with TableInfo<$SexosTable, Sexo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $SexosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [codigo, nome, deletado];
  @override
  String get aliasedName => _alias ?? 'tb_sexo';
  @override
  String get actualTableName => 'tb_sexo';
  @override
  VerificationContext validateIntegrity(Insertable<Sexo> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  Sexo map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Sexo.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $SexosTable createAlias(String alias) {
    return $SexosTable(attachedDatabase, alias);
  }
}

class EstadoCivil extends DataClass implements Insertable<EstadoCivil> {
  final int? codigo;
  final String? nome;
  final String? deletado;
  EstadoCivil({this.codigo, this.nome, this.deletado});
  factory EstadoCivil.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return EstadoCivil(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  EstadoCivilsCompanion toCompanion(bool nullToAbsent) {
    return EstadoCivilsCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory EstadoCivil.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EstadoCivil(
      codigo: serializer.fromJson<int?>(json['codigo']),
      nome: serializer.fromJson<String?>(json['nome']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'nome': serializer.toJson<String?>(nome),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  EstadoCivil copyWith({int? codigo, String? nome, String? deletado}) =>
      EstadoCivil(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('EstadoCivil(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome, deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EstadoCivil &&
          other.codigo == this.codigo &&
          other.nome == this.nome &&
          other.deletado == this.deletado);
}

class EstadoCivilsCompanion extends UpdateCompanion<EstadoCivil> {
  final Value<int?> codigo;
  final Value<String?> nome;
  final Value<String?> deletado;
  const EstadoCivilsCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  EstadoCivilsCompanion.insert({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<EstadoCivil> custom({
    Expression<int?>? codigo,
    Expression<String?>? nome,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
      if (deletado != null) 'deletado': deletado,
    });
  }

  EstadoCivilsCompanion copyWith(
      {Value<int?>? codigo, Value<String?>? nome, Value<String?>? deletado}) {
    return EstadoCivilsCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EstadoCivilsCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $EstadoCivilsTable extends EstadoCivils
    with TableInfo<$EstadoCivilsTable, EstadoCivil> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EstadoCivilsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 50),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [codigo, nome, deletado];
  @override
  String get aliasedName => _alias ?? 'tb_estado_civil';
  @override
  String get actualTableName => 'tb_estado_civil';
  @override
  VerificationContext validateIntegrity(Insertable<EstadoCivil> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  EstadoCivil map(Map<String, dynamic> data, {String? tablePrefix}) {
    return EstadoCivil.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $EstadoCivilsTable createAlias(String alias) {
    return $EstadoCivilsTable(attachedDatabase, alias);
  }
}

class Colaborador extends DataClass implements Insertable<Colaborador> {
  final int? codigo;
  final int? codigoEstadoCivil;
  final int? codigoSexo;
  final String? matricula;
  final String? nome;
  final String? email;
  final String? celular;
  final String? telefone;
  final DateTime? dataAdmissao;
  final DateTime? dataDemissao;
  final String? deletado;
  Colaborador(
      {this.codigo,
      this.codigoEstadoCivil,
      this.codigoSexo,
      this.matricula,
      this.nome,
      this.email,
      this.celular,
      this.telefone,
      this.dataAdmissao,
      this.dataDemissao,
      this.deletado});
  factory Colaborador.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Colaborador(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      codigoEstadoCivil: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}codigo_estado_civil']),
      codigoSexo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_sexo']),
      matricula: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}matricula']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email']),
      celular: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}celular']),
      telefone: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}telefone']),
      dataAdmissao: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data_admissao']),
      dataDemissao: const DateTimeType()
          .mapFromDatabaseResponse(data['${effectivePrefix}data_demissao']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || codigoEstadoCivil != null) {
      map['codigo_estado_civil'] = Variable<int?>(codigoEstadoCivil);
    }
    if (!nullToAbsent || codigoSexo != null) {
      map['codigo_sexo'] = Variable<int?>(codigoSexo);
    }
    if (!nullToAbsent || matricula != null) {
      map['matricula'] = Variable<String?>(matricula);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || email != null) {
      map['email'] = Variable<String?>(email);
    }
    if (!nullToAbsent || celular != null) {
      map['celular'] = Variable<String?>(celular);
    }
    if (!nullToAbsent || telefone != null) {
      map['telefone'] = Variable<String?>(telefone);
    }
    if (!nullToAbsent || dataAdmissao != null) {
      map['data_admissao'] = Variable<DateTime?>(dataAdmissao);
    }
    if (!nullToAbsent || dataDemissao != null) {
      map['data_demissao'] = Variable<DateTime?>(dataDemissao);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  ColaboradorsCompanion toCompanion(bool nullToAbsent) {
    return ColaboradorsCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      codigoEstadoCivil: codigoEstadoCivil == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoEstadoCivil),
      codigoSexo: codigoSexo == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoSexo),
      matricula: matricula == null && nullToAbsent
          ? const Value.absent()
          : Value(matricula),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      email:
          email == null && nullToAbsent ? const Value.absent() : Value(email),
      celular: celular == null && nullToAbsent
          ? const Value.absent()
          : Value(celular),
      telefone: telefone == null && nullToAbsent
          ? const Value.absent()
          : Value(telefone),
      dataAdmissao: dataAdmissao == null && nullToAbsent
          ? const Value.absent()
          : Value(dataAdmissao),
      dataDemissao: dataDemissao == null && nullToAbsent
          ? const Value.absent()
          : Value(dataDemissao),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory Colaborador.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Colaborador(
      codigo: serializer.fromJson<int?>(json['codigo']),
      codigoEstadoCivil: serializer.fromJson<int?>(json['codigoEstadoCivil']),
      codigoSexo: serializer.fromJson<int?>(json['codigoSexo']),
      matricula: serializer.fromJson<String?>(json['matricula']),
      nome: serializer.fromJson<String?>(json['nome']),
      email: serializer.fromJson<String?>(json['email']),
      celular: serializer.fromJson<String?>(json['celular']),
      telefone: serializer.fromJson<String?>(json['telefone']),
      dataAdmissao: serializer.fromJson<DateTime?>(json['dataAdmissao']),
      dataDemissao: serializer.fromJson<DateTime?>(json['dataDemissao']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'codigoEstadoCivil': serializer.toJson<int?>(codigoEstadoCivil),
      'codigoSexo': serializer.toJson<int?>(codigoSexo),
      'matricula': serializer.toJson<String?>(matricula),
      'nome': serializer.toJson<String?>(nome),
      'email': serializer.toJson<String?>(email),
      'celular': serializer.toJson<String?>(celular),
      'telefone': serializer.toJson<String?>(telefone),
      'dataAdmissao': serializer.toJson<DateTime?>(dataAdmissao),
      'dataDemissao': serializer.toJson<DateTime?>(dataDemissao),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  Colaborador copyWith(
          {int? codigo,
          int? codigoEstadoCivil,
          int? codigoSexo,
          String? matricula,
          String? nome,
          String? email,
          String? celular,
          String? telefone,
          DateTime? dataAdmissao,
          DateTime? dataDemissao,
          String? deletado}) =>
      Colaborador(
        codigo: codigo ?? this.codigo,
        codigoEstadoCivil: codigoEstadoCivil ?? this.codigoEstadoCivil,
        codigoSexo: codigoSexo ?? this.codigoSexo,
        matricula: matricula ?? this.matricula,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        celular: celular ?? this.celular,
        telefone: telefone ?? this.telefone,
        dataAdmissao: dataAdmissao ?? this.dataAdmissao,
        dataDemissao: dataDemissao ?? this.dataDemissao,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('Colaborador(')
          ..write('codigo: $codigo, ')
          ..write('codigoEstadoCivil: $codigoEstadoCivil, ')
          ..write('codigoSexo: $codigoSexo, ')
          ..write('matricula: $matricula, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('celular: $celular, ')
          ..write('telefone: $telefone, ')
          ..write('dataAdmissao: $dataAdmissao, ')
          ..write('dataDemissao: $dataDemissao, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      codigo,
      codigoEstadoCivil,
      codigoSexo,
      matricula,
      nome,
      email,
      celular,
      telefone,
      dataAdmissao,
      dataDemissao,
      deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Colaborador &&
          other.codigo == this.codigo &&
          other.codigoEstadoCivil == this.codigoEstadoCivil &&
          other.codigoSexo == this.codigoSexo &&
          other.matricula == this.matricula &&
          other.nome == this.nome &&
          other.email == this.email &&
          other.celular == this.celular &&
          other.telefone == this.telefone &&
          other.dataAdmissao == this.dataAdmissao &&
          other.dataDemissao == this.dataDemissao &&
          other.deletado == this.deletado);
}

class ColaboradorsCompanion extends UpdateCompanion<Colaborador> {
  final Value<int?> codigo;
  final Value<int?> codigoEstadoCivil;
  final Value<int?> codigoSexo;
  final Value<String?> matricula;
  final Value<String?> nome;
  final Value<String?> email;
  final Value<String?> celular;
  final Value<String?> telefone;
  final Value<DateTime?> dataAdmissao;
  final Value<DateTime?> dataDemissao;
  final Value<String?> deletado;
  const ColaboradorsCompanion({
    this.codigo = const Value.absent(),
    this.codigoEstadoCivil = const Value.absent(),
    this.codigoSexo = const Value.absent(),
    this.matricula = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.celular = const Value.absent(),
    this.telefone = const Value.absent(),
    this.dataAdmissao = const Value.absent(),
    this.dataDemissao = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  ColaboradorsCompanion.insert({
    this.codigo = const Value.absent(),
    this.codigoEstadoCivil = const Value.absent(),
    this.codigoSexo = const Value.absent(),
    this.matricula = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.celular = const Value.absent(),
    this.telefone = const Value.absent(),
    this.dataAdmissao = const Value.absent(),
    this.dataDemissao = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<Colaborador> custom({
    Expression<int?>? codigo,
    Expression<int?>? codigoEstadoCivil,
    Expression<int?>? codigoSexo,
    Expression<String?>? matricula,
    Expression<String?>? nome,
    Expression<String?>? email,
    Expression<String?>? celular,
    Expression<String?>? telefone,
    Expression<DateTime?>? dataAdmissao,
    Expression<DateTime?>? dataDemissao,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (codigoEstadoCivil != null) 'codigo_estado_civil': codigoEstadoCivil,
      if (codigoSexo != null) 'codigo_sexo': codigoSexo,
      if (matricula != null) 'matricula': matricula,
      if (nome != null) 'nome': nome,
      if (email != null) 'email': email,
      if (celular != null) 'celular': celular,
      if (telefone != null) 'telefone': telefone,
      if (dataAdmissao != null) 'data_admissao': dataAdmissao,
      if (dataDemissao != null) 'data_demissao': dataDemissao,
      if (deletado != null) 'deletado': deletado,
    });
  }

  ColaboradorsCompanion copyWith(
      {Value<int?>? codigo,
      Value<int?>? codigoEstadoCivil,
      Value<int?>? codigoSexo,
      Value<String?>? matricula,
      Value<String?>? nome,
      Value<String?>? email,
      Value<String?>? celular,
      Value<String?>? telefone,
      Value<DateTime?>? dataAdmissao,
      Value<DateTime?>? dataDemissao,
      Value<String?>? deletado}) {
    return ColaboradorsCompanion(
      codigo: codigo ?? this.codigo,
      codigoEstadoCivil: codigoEstadoCivil ?? this.codigoEstadoCivil,
      codigoSexo: codigoSexo ?? this.codigoSexo,
      matricula: matricula ?? this.matricula,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      celular: celular ?? this.celular,
      telefone: telefone ?? this.telefone,
      dataAdmissao: dataAdmissao ?? this.dataAdmissao,
      dataDemissao: dataDemissao ?? this.dataDemissao,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (codigoEstadoCivil.present) {
      map['codigo_estado_civil'] = Variable<int?>(codigoEstadoCivil.value);
    }
    if (codigoSexo.present) {
      map['codigo_sexo'] = Variable<int?>(codigoSexo.value);
    }
    if (matricula.present) {
      map['matricula'] = Variable<String?>(matricula.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (email.present) {
      map['email'] = Variable<String?>(email.value);
    }
    if (celular.present) {
      map['celular'] = Variable<String?>(celular.value);
    }
    if (telefone.present) {
      map['telefone'] = Variable<String?>(telefone.value);
    }
    if (dataAdmissao.present) {
      map['data_admissao'] = Variable<DateTime?>(dataAdmissao.value);
    }
    if (dataDemissao.present) {
      map['data_demissao'] = Variable<DateTime?>(dataDemissao.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ColaboradorsCompanion(')
          ..write('codigo: $codigo, ')
          ..write('codigoEstadoCivil: $codigoEstadoCivil, ')
          ..write('codigoSexo: $codigoSexo, ')
          ..write('matricula: $matricula, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('celular: $celular, ')
          ..write('telefone: $telefone, ')
          ..write('dataAdmissao: $dataAdmissao, ')
          ..write('dataDemissao: $dataDemissao, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $ColaboradorsTable extends Colaboradors
    with TableInfo<$ColaboradorsTable, Colaborador> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ColaboradorsTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codigoEstadoCivilMeta =
      const VerificationMeta('codigoEstadoCivil');
  @override
  late final GeneratedColumn<int?> codigoEstadoCivil = GeneratedColumn<int?>(
      'codigo_estado_civil', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_estado_civil(codigo)');
  final VerificationMeta _codigoSexoMeta = const VerificationMeta('codigoSexo');
  @override
  late final GeneratedColumn<int?> codigoSexo = GeneratedColumn<int?>(
      'codigo_sexo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_sexo(codigo)');
  final VerificationMeta _matriculaMeta = const VerificationMeta('matricula');
  @override
  late final GeneratedColumn<String?> matricula = GeneratedColumn<String?>(
      'matricula', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 20),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 5, maxTextLength: 180),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 254),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _celularMeta = const VerificationMeta('celular');
  @override
  late final GeneratedColumn<String?> celular = GeneratedColumn<String?>(
      'celular', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 15),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _telefoneMeta = const VerificationMeta('telefone');
  @override
  late final GeneratedColumn<String?> telefone = GeneratedColumn<String?>(
      'telefone', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 15),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _dataAdmissaoMeta =
      const VerificationMeta('dataAdmissao');
  @override
  late final GeneratedColumn<DateTime?> dataAdmissao =
      GeneratedColumn<DateTime?>('data_admissao', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _dataDemissaoMeta =
      const VerificationMeta('dataDemissao');
  @override
  late final GeneratedColumn<DateTime?> dataDemissao =
      GeneratedColumn<DateTime?>('data_demissao', aliasedName, true,
          type: const IntType(), requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns => [
        codigo,
        codigoEstadoCivil,
        codigoSexo,
        matricula,
        nome,
        email,
        celular,
        telefone,
        dataAdmissao,
        dataDemissao,
        deletado
      ];
  @override
  String get aliasedName => _alias ?? 'tb_colaborador';
  @override
  String get actualTableName => 'tb_colaborador';
  @override
  VerificationContext validateIntegrity(Insertable<Colaborador> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('codigo_estado_civil')) {
      context.handle(
          _codigoEstadoCivilMeta,
          codigoEstadoCivil.isAcceptableOrUnknown(
              data['codigo_estado_civil']!, _codigoEstadoCivilMeta));
    }
    if (data.containsKey('codigo_sexo')) {
      context.handle(
          _codigoSexoMeta,
          codigoSexo.isAcceptableOrUnknown(
              data['codigo_sexo']!, _codigoSexoMeta));
    }
    if (data.containsKey('matricula')) {
      context.handle(_matriculaMeta,
          matricula.isAcceptableOrUnknown(data['matricula']!, _matriculaMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    }
    if (data.containsKey('celular')) {
      context.handle(_celularMeta,
          celular.isAcceptableOrUnknown(data['celular']!, _celularMeta));
    }
    if (data.containsKey('telefone')) {
      context.handle(_telefoneMeta,
          telefone.isAcceptableOrUnknown(data['telefone']!, _telefoneMeta));
    }
    if (data.containsKey('data_admissao')) {
      context.handle(
          _dataAdmissaoMeta,
          dataAdmissao.isAcceptableOrUnknown(
              data['data_admissao']!, _dataAdmissaoMeta));
    }
    if (data.containsKey('data_demissao')) {
      context.handle(
          _dataDemissaoMeta,
          dataDemissao.isAcceptableOrUnknown(
              data['data_demissao']!, _dataDemissaoMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  Colaborador map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Colaborador.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ColaboradorsTable createAlias(String alias) {
    return $ColaboradorsTable(attachedDatabase, alias);
  }
}

class Funcao extends DataClass implements Insertable<Funcao> {
  final int? codigo;
  final String? nome;
  final String? cbo;
  final String? descricao;
  final String? deletado;
  Funcao({this.codigo, this.nome, this.cbo, this.descricao, this.deletado});
  factory Funcao.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Funcao(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome']),
      cbo: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}cbo']),
      descricao: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}descricao']),
      deletado: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}deletado']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || nome != null) {
      map['nome'] = Variable<String?>(nome);
    }
    if (!nullToAbsent || cbo != null) {
      map['cbo'] = Variable<String?>(cbo);
    }
    if (!nullToAbsent || descricao != null) {
      map['descricao'] = Variable<String?>(descricao);
    }
    if (!nullToAbsent || deletado != null) {
      map['deletado'] = Variable<String?>(deletado);
    }
    return map;
  }

  FuncaosCompanion toCompanion(bool nullToAbsent) {
    return FuncaosCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      nome: nome == null && nullToAbsent ? const Value.absent() : Value(nome),
      cbo: cbo == null && nullToAbsent ? const Value.absent() : Value(cbo),
      descricao: descricao == null && nullToAbsent
          ? const Value.absent()
          : Value(descricao),
      deletado: deletado == null && nullToAbsent
          ? const Value.absent()
          : Value(deletado),
    );
  }

  factory Funcao.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Funcao(
      codigo: serializer.fromJson<int?>(json['codigo']),
      nome: serializer.fromJson<String?>(json['nome']),
      cbo: serializer.fromJson<String?>(json['cbo']),
      descricao: serializer.fromJson<String?>(json['descricao']),
      deletado: serializer.fromJson<String?>(json['deletado']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'nome': serializer.toJson<String?>(nome),
      'cbo': serializer.toJson<String?>(cbo),
      'descricao': serializer.toJson<String?>(descricao),
      'deletado': serializer.toJson<String?>(deletado),
    };
  }

  Funcao copyWith(
          {int? codigo,
          String? nome,
          String? cbo,
          String? descricao,
          String? deletado}) =>
      Funcao(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
        cbo: cbo ?? this.cbo,
        descricao: descricao ?? this.descricao,
        deletado: deletado ?? this.deletado,
      );
  @override
  String toString() {
    return (StringBuffer('Funcao(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('cbo: $cbo, ')
          ..write('descricao: $descricao, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome, cbo, descricao, deletado);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Funcao &&
          other.codigo == this.codigo &&
          other.nome == this.nome &&
          other.cbo == this.cbo &&
          other.descricao == this.descricao &&
          other.deletado == this.deletado);
}

class FuncaosCompanion extends UpdateCompanion<Funcao> {
  final Value<int?> codigo;
  final Value<String?> nome;
  final Value<String?> cbo;
  final Value<String?> descricao;
  final Value<String?> deletado;
  const FuncaosCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.cbo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  FuncaosCompanion.insert({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
    this.cbo = const Value.absent(),
    this.descricao = const Value.absent(),
    this.deletado = const Value.absent(),
  });
  static Insertable<Funcao> custom({
    Expression<int?>? codigo,
    Expression<String?>? nome,
    Expression<String?>? cbo,
    Expression<String?>? descricao,
    Expression<String?>? deletado,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
      if (cbo != null) 'cbo': cbo,
      if (descricao != null) 'descricao': descricao,
      if (deletado != null) 'deletado': deletado,
    });
  }

  FuncaosCompanion copyWith(
      {Value<int?>? codigo,
      Value<String?>? nome,
      Value<String?>? cbo,
      Value<String?>? descricao,
      Value<String?>? deletado}) {
    return FuncaosCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
      cbo: cbo ?? this.cbo,
      descricao: descricao ?? this.descricao,
      deletado: deletado ?? this.deletado,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String?>(nome.value);
    }
    if (cbo.present) {
      map['cbo'] = Variable<String?>(cbo.value);
    }
    if (descricao.present) {
      map['descricao'] = Variable<String?>(descricao.value);
    }
    if (deletado.present) {
      map['deletado'] = Variable<String?>(deletado.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FuncaosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome, ')
          ..write('cbo: $cbo, ')
          ..write('descricao: $descricao, ')
          ..write('deletado: $deletado')
          ..write(')'))
        .toString();
  }
}

class $FuncaosTable extends Funcaos with TableInfo<$FuncaosTable, Funcao> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FuncaosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 3, maxTextLength: 180),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _cboMeta = const VerificationMeta('cbo');
  @override
  late final GeneratedColumn<String?> cbo = GeneratedColumn<String?>(
      'cbo', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 15),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _descricaoMeta = const VerificationMeta('descricao');
  @override
  late final GeneratedColumn<String?> descricao = GeneratedColumn<String?>(
      'descricao', aliasedName, true,
      additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 450),
      type: const StringType(),
      requiredDuringInsert: false);
  final VerificationMeta _deletadoMeta = const VerificationMeta('deletado');
  @override
  late final GeneratedColumn<String?> deletado = GeneratedColumn<String?>(
      'deletado', aliasedName, true,
      additionalChecks:
          GeneratedColumn.checkTextLength(minTextLength: 1, maxTextLength: 1),
      type: const StringType(),
      requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [codigo, nome, cbo, descricao, deletado];
  @override
  String get aliasedName => _alias ?? 'tb_funcao';
  @override
  String get actualTableName => 'tb_funcao';
  @override
  VerificationContext validateIntegrity(Insertable<Funcao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    }
    if (data.containsKey('cbo')) {
      context.handle(
          _cboMeta, cbo.isAcceptableOrUnknown(data['cbo']!, _cboMeta));
    }
    if (data.containsKey('descricao')) {
      context.handle(_descricaoMeta,
          descricao.isAcceptableOrUnknown(data['descricao']!, _descricaoMeta));
    }
    if (data.containsKey('deletado')) {
      context.handle(_deletadoMeta,
          deletado.isAcceptableOrUnknown(data['deletado']!, _deletadoMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  Funcao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return Funcao.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $FuncaosTable createAlias(String alias) {
    return $FuncaosTable(attachedDatabase, alias);
  }
}

class ColaboradorFuncao extends DataClass
    implements Insertable<ColaboradorFuncao> {
  final int? codigo;
  final int? codigoColaborador;
  final int? codigoFuncao;
  final int? percentual;
  ColaboradorFuncao(
      {this.codigo,
      this.codigoColaborador,
      this.codigoFuncao,
      this.percentual});
  factory ColaboradorFuncao.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return ColaboradorFuncao(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo']),
      codigoColaborador: const IntType().mapFromDatabaseResponse(
          data['${effectivePrefix}codigo_colaborador']),
      codigoFuncao: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_funcao']),
      percentual: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}percentual']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (!nullToAbsent || codigo != null) {
      map['codigo'] = Variable<int?>(codigo);
    }
    if (!nullToAbsent || codigoColaborador != null) {
      map['codigo_colaborador'] = Variable<int?>(codigoColaborador);
    }
    if (!nullToAbsent || codigoFuncao != null) {
      map['codigo_funcao'] = Variable<int?>(codigoFuncao);
    }
    if (!nullToAbsent || percentual != null) {
      map['percentual'] = Variable<int?>(percentual);
    }
    return map;
  }

  ColaboradorFuncaosCompanion toCompanion(bool nullToAbsent) {
    return ColaboradorFuncaosCompanion(
      codigo:
          codigo == null && nullToAbsent ? const Value.absent() : Value(codigo),
      codigoColaborador: codigoColaborador == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoColaborador),
      codigoFuncao: codigoFuncao == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoFuncao),
      percentual: percentual == null && nullToAbsent
          ? const Value.absent()
          : Value(percentual),
    );
  }

  factory ColaboradorFuncao.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ColaboradorFuncao(
      codigo: serializer.fromJson<int?>(json['codigo']),
      codigoColaborador: serializer.fromJson<int?>(json['codigoColaborador']),
      codigoFuncao: serializer.fromJson<int?>(json['codigoFuncao']),
      percentual: serializer.fromJson<int?>(json['percentual']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int?>(codigo),
      'codigoColaborador': serializer.toJson<int?>(codigoColaborador),
      'codigoFuncao': serializer.toJson<int?>(codigoFuncao),
      'percentual': serializer.toJson<int?>(percentual),
    };
  }

  ColaboradorFuncao copyWith(
          {int? codigo,
          int? codigoColaborador,
          int? codigoFuncao,
          int? percentual}) =>
      ColaboradorFuncao(
        codigo: codigo ?? this.codigo,
        codigoColaborador: codigoColaborador ?? this.codigoColaborador,
        codigoFuncao: codigoFuncao ?? this.codigoFuncao,
        percentual: percentual ?? this.percentual,
      );
  @override
  String toString() {
    return (StringBuffer('ColaboradorFuncao(')
          ..write('codigo: $codigo, ')
          ..write('codigoColaborador: $codigoColaborador, ')
          ..write('codigoFuncao: $codigoFuncao, ')
          ..write('percentual: $percentual')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(codigo, codigoColaborador, codigoFuncao, percentual);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ColaboradorFuncao &&
          other.codigo == this.codigo &&
          other.codigoColaborador == this.codigoColaborador &&
          other.codigoFuncao == this.codigoFuncao &&
          other.percentual == this.percentual);
}

class ColaboradorFuncaosCompanion extends UpdateCompanion<ColaboradorFuncao> {
  final Value<int?> codigo;
  final Value<int?> codigoColaborador;
  final Value<int?> codigoFuncao;
  final Value<int?> percentual;
  const ColaboradorFuncaosCompanion({
    this.codigo = const Value.absent(),
    this.codigoColaborador = const Value.absent(),
    this.codigoFuncao = const Value.absent(),
    this.percentual = const Value.absent(),
  });
  ColaboradorFuncaosCompanion.insert({
    this.codigo = const Value.absent(),
    this.codigoColaborador = const Value.absent(),
    this.codigoFuncao = const Value.absent(),
    this.percentual = const Value.absent(),
  });
  static Insertable<ColaboradorFuncao> custom({
    Expression<int?>? codigo,
    Expression<int?>? codigoColaborador,
    Expression<int?>? codigoFuncao,
    Expression<int?>? percentual,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (codigoColaborador != null) 'codigo_colaborador': codigoColaborador,
      if (codigoFuncao != null) 'codigo_funcao': codigoFuncao,
      if (percentual != null) 'percentual': percentual,
    });
  }

  ColaboradorFuncaosCompanion copyWith(
      {Value<int?>? codigo,
      Value<int?>? codigoColaborador,
      Value<int?>? codigoFuncao,
      Value<int?>? percentual}) {
    return ColaboradorFuncaosCompanion(
      codigo: codigo ?? this.codigo,
      codigoColaborador: codigoColaborador ?? this.codigoColaborador,
      codigoFuncao: codigoFuncao ?? this.codigoFuncao,
      percentual: percentual ?? this.percentual,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int?>(codigo.value);
    }
    if (codigoColaborador.present) {
      map['codigo_colaborador'] = Variable<int?>(codigoColaborador.value);
    }
    if (codigoFuncao.present) {
      map['codigo_funcao'] = Variable<int?>(codigoFuncao.value);
    }
    if (percentual.present) {
      map['percentual'] = Variable<int?>(percentual.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ColaboradorFuncaosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('codigoColaborador: $codigoColaborador, ')
          ..write('codigoFuncao: $codigoFuncao, ')
          ..write('percentual: $percentual')
          ..write(')'))
        .toString();
  }
}

class $ColaboradorFuncaosTable extends ColaboradorFuncaos
    with TableInfo<$ColaboradorFuncaosTable, ColaboradorFuncao> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ColaboradorFuncaosTable(this.attachedDatabase, [this._alias]);
  final VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<int?> codigo = GeneratedColumn<int?>(
      'codigo', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codigoColaboradorMeta =
      const VerificationMeta('codigoColaborador');
  @override
  late final GeneratedColumn<int?> codigoColaborador = GeneratedColumn<int?>(
      'codigo_colaborador', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_colaborador(codigo)');
  final VerificationMeta _codigoFuncaoMeta =
      const VerificationMeta('codigoFuncao');
  @override
  late final GeneratedColumn<int?> codigoFuncao = GeneratedColumn<int?>(
      'codigo_funcao', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NULLABLE REFERENCES tb_funcao(codigo)');
  final VerificationMeta _percentualMeta = const VerificationMeta('percentual');
  @override
  late final GeneratedColumn<int?> percentual = GeneratedColumn<int?>(
      'percentual', aliasedName, true,
      type: const IntType(), requiredDuringInsert: false);
  @override
  List<GeneratedColumn> get $columns =>
      [codigo, codigoColaborador, codigoFuncao, percentual];
  @override
  String get aliasedName => _alias ?? 'tb_colaborador_funcao';
  @override
  String get actualTableName => 'tb_colaborador_funcao';
  @override
  VerificationContext validateIntegrity(Insertable<ColaboradorFuncao> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('codigo')) {
      context.handle(_codigoMeta,
          codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta));
    }
    if (data.containsKey('codigo_colaborador')) {
      context.handle(
          _codigoColaboradorMeta,
          codigoColaborador.isAcceptableOrUnknown(
              data['codigo_colaborador']!, _codigoColaboradorMeta));
    }
    if (data.containsKey('codigo_funcao')) {
      context.handle(
          _codigoFuncaoMeta,
          codigoFuncao.isAcceptableOrUnknown(
              data['codigo_funcao']!, _codigoFuncaoMeta));
    }
    if (data.containsKey('percentual')) {
      context.handle(
          _percentualMeta,
          percentual.isAcceptableOrUnknown(
              data['percentual']!, _percentualMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {codigo};
  @override
  ColaboradorFuncao map(Map<String, dynamic> data, {String? tablePrefix}) {
    return ColaboradorFuncao.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  $ColaboradorFuncaosTable createAlias(String alias) {
    return $ColaboradorFuncaosTable(attachedDatabase, alias);
  }
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $OrdemServicosTable ordemServicos = $OrdemServicosTable(this);
  late final $LocalsTable locals = $LocalsTable(this);
  late final $LocalSubsTable localSubs = $LocalSubsTable(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $StatusOrdemServicosTable statusOrdemServicos =
      $StatusOrdemServicosTable(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final $PermissaosTable permissaos = $PermissaosTable(this);
  late final $UsuarioPermissaosTable usuarioPermissaos =
      $UsuarioPermissaosTable(this);
  late final $SexosTable sexos = $SexosTable(this);
  late final $EstadoCivilsTable estadoCivils = $EstadoCivilsTable(this);
  late final $ColaboradorsTable colaboradors = $ColaboradorsTable(this);
  late final $FuncaosTable funcaos = $FuncaosTable(this);
  late final $ColaboradorFuncaosTable colaboradorFuncaos =
      $ColaboradorFuncaosTable(this);
  late final OrdemServicoDao ordemServicoDao = OrdemServicoDao(this as AppDb);
  late final LocalDao localDao = LocalDao(this as AppDb);
  late final LocalSubDao localSubDao = LocalSubDao(this as AppDb);
  late final CategoriaDao categoriaDao = CategoriaDao(this as AppDb);
  late final StatusOrdemServicoDao statusOrdemServicoDao =
      StatusOrdemServicoDao(this as AppDb);
  late final UsuarioDao usuarioDao = UsuarioDao(this as AppDb);
  late final PermissaoDao permissaoDao = PermissaoDao(this as AppDb);
  late final UsuarioPermissaoDao usuarioPermissaoDao =
      UsuarioPermissaoDao(this as AppDb);
  late final SexoDao sexoDao = SexoDao(this as AppDb);
  late final EstadoCivilDao estadoCivilDao = EstadoCivilDao(this as AppDb);
  late final FuncaoDao funcaoDao = FuncaoDao(this as AppDb);
  late final ColaboradorDao colaboradorDao = ColaboradorDao(this as AppDb);
  late final ColaboradorFuncaoDao colaboradorFuncaoDao =
      ColaboradorFuncaoDao(this as AppDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
        ordemServicos,
        locals,
        localSubs,
        categorias,
        statusOrdemServicos,
        usuarios,
        permissaos,
        usuarioPermissaos,
        sexos,
        estadoCivils,
        colaboradors,
        funcaos,
        colaboradorFuncaos
      ];
}
