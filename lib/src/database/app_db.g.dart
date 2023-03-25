// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_db.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class OrdemServico extends DataClass implements Insertable<OrdemServico> {
  final int codigo;
  final String codigoUsuario;
  final int? codigoCategoria;
  final int? codigoLocal;
  final int? codigoStatus;
  final String? descricaoProblema;
  final String? descricaoSolucao;
  final DateTime? dataAbertura;
  final DateTime? dataEncerramento;
  OrdemServico(
      {required this.codigo,
      required this.codigoUsuario,
      this.codigoCategoria,
      this.codigoLocal,
      this.codigoStatus,
      this.descricaoProblema,
      this.descricaoSolucao,
      this.dataAbertura,
      this.dataEncerramento});
  factory OrdemServico.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return OrdemServico(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo'])!,
      codigoUsuario: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_usuario'])!,
      codigoCategoria: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_categoria']),
      codigoLocal: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo_local']),
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
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['codigo'] = Variable<int>(codigo);
    map['codigo_usuario'] = Variable<String>(codigoUsuario);
    if (!nullToAbsent || codigoCategoria != null) {
      map['codigo_categoria'] = Variable<int?>(codigoCategoria);
    }
    if (!nullToAbsent || codigoLocal != null) {
      map['codigo_local'] = Variable<int?>(codigoLocal);
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
    return map;
  }

  OrdemServicosCompanion toCompanion(bool nullToAbsent) {
    return OrdemServicosCompanion(
      codigo: Value(codigo),
      codigoUsuario: Value(codigoUsuario),
      codigoCategoria: codigoCategoria == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoCategoria),
      codigoLocal: codigoLocal == null && nullToAbsent
          ? const Value.absent()
          : Value(codigoLocal),
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
    );
  }

  factory OrdemServico.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return OrdemServico(
      codigo: serializer.fromJson<int>(json['codigo']),
      codigoUsuario: serializer.fromJson<String>(json['codigoUsuario']),
      codigoCategoria: serializer.fromJson<int?>(json['codigoCategoria']),
      codigoLocal: serializer.fromJson<int?>(json['codigoLocal']),
      codigoStatus: serializer.fromJson<int?>(json['codigoStatus']),
      descricaoProblema:
          serializer.fromJson<String?>(json['descricaoProblema']),
      descricaoSolucao: serializer.fromJson<String?>(json['descricaoSolucao']),
      dataAbertura: serializer.fromJson<DateTime?>(json['dataAbertura']),
      dataEncerramento:
          serializer.fromJson<DateTime?>(json['dataEncerramento']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int>(codigo),
      'codigoUsuario': serializer.toJson<String>(codigoUsuario),
      'codigoCategoria': serializer.toJson<int?>(codigoCategoria),
      'codigoLocal': serializer.toJson<int?>(codigoLocal),
      'codigoStatus': serializer.toJson<int?>(codigoStatus),
      'descricaoProblema': serializer.toJson<String?>(descricaoProblema),
      'descricaoSolucao': serializer.toJson<String?>(descricaoSolucao),
      'dataAbertura': serializer.toJson<DateTime?>(dataAbertura),
      'dataEncerramento': serializer.toJson<DateTime?>(dataEncerramento),
    };
  }

  OrdemServico copyWith(
          {int? codigo,
          String? codigoUsuario,
          int? codigoCategoria,
          int? codigoLocal,
          int? codigoStatus,
          String? descricaoProblema,
          String? descricaoSolucao,
          DateTime? dataAbertura,
          DateTime? dataEncerramento}) =>
      OrdemServico(
        codigo: codigo ?? this.codigo,
        codigoUsuario: codigoUsuario ?? this.codigoUsuario,
        codigoCategoria: codigoCategoria ?? this.codigoCategoria,
        codigoLocal: codigoLocal ?? this.codigoLocal,
        codigoStatus: codigoStatus ?? this.codigoStatus,
        descricaoProblema: descricaoProblema ?? this.descricaoProblema,
        descricaoSolucao: descricaoSolucao ?? this.descricaoSolucao,
        dataAbertura: dataAbertura ?? this.dataAbertura,
        dataEncerramento: dataEncerramento ?? this.dataEncerramento,
      );
  @override
  String toString() {
    return (StringBuffer('OrdemServico(')
          ..write('codigo: $codigo, ')
          ..write('codigoUsuario: $codigoUsuario, ')
          ..write('codigoCategoria: $codigoCategoria, ')
          ..write('codigoLocal: $codigoLocal, ')
          ..write('codigoStatus: $codigoStatus, ')
          ..write('descricaoProblema: $descricaoProblema, ')
          ..write('descricaoSolucao: $descricaoSolucao, ')
          ..write('dataAbertura: $dataAbertura, ')
          ..write('dataEncerramento: $dataEncerramento')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
      codigo,
      codigoUsuario,
      codigoCategoria,
      codigoLocal,
      codigoStatus,
      descricaoProblema,
      descricaoSolucao,
      dataAbertura,
      dataEncerramento);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is OrdemServico &&
          other.codigo == this.codigo &&
          other.codigoUsuario == this.codigoUsuario &&
          other.codigoCategoria == this.codigoCategoria &&
          other.codigoLocal == this.codigoLocal &&
          other.codigoStatus == this.codigoStatus &&
          other.descricaoProblema == this.descricaoProblema &&
          other.descricaoSolucao == this.descricaoSolucao &&
          other.dataAbertura == this.dataAbertura &&
          other.dataEncerramento == this.dataEncerramento);
}

class OrdemServicosCompanion extends UpdateCompanion<OrdemServico> {
  final Value<int> codigo;
  final Value<String> codigoUsuario;
  final Value<int?> codigoCategoria;
  final Value<int?> codigoLocal;
  final Value<int?> codigoStatus;
  final Value<String?> descricaoProblema;
  final Value<String?> descricaoSolucao;
  final Value<DateTime?> dataAbertura;
  final Value<DateTime?> dataEncerramento;
  const OrdemServicosCompanion({
    this.codigo = const Value.absent(),
    this.codigoUsuario = const Value.absent(),
    this.codigoCategoria = const Value.absent(),
    this.codigoLocal = const Value.absent(),
    this.codigoStatus = const Value.absent(),
    this.descricaoProblema = const Value.absent(),
    this.descricaoSolucao = const Value.absent(),
    this.dataAbertura = const Value.absent(),
    this.dataEncerramento = const Value.absent(),
  });
  OrdemServicosCompanion.insert({
    this.codigo = const Value.absent(),
    required String codigoUsuario,
    this.codigoCategoria = const Value.absent(),
    this.codigoLocal = const Value.absent(),
    this.codigoStatus = const Value.absent(),
    this.descricaoProblema = const Value.absent(),
    this.descricaoSolucao = const Value.absent(),
    this.dataAbertura = const Value.absent(),
    this.dataEncerramento = const Value.absent(),
  }) : codigoUsuario = Value(codigoUsuario);
  static Insertable<OrdemServico> custom({
    Expression<int>? codigo,
    Expression<String>? codigoUsuario,
    Expression<int?>? codigoCategoria,
    Expression<int?>? codigoLocal,
    Expression<int?>? codigoStatus,
    Expression<String?>? descricaoProblema,
    Expression<String?>? descricaoSolucao,
    Expression<DateTime?>? dataAbertura,
    Expression<DateTime?>? dataEncerramento,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (codigoUsuario != null) 'codigo_usuario': codigoUsuario,
      if (codigoCategoria != null) 'codigo_categoria': codigoCategoria,
      if (codigoLocal != null) 'codigo_local': codigoLocal,
      if (codigoStatus != null) 'codigo_status': codigoStatus,
      if (descricaoProblema != null) 'descricao_problema': descricaoProblema,
      if (descricaoSolucao != null) 'descricao_solucao': descricaoSolucao,
      if (dataAbertura != null) 'data_abertura': dataAbertura,
      if (dataEncerramento != null) 'data_encerramento': dataEncerramento,
    });
  }

  OrdemServicosCompanion copyWith(
      {Value<int>? codigo,
      Value<String>? codigoUsuario,
      Value<int?>? codigoCategoria,
      Value<int?>? codigoLocal,
      Value<int?>? codigoStatus,
      Value<String?>? descricaoProblema,
      Value<String?>? descricaoSolucao,
      Value<DateTime?>? dataAbertura,
      Value<DateTime?>? dataEncerramento}) {
    return OrdemServicosCompanion(
      codigo: codigo ?? this.codigo,
      codigoUsuario: codigoUsuario ?? this.codigoUsuario,
      codigoCategoria: codigoCategoria ?? this.codigoCategoria,
      codigoLocal: codigoLocal ?? this.codigoLocal,
      codigoStatus: codigoStatus ?? this.codigoStatus,
      descricaoProblema: descricaoProblema ?? this.descricaoProblema,
      descricaoSolucao: descricaoSolucao ?? this.descricaoSolucao,
      dataAbertura: dataAbertura ?? this.dataAbertura,
      dataEncerramento: dataEncerramento ?? this.dataEncerramento,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int>(codigo.value);
    }
    if (codigoUsuario.present) {
      map['codigo_usuario'] = Variable<String>(codigoUsuario.value);
    }
    if (codigoCategoria.present) {
      map['codigo_categoria'] = Variable<int?>(codigoCategoria.value);
    }
    if (codigoLocal.present) {
      map['codigo_local'] = Variable<int?>(codigoLocal.value);
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
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdemServicosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('codigoUsuario: $codigoUsuario, ')
          ..write('codigoCategoria: $codigoCategoria, ')
          ..write('codigoLocal: $codigoLocal, ')
          ..write('codigoStatus: $codigoStatus, ')
          ..write('descricaoProblema: $descricaoProblema, ')
          ..write('descricaoSolucao: $descricaoSolucao, ')
          ..write('dataAbertura: $dataAbertura, ')
          ..write('dataEncerramento: $dataEncerramento')
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
      'codigo', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _codigoUsuarioMeta =
      const VerificationMeta('codigoUsuario');
  @override
  late final GeneratedColumn<String?> codigoUsuario = GeneratedColumn<String?>(
      'codigo_usuario', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
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
          type: const StringType(), requiredDuringInsert: false);
  final VerificationMeta _descricaoSolucaoMeta =
      const VerificationMeta('descricaoSolucao');
  @override
  late final GeneratedColumn<String?> descricaoSolucao =
      GeneratedColumn<String?>('descricao_solucao', aliasedName, true,
          type: const StringType(), requiredDuringInsert: false);
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
  @override
  List<GeneratedColumn> get $columns => [
        codigo,
        codigoUsuario,
        codigoCategoria,
        codigoLocal,
        codigoStatus,
        descricaoProblema,
        descricaoSolucao,
        dataAbertura,
        dataEncerramento
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
    } else if (isInserting) {
      context.missing(_codigoUsuarioMeta);
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
  final int codigo;
  final String nome;
  Local({required this.codigo, required this.nome});
  factory Local.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Local(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo'])!,
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['codigo'] = Variable<int>(codigo);
    map['nome'] = Variable<String>(nome);
    return map;
  }

  LocalsCompanion toCompanion(bool nullToAbsent) {
    return LocalsCompanion(
      codigo: Value(codigo),
      nome: Value(nome),
    );
  }

  factory Local.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Local(
      codigo: serializer.fromJson<int>(json['codigo']),
      nome: serializer.fromJson<String>(json['nome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int>(codigo),
      'nome': serializer.toJson<String>(nome),
    };
  }

  Local copyWith({int? codigo, String? nome}) => Local(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
      );
  @override
  String toString() {
    return (StringBuffer('Local(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Local &&
          other.codigo == this.codigo &&
          other.nome == this.nome);
}

class LocalsCompanion extends UpdateCompanion<Local> {
  final Value<int> codigo;
  final Value<String> nome;
  const LocalsCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
  });
  LocalsCompanion.insert({
    this.codigo = const Value.absent(),
    required String nome,
  }) : nome = Value(nome);
  static Insertable<Local> custom({
    Expression<int>? codigo,
    Expression<String>? nome,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
    });
  }

  LocalsCompanion copyWith({Value<int>? codigo, Value<String>? nome}) {
    return LocalsCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LocalsCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome')
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
      'codigo', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [codigo, nome];
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
    } else if (isInserting) {
      context.missing(_nomeMeta);
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

class Categoria extends DataClass implements Insertable<Categoria> {
  final int codigo;
  final String nome;
  Categoria({required this.codigo, required this.nome});
  factory Categoria.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Categoria(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo'])!,
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['codigo'] = Variable<int>(codigo);
    map['nome'] = Variable<String>(nome);
    return map;
  }

  CategoriasCompanion toCompanion(bool nullToAbsent) {
    return CategoriasCompanion(
      codigo: Value(codigo),
      nome: Value(nome),
    );
  }

  factory Categoria.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Categoria(
      codigo: serializer.fromJson<int>(json['codigo']),
      nome: serializer.fromJson<String>(json['nome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int>(codigo),
      'nome': serializer.toJson<String>(nome),
    };
  }

  Categoria copyWith({int? codigo, String? nome}) => Categoria(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
      );
  @override
  String toString() {
    return (StringBuffer('Categoria(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Categoria &&
          other.codigo == this.codigo &&
          other.nome == this.nome);
}

class CategoriasCompanion extends UpdateCompanion<Categoria> {
  final Value<int> codigo;
  final Value<String> nome;
  const CategoriasCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
  });
  CategoriasCompanion.insert({
    this.codigo = const Value.absent(),
    required String nome,
  }) : nome = Value(nome);
  static Insertable<Categoria> custom({
    Expression<int>? codigo,
    Expression<String>? nome,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
    });
  }

  CategoriasCompanion copyWith({Value<int>? codigo, Value<String>? nome}) {
    return CategoriasCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriasCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome')
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
      'codigo', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [codigo, nome];
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
    } else if (isInserting) {
      context.missing(_nomeMeta);
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
  final int codigo;
  final String nome;
  StatusOrdemServico({required this.codigo, required this.nome});
  factory StatusOrdemServico.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return StatusOrdemServico(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo'])!,
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['codigo'] = Variable<int>(codigo);
    map['nome'] = Variable<String>(nome);
    return map;
  }

  StatusOrdemServicosCompanion toCompanion(bool nullToAbsent) {
    return StatusOrdemServicosCompanion(
      codigo: Value(codigo),
      nome: Value(nome),
    );
  }

  factory StatusOrdemServico.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return StatusOrdemServico(
      codigo: serializer.fromJson<int>(json['codigo']),
      nome: serializer.fromJson<String>(json['nome']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int>(codigo),
      'nome': serializer.toJson<String>(nome),
    };
  }

  StatusOrdemServico copyWith({int? codigo, String? nome}) =>
      StatusOrdemServico(
        codigo: codigo ?? this.codigo,
        nome: nome ?? this.nome,
      );
  @override
  String toString() {
    return (StringBuffer('StatusOrdemServico(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(codigo, nome);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StatusOrdemServico &&
          other.codigo == this.codigo &&
          other.nome == this.nome);
}

class StatusOrdemServicosCompanion extends UpdateCompanion<StatusOrdemServico> {
  final Value<int> codigo;
  final Value<String> nome;
  const StatusOrdemServicosCompanion({
    this.codigo = const Value.absent(),
    this.nome = const Value.absent(),
  });
  StatusOrdemServicosCompanion.insert({
    this.codigo = const Value.absent(),
    required String nome,
  }) : nome = Value(nome);
  static Insertable<StatusOrdemServico> custom({
    Expression<int>? codigo,
    Expression<String>? nome,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (nome != null) 'nome': nome,
    });
  }

  StatusOrdemServicosCompanion copyWith(
      {Value<int>? codigo, Value<String>? nome}) {
    return StatusOrdemServicosCompanion(
      codigo: codigo ?? this.codigo,
      nome: nome ?? this.nome,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int>(codigo.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('StatusOrdemServicosCompanion(')
          ..write('codigo: $codigo, ')
          ..write('nome: $nome')
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
      'codigo', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [codigo, nome];
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
    } else if (isInserting) {
      context.missing(_nomeMeta);
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
  final int codigo;
  final String matricula;
  final String senha;
  final String nome;
  final String email;
  final String celular;
  Usuario(
      {required this.codigo,
      required this.matricula,
      required this.senha,
      required this.nome,
      required this.email,
      required this.celular});
  factory Usuario.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return Usuario(
      codigo: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}codigo'])!,
      matricula: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}matricula'])!,
      senha: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}senha'])!,
      nome: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}nome'])!,
      email: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}email'])!,
      celular: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}celular'])!,
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['codigo'] = Variable<int>(codigo);
    map['matricula'] = Variable<String>(matricula);
    map['senha'] = Variable<String>(senha);
    map['nome'] = Variable<String>(nome);
    map['email'] = Variable<String>(email);
    map['celular'] = Variable<String>(celular);
    return map;
  }

  UsuariosCompanion toCompanion(bool nullToAbsent) {
    return UsuariosCompanion(
      codigo: Value(codigo),
      matricula: Value(matricula),
      senha: Value(senha),
      nome: Value(nome),
      email: Value(email),
      celular: Value(celular),
    );
  }

  factory Usuario.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Usuario(
      codigo: serializer.fromJson<int>(json['codigo']),
      matricula: serializer.fromJson<String>(json['matricula']),
      senha: serializer.fromJson<String>(json['senha']),
      nome: serializer.fromJson<String>(json['nome']),
      email: serializer.fromJson<String>(json['email']),
      celular: serializer.fromJson<String>(json['celular']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'codigo': serializer.toJson<int>(codigo),
      'matricula': serializer.toJson<String>(matricula),
      'senha': serializer.toJson<String>(senha),
      'nome': serializer.toJson<String>(nome),
      'email': serializer.toJson<String>(email),
      'celular': serializer.toJson<String>(celular),
    };
  }

  Usuario copyWith(
          {int? codigo,
          String? matricula,
          String? senha,
          String? nome,
          String? email,
          String? celular}) =>
      Usuario(
        codigo: codigo ?? this.codigo,
        matricula: matricula ?? this.matricula,
        senha: senha ?? this.senha,
        nome: nome ?? this.nome,
        email: email ?? this.email,
        celular: celular ?? this.celular,
      );
  @override
  String toString() {
    return (StringBuffer('Usuario(')
          ..write('codigo: $codigo, ')
          ..write('matricula: $matricula, ')
          ..write('senha: $senha, ')
          ..write('nome: $nome, ')
          ..write('email: $email, ')
          ..write('celular: $celular')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(codigo, matricula, senha, nome, email, celular);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Usuario &&
          other.codigo == this.codigo &&
          other.matricula == this.matricula &&
          other.senha == this.senha &&
          other.nome == this.nome &&
          other.email == this.email &&
          other.celular == this.celular);
}

class UsuariosCompanion extends UpdateCompanion<Usuario> {
  final Value<int> codigo;
  final Value<String> matricula;
  final Value<String> senha;
  final Value<String> nome;
  final Value<String> email;
  final Value<String> celular;
  const UsuariosCompanion({
    this.codigo = const Value.absent(),
    this.matricula = const Value.absent(),
    this.senha = const Value.absent(),
    this.nome = const Value.absent(),
    this.email = const Value.absent(),
    this.celular = const Value.absent(),
  });
  UsuariosCompanion.insert({
    this.codigo = const Value.absent(),
    required String matricula,
    required String senha,
    required String nome,
    required String email,
    required String celular,
  })  : matricula = Value(matricula),
        senha = Value(senha),
        nome = Value(nome),
        email = Value(email),
        celular = Value(celular);
  static Insertable<Usuario> custom({
    Expression<int>? codigo,
    Expression<String>? matricula,
    Expression<String>? senha,
    Expression<String>? nome,
    Expression<String>? email,
    Expression<String>? celular,
  }) {
    return RawValuesInsertable({
      if (codigo != null) 'codigo': codigo,
      if (matricula != null) 'matricula': matricula,
      if (senha != null) 'senha': senha,
      if (nome != null) 'nome': nome,
      if (email != null) 'email': email,
      if (celular != null) 'celular': celular,
    });
  }

  UsuariosCompanion copyWith(
      {Value<int>? codigo,
      Value<String>? matricula,
      Value<String>? senha,
      Value<String>? nome,
      Value<String>? email,
      Value<String>? celular}) {
    return UsuariosCompanion(
      codigo: codigo ?? this.codigo,
      matricula: matricula ?? this.matricula,
      senha: senha ?? this.senha,
      nome: nome ?? this.nome,
      email: email ?? this.email,
      celular: celular ?? this.celular,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (codigo.present) {
      map['codigo'] = Variable<int>(codigo.value);
    }
    if (matricula.present) {
      map['matricula'] = Variable<String>(matricula.value);
    }
    if (senha.present) {
      map['senha'] = Variable<String>(senha.value);
    }
    if (nome.present) {
      map['nome'] = Variable<String>(nome.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (celular.present) {
      map['celular'] = Variable<String>(celular.value);
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
          ..write('celular: $celular')
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
      'codigo', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      defaultConstraints: 'PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _matriculaMeta = const VerificationMeta('matricula');
  @override
  late final GeneratedColumn<String?> matricula = GeneratedColumn<String?>(
      'matricula', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _senhaMeta = const VerificationMeta('senha');
  @override
  late final GeneratedColumn<String?> senha = GeneratedColumn<String?>(
      'senha', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _nomeMeta = const VerificationMeta('nome');
  @override
  late final GeneratedColumn<String?> nome = GeneratedColumn<String?>(
      'nome', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String?> email = GeneratedColumn<String?>(
      'email', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  final VerificationMeta _celularMeta = const VerificationMeta('celular');
  @override
  late final GeneratedColumn<String?> celular = GeneratedColumn<String?>(
      'celular', aliasedName, false,
      type: const StringType(), requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns =>
      [codigo, matricula, senha, nome, email, celular];
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
    } else if (isInserting) {
      context.missing(_matriculaMeta);
    }
    if (data.containsKey('senha')) {
      context.handle(
          _senhaMeta, senha.isAcceptableOrUnknown(data['senha']!, _senhaMeta));
    } else if (isInserting) {
      context.missing(_senhaMeta);
    }
    if (data.containsKey('nome')) {
      context.handle(
          _nomeMeta, nome.isAcceptableOrUnknown(data['nome']!, _nomeMeta));
    } else if (isInserting) {
      context.missing(_nomeMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
          _emailMeta, email.isAcceptableOrUnknown(data['email']!, _emailMeta));
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('celular')) {
      context.handle(_celularMeta,
          celular.isAcceptableOrUnknown(data['celular']!, _celularMeta));
    } else if (isInserting) {
      context.missing(_celularMeta);
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

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final $OrdemServicosTable ordemServicos = $OrdemServicosTable(this);
  late final $LocalsTable locals = $LocalsTable(this);
  late final $CategoriasTable categorias = $CategoriasTable(this);
  late final $StatusOrdemServicosTable statusOrdemServicos =
      $StatusOrdemServicosTable(this);
  late final $UsuariosTable usuarios = $UsuariosTable(this);
  late final OrdemServicoDao ordemServicoDao = OrdemServicoDao(this as AppDb);
  late final LocalDao localDao = LocalDao(this as AppDb);
  late final CategoriaDao categoriaDao = CategoriaDao(this as AppDb);
  late final StatusOrdemServicoDao statusOrdemServicoDao =
      StatusOrdemServicoDao(this as AppDb);
  late final UsuarioDao usuarioDao = UsuarioDao(this as AppDb);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [ordemServicos, locals, categorias, statusOrdemServicos, usuarios];
}
