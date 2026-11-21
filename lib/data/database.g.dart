// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $ClientesTable extends Clientes with TableInfo<$ClientesTable, Cliente> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ClientesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _telefonoMeta = const VerificationMeta(
    'telefono',
  );
  @override
  late final GeneratedColumn<String> telefono = GeneratedColumn<String>(
    'telefono',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre, telefono];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'clientes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Cliente> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('telefono')) {
      context.handle(
        _telefonoMeta,
        telefono.isAcceptableOrUnknown(data['telefono']!, _telefonoMeta),
      );
    } else if (isInserting) {
      context.missing(_telefonoMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Cliente map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Cliente(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      telefono: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}telefono'],
      )!,
    );
  }

  @override
  $ClientesTable createAlias(String alias) {
    return $ClientesTable(attachedDatabase, alias);
  }
}

class Cliente extends DataClass implements Insertable<Cliente> {
  final int id;
  final String nombre;
  final String telefono;
  const Cliente({
    required this.id,
    required this.nombre,
    required this.telefono,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['telefono'] = Variable<String>(telefono);
    return map;
  }

  ClientesCompanion toCompanion(bool nullToAbsent) {
    return ClientesCompanion(
      id: Value(id),
      nombre: Value(nombre),
      telefono: Value(telefono),
    );
  }

  factory Cliente.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Cliente(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      telefono: serializer.fromJson<String>(json['telefono']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'telefono': serializer.toJson<String>(telefono),
    };
  }

  Cliente copyWith({int? id, String? nombre, String? telefono}) => Cliente(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    telefono: telefono ?? this.telefono,
  );
  Cliente copyWithCompanion(ClientesCompanion data) {
    return Cliente(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      telefono: data.telefono.present ? data.telefono.value : this.telefono,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Cliente(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, telefono);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Cliente &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.telefono == this.telefono);
}

class ClientesCompanion extends UpdateCompanion<Cliente> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> telefono;
  const ClientesCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.telefono = const Value.absent(),
  });
  ClientesCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String telefono,
  }) : nombre = Value(nombre),
       telefono = Value(telefono);
  static Insertable<Cliente> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? telefono,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (telefono != null) 'telefono': telefono,
    });
  }

  ClientesCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? telefono,
  }) {
    return ClientesCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      telefono: telefono ?? this.telefono,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (telefono.present) {
      map['telefono'] = Variable<String>(telefono.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ClientesCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('telefono: $telefono')
          ..write(')'))
        .toString();
  }
}

class $TecnicosTable extends Tecnicos with TableInfo<$TecnicosTable, Tecnico> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TecnicosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, nombre];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'tecnicos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Tecnico> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Tecnico map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Tecnico(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
    );
  }

  @override
  $TecnicosTable createAlias(String alias) {
    return $TecnicosTable(attachedDatabase, alias);
  }
}

class Tecnico extends DataClass implements Insertable<Tecnico> {
  final int id;
  final String nombre;
  const Tecnico({required this.id, required this.nombre});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    return map;
  }

  TecnicosCompanion toCompanion(bool nullToAbsent) {
    return TecnicosCompanion(id: Value(id), nombre: Value(nombre));
  }

  factory Tecnico.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Tecnico(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
    };
  }

  Tecnico copyWith({int? id, String? nombre}) =>
      Tecnico(id: id ?? this.id, nombre: nombre ?? this.nombre);
  Tecnico copyWithCompanion(TecnicosCompanion data) {
    return Tecnico(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Tecnico(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Tecnico && other.id == this.id && other.nombre == this.nombre);
}

class TecnicosCompanion extends UpdateCompanion<Tecnico> {
  final Value<int> id;
  final Value<String> nombre;
  const TecnicosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
  });
  TecnicosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
  }) : nombre = Value(nombre);
  static Insertable<Tecnico> custom({
    Expression<int>? id,
    Expression<String>? nombre,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
    });
  }

  TecnicosCompanion copyWith({Value<int>? id, Value<String>? nombre}) {
    return TecnicosCompanion(id: id ?? this.id, nombre: nombre ?? this.nombre);
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TecnicosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre')
          ..write(')'))
        .toString();
  }
}

class $EquiposTable extends Equipos with TableInfo<$EquiposTable, Equipo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EquiposTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _clienteIdMeta = const VerificationMeta(
    'clienteId',
  );
  @override
  late final GeneratedColumn<int> clienteId = GeneratedColumn<int>(
    'cliente_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES clientes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _tipoMeta = const VerificationMeta('tipo');
  @override
  late final GeneratedColumn<String> tipo = GeneratedColumn<String>(
    'tipo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _marcaMeta = const VerificationMeta('marca');
  @override
  late final GeneratedColumn<String> marca = GeneratedColumn<String>(
    'marca',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modeloMeta = const VerificationMeta('modelo');
  @override
  late final GeneratedColumn<String> modelo = GeneratedColumn<String>(
    'modelo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _numeroSerieMeta = const VerificationMeta(
    'numeroSerie',
  );
  @override
  late final GeneratedColumn<String> numeroSerie = GeneratedColumn<String>(
    'numero_serie',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    clienteId,
    tipo,
    marca,
    modelo,
    numeroSerie,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'equipos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Equipo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('cliente_id')) {
      context.handle(
        _clienteIdMeta,
        clienteId.isAcceptableOrUnknown(data['cliente_id']!, _clienteIdMeta),
      );
    } else if (isInserting) {
      context.missing(_clienteIdMeta);
    }
    if (data.containsKey('tipo')) {
      context.handle(
        _tipoMeta,
        tipo.isAcceptableOrUnknown(data['tipo']!, _tipoMeta),
      );
    } else if (isInserting) {
      context.missing(_tipoMeta);
    }
    if (data.containsKey('marca')) {
      context.handle(
        _marcaMeta,
        marca.isAcceptableOrUnknown(data['marca']!, _marcaMeta),
      );
    } else if (isInserting) {
      context.missing(_marcaMeta);
    }
    if (data.containsKey('modelo')) {
      context.handle(
        _modeloMeta,
        modelo.isAcceptableOrUnknown(data['modelo']!, _modeloMeta),
      );
    } else if (isInserting) {
      context.missing(_modeloMeta);
    }
    if (data.containsKey('numero_serie')) {
      context.handle(
        _numeroSerieMeta,
        numeroSerie.isAcceptableOrUnknown(
          data['numero_serie']!,
          _numeroSerieMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Equipo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Equipo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      clienteId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cliente_id'],
      )!,
      tipo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}tipo'],
      )!,
      marca: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}marca'],
      )!,
      modelo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}modelo'],
      )!,
      numeroSerie: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}numero_serie'],
      ),
    );
  }

  @override
  $EquiposTable createAlias(String alias) {
    return $EquiposTable(attachedDatabase, alias);
  }
}

class Equipo extends DataClass implements Insertable<Equipo> {
  final int id;
  final int clienteId;
  final String tipo;
  final String marca;
  final String modelo;
  final String? numeroSerie;
  const Equipo({
    required this.id,
    required this.clienteId,
    required this.tipo,
    required this.marca,
    required this.modelo,
    this.numeroSerie,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['cliente_id'] = Variable<int>(clienteId);
    map['tipo'] = Variable<String>(tipo);
    map['marca'] = Variable<String>(marca);
    map['modelo'] = Variable<String>(modelo);
    if (!nullToAbsent || numeroSerie != null) {
      map['numero_serie'] = Variable<String>(numeroSerie);
    }
    return map;
  }

  EquiposCompanion toCompanion(bool nullToAbsent) {
    return EquiposCompanion(
      id: Value(id),
      clienteId: Value(clienteId),
      tipo: Value(tipo),
      marca: Value(marca),
      modelo: Value(modelo),
      numeroSerie: numeroSerie == null && nullToAbsent
          ? const Value.absent()
          : Value(numeroSerie),
    );
  }

  factory Equipo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Equipo(
      id: serializer.fromJson<int>(json['id']),
      clienteId: serializer.fromJson<int>(json['clienteId']),
      tipo: serializer.fromJson<String>(json['tipo']),
      marca: serializer.fromJson<String>(json['marca']),
      modelo: serializer.fromJson<String>(json['modelo']),
      numeroSerie: serializer.fromJson<String?>(json['numeroSerie']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'clienteId': serializer.toJson<int>(clienteId),
      'tipo': serializer.toJson<String>(tipo),
      'marca': serializer.toJson<String>(marca),
      'modelo': serializer.toJson<String>(modelo),
      'numeroSerie': serializer.toJson<String?>(numeroSerie),
    };
  }

  Equipo copyWith({
    int? id,
    int? clienteId,
    String? tipo,
    String? marca,
    String? modelo,
    Value<String?> numeroSerie = const Value.absent(),
  }) => Equipo(
    id: id ?? this.id,
    clienteId: clienteId ?? this.clienteId,
    tipo: tipo ?? this.tipo,
    marca: marca ?? this.marca,
    modelo: modelo ?? this.modelo,
    numeroSerie: numeroSerie.present ? numeroSerie.value : this.numeroSerie,
  );
  Equipo copyWithCompanion(EquiposCompanion data) {
    return Equipo(
      id: data.id.present ? data.id.value : this.id,
      clienteId: data.clienteId.present ? data.clienteId.value : this.clienteId,
      tipo: data.tipo.present ? data.tipo.value : this.tipo,
      marca: data.marca.present ? data.marca.value : this.marca,
      modelo: data.modelo.present ? data.modelo.value : this.modelo,
      numeroSerie: data.numeroSerie.present
          ? data.numeroSerie.value
          : this.numeroSerie,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Equipo(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('numeroSerie: $numeroSerie')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, clienteId, tipo, marca, modelo, numeroSerie);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Equipo &&
          other.id == this.id &&
          other.clienteId == this.clienteId &&
          other.tipo == this.tipo &&
          other.marca == this.marca &&
          other.modelo == this.modelo &&
          other.numeroSerie == this.numeroSerie);
}

class EquiposCompanion extends UpdateCompanion<Equipo> {
  final Value<int> id;
  final Value<int> clienteId;
  final Value<String> tipo;
  final Value<String> marca;
  final Value<String> modelo;
  final Value<String?> numeroSerie;
  const EquiposCompanion({
    this.id = const Value.absent(),
    this.clienteId = const Value.absent(),
    this.tipo = const Value.absent(),
    this.marca = const Value.absent(),
    this.modelo = const Value.absent(),
    this.numeroSerie = const Value.absent(),
  });
  EquiposCompanion.insert({
    this.id = const Value.absent(),
    required int clienteId,
    required String tipo,
    required String marca,
    required String modelo,
    this.numeroSerie = const Value.absent(),
  }) : clienteId = Value(clienteId),
       tipo = Value(tipo),
       marca = Value(marca),
       modelo = Value(modelo);
  static Insertable<Equipo> custom({
    Expression<int>? id,
    Expression<int>? clienteId,
    Expression<String>? tipo,
    Expression<String>? marca,
    Expression<String>? modelo,
    Expression<String>? numeroSerie,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (clienteId != null) 'cliente_id': clienteId,
      if (tipo != null) 'tipo': tipo,
      if (marca != null) 'marca': marca,
      if (modelo != null) 'modelo': modelo,
      if (numeroSerie != null) 'numero_serie': numeroSerie,
    });
  }

  EquiposCompanion copyWith({
    Value<int>? id,
    Value<int>? clienteId,
    Value<String>? tipo,
    Value<String>? marca,
    Value<String>? modelo,
    Value<String?>? numeroSerie,
  }) {
    return EquiposCompanion(
      id: id ?? this.id,
      clienteId: clienteId ?? this.clienteId,
      tipo: tipo ?? this.tipo,
      marca: marca ?? this.marca,
      modelo: modelo ?? this.modelo,
      numeroSerie: numeroSerie ?? this.numeroSerie,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (clienteId.present) {
      map['cliente_id'] = Variable<int>(clienteId.value);
    }
    if (tipo.present) {
      map['tipo'] = Variable<String>(tipo.value);
    }
    if (marca.present) {
      map['marca'] = Variable<String>(marca.value);
    }
    if (modelo.present) {
      map['modelo'] = Variable<String>(modelo.value);
    }
    if (numeroSerie.present) {
      map['numero_serie'] = Variable<String>(numeroSerie.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EquiposCompanion(')
          ..write('id: $id, ')
          ..write('clienteId: $clienteId, ')
          ..write('tipo: $tipo, ')
          ..write('marca: $marca, ')
          ..write('modelo: $modelo, ')
          ..write('numeroSerie: $numeroSerie')
          ..write(')'))
        .toString();
  }
}

class $OrdenesTable extends Ordenes with TableInfo<$OrdenesTable, Orden> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $OrdenesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _equipoIdMeta = const VerificationMeta(
    'equipoId',
  );
  @override
  late final GeneratedColumn<int> equipoId = GeneratedColumn<int>(
    'equipo_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES equipos (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _fallaReportadaMeta = const VerificationMeta(
    'fallaReportada',
  );
  @override
  late final GeneratedColumn<String> fallaReportada = GeneratedColumn<String>(
    'falla_reportada',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _estadoMeta = const VerificationMeta('estado');
  @override
  late final GeneratedColumn<String> estado = GeneratedColumn<String>(
    'estado',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('recibida'),
  );
  static const VerificationMeta _tecnicoResponsableIdMeta =
      const VerificationMeta('tecnicoResponsableId');
  @override
  late final GeneratedColumn<int> tecnicoResponsableId = GeneratedColumn<int>(
    'tecnico_responsable_id',
    aliasedName,
    true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES tecnicos (id) ON DELETE SET NULL',
    ),
  );
  static const VerificationMeta _fechaRecepcionMeta = const VerificationMeta(
    'fechaRecepcion',
  );
  @override
  late final GeneratedColumn<DateTime> fechaRecepcion =
      GeneratedColumn<DateTime>(
        'fecha_recepcion',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
        defaultValue: currentDateAndTime,
      );
  static const VerificationMeta _fechaCierreMeta = const VerificationMeta(
    'fechaCierre',
  );
  @override
  late final GeneratedColumn<DateTime> fechaCierre = GeneratedColumn<DateTime>(
    'fecha_cierre',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _notasMeta = const VerificationMeta('notas');
  @override
  late final GeneratedColumn<String> notas = GeneratedColumn<String>(
    'notas',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    equipoId,
    fallaReportada,
    estado,
    tecnicoResponsableId,
    fechaRecepcion,
    fechaCierre,
    notas,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'ordenes';
  @override
  VerificationContext validateIntegrity(
    Insertable<Orden> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('equipo_id')) {
      context.handle(
        _equipoIdMeta,
        equipoId.isAcceptableOrUnknown(data['equipo_id']!, _equipoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_equipoIdMeta);
    }
    if (data.containsKey('falla_reportada')) {
      context.handle(
        _fallaReportadaMeta,
        fallaReportada.isAcceptableOrUnknown(
          data['falla_reportada']!,
          _fallaReportadaMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_fallaReportadaMeta);
    }
    if (data.containsKey('estado')) {
      context.handle(
        _estadoMeta,
        estado.isAcceptableOrUnknown(data['estado']!, _estadoMeta),
      );
    }
    if (data.containsKey('tecnico_responsable_id')) {
      context.handle(
        _tecnicoResponsableIdMeta,
        tecnicoResponsableId.isAcceptableOrUnknown(
          data['tecnico_responsable_id']!,
          _tecnicoResponsableIdMeta,
        ),
      );
    }
    if (data.containsKey('fecha_recepcion')) {
      context.handle(
        _fechaRecepcionMeta,
        fechaRecepcion.isAcceptableOrUnknown(
          data['fecha_recepcion']!,
          _fechaRecepcionMeta,
        ),
      );
    }
    if (data.containsKey('fecha_cierre')) {
      context.handle(
        _fechaCierreMeta,
        fechaCierre.isAcceptableOrUnknown(
          data['fecha_cierre']!,
          _fechaCierreMeta,
        ),
      );
    }
    if (data.containsKey('notas')) {
      context.handle(
        _notasMeta,
        notas.isAcceptableOrUnknown(data['notas']!, _notasMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Orden map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Orden(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      equipoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}equipo_id'],
      )!,
      fallaReportada: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}falla_reportada'],
      )!,
      estado: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}estado'],
      )!,
      tecnicoResponsableId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}tecnico_responsable_id'],
      ),
      fechaRecepcion: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_recepcion'],
      )!,
      fechaCierre: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}fecha_cierre'],
      ),
      notas: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notas'],
      ),
    );
  }

  @override
  $OrdenesTable createAlias(String alias) {
    return $OrdenesTable(attachedDatabase, alias);
  }
}

class Orden extends DataClass implements Insertable<Orden> {
  final int id;
  final int equipoId;
  final String fallaReportada;
  final String estado;
  final int? tecnicoResponsableId;
  final DateTime fechaRecepcion;
  final DateTime? fechaCierre;
  final String? notas;
  const Orden({
    required this.id,
    required this.equipoId,
    required this.fallaReportada,
    required this.estado,
    this.tecnicoResponsableId,
    required this.fechaRecepcion,
    this.fechaCierre,
    this.notas,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['equipo_id'] = Variable<int>(equipoId);
    map['falla_reportada'] = Variable<String>(fallaReportada);
    map['estado'] = Variable<String>(estado);
    if (!nullToAbsent || tecnicoResponsableId != null) {
      map['tecnico_responsable_id'] = Variable<int>(tecnicoResponsableId);
    }
    map['fecha_recepcion'] = Variable<DateTime>(fechaRecepcion);
    if (!nullToAbsent || fechaCierre != null) {
      map['fecha_cierre'] = Variable<DateTime>(fechaCierre);
    }
    if (!nullToAbsent || notas != null) {
      map['notas'] = Variable<String>(notas);
    }
    return map;
  }

  OrdenesCompanion toCompanion(bool nullToAbsent) {
    return OrdenesCompanion(
      id: Value(id),
      equipoId: Value(equipoId),
      fallaReportada: Value(fallaReportada),
      estado: Value(estado),
      tecnicoResponsableId: tecnicoResponsableId == null && nullToAbsent
          ? const Value.absent()
          : Value(tecnicoResponsableId),
      fechaRecepcion: Value(fechaRecepcion),
      fechaCierre: fechaCierre == null && nullToAbsent
          ? const Value.absent()
          : Value(fechaCierre),
      notas: notas == null && nullToAbsent
          ? const Value.absent()
          : Value(notas),
    );
  }

  factory Orden.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Orden(
      id: serializer.fromJson<int>(json['id']),
      equipoId: serializer.fromJson<int>(json['equipoId']),
      fallaReportada: serializer.fromJson<String>(json['fallaReportada']),
      estado: serializer.fromJson<String>(json['estado']),
      tecnicoResponsableId: serializer.fromJson<int?>(
        json['tecnicoResponsableId'],
      ),
      fechaRecepcion: serializer.fromJson<DateTime>(json['fechaRecepcion']),
      fechaCierre: serializer.fromJson<DateTime?>(json['fechaCierre']),
      notas: serializer.fromJson<String?>(json['notas']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'equipoId': serializer.toJson<int>(equipoId),
      'fallaReportada': serializer.toJson<String>(fallaReportada),
      'estado': serializer.toJson<String>(estado),
      'tecnicoResponsableId': serializer.toJson<int?>(tecnicoResponsableId),
      'fechaRecepcion': serializer.toJson<DateTime>(fechaRecepcion),
      'fechaCierre': serializer.toJson<DateTime?>(fechaCierre),
      'notas': serializer.toJson<String?>(notas),
    };
  }

  Orden copyWith({
    int? id,
    int? equipoId,
    String? fallaReportada,
    String? estado,
    Value<int?> tecnicoResponsableId = const Value.absent(),
    DateTime? fechaRecepcion,
    Value<DateTime?> fechaCierre = const Value.absent(),
    Value<String?> notas = const Value.absent(),
  }) => Orden(
    id: id ?? this.id,
    equipoId: equipoId ?? this.equipoId,
    fallaReportada: fallaReportada ?? this.fallaReportada,
    estado: estado ?? this.estado,
    tecnicoResponsableId: tecnicoResponsableId.present
        ? tecnicoResponsableId.value
        : this.tecnicoResponsableId,
    fechaRecepcion: fechaRecepcion ?? this.fechaRecepcion,
    fechaCierre: fechaCierre.present ? fechaCierre.value : this.fechaCierre,
    notas: notas.present ? notas.value : this.notas,
  );
  Orden copyWithCompanion(OrdenesCompanion data) {
    return Orden(
      id: data.id.present ? data.id.value : this.id,
      equipoId: data.equipoId.present ? data.equipoId.value : this.equipoId,
      fallaReportada: data.fallaReportada.present
          ? data.fallaReportada.value
          : this.fallaReportada,
      estado: data.estado.present ? data.estado.value : this.estado,
      tecnicoResponsableId: data.tecnicoResponsableId.present
          ? data.tecnicoResponsableId.value
          : this.tecnicoResponsableId,
      fechaRecepcion: data.fechaRecepcion.present
          ? data.fechaRecepcion.value
          : this.fechaRecepcion,
      fechaCierre: data.fechaCierre.present
          ? data.fechaCierre.value
          : this.fechaCierre,
      notas: data.notas.present ? data.notas.value : this.notas,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Orden(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('fallaReportada: $fallaReportada, ')
          ..write('estado: $estado, ')
          ..write('tecnicoResponsableId: $tecnicoResponsableId, ')
          ..write('fechaRecepcion: $fechaRecepcion, ')
          ..write('fechaCierre: $fechaCierre, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    equipoId,
    fallaReportada,
    estado,
    tecnicoResponsableId,
    fechaRecepcion,
    fechaCierre,
    notas,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Orden &&
          other.id == this.id &&
          other.equipoId == this.equipoId &&
          other.fallaReportada == this.fallaReportada &&
          other.estado == this.estado &&
          other.tecnicoResponsableId == this.tecnicoResponsableId &&
          other.fechaRecepcion == this.fechaRecepcion &&
          other.fechaCierre == this.fechaCierre &&
          other.notas == this.notas);
}

class OrdenesCompanion extends UpdateCompanion<Orden> {
  final Value<int> id;
  final Value<int> equipoId;
  final Value<String> fallaReportada;
  final Value<String> estado;
  final Value<int?> tecnicoResponsableId;
  final Value<DateTime> fechaRecepcion;
  final Value<DateTime?> fechaCierre;
  final Value<String?> notas;
  const OrdenesCompanion({
    this.id = const Value.absent(),
    this.equipoId = const Value.absent(),
    this.fallaReportada = const Value.absent(),
    this.estado = const Value.absent(),
    this.tecnicoResponsableId = const Value.absent(),
    this.fechaRecepcion = const Value.absent(),
    this.fechaCierre = const Value.absent(),
    this.notas = const Value.absent(),
  });
  OrdenesCompanion.insert({
    this.id = const Value.absent(),
    required int equipoId,
    required String fallaReportada,
    this.estado = const Value.absent(),
    this.tecnicoResponsableId = const Value.absent(),
    this.fechaRecepcion = const Value.absent(),
    this.fechaCierre = const Value.absent(),
    this.notas = const Value.absent(),
  }) : equipoId = Value(equipoId),
       fallaReportada = Value(fallaReportada);
  static Insertable<Orden> custom({
    Expression<int>? id,
    Expression<int>? equipoId,
    Expression<String>? fallaReportada,
    Expression<String>? estado,
    Expression<int>? tecnicoResponsableId,
    Expression<DateTime>? fechaRecepcion,
    Expression<DateTime>? fechaCierre,
    Expression<String>? notas,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (equipoId != null) 'equipo_id': equipoId,
      if (fallaReportada != null) 'falla_reportada': fallaReportada,
      if (estado != null) 'estado': estado,
      if (tecnicoResponsableId != null)
        'tecnico_responsable_id': tecnicoResponsableId,
      if (fechaRecepcion != null) 'fecha_recepcion': fechaRecepcion,
      if (fechaCierre != null) 'fecha_cierre': fechaCierre,
      if (notas != null) 'notas': notas,
    });
  }

  OrdenesCompanion copyWith({
    Value<int>? id,
    Value<int>? equipoId,
    Value<String>? fallaReportada,
    Value<String>? estado,
    Value<int?>? tecnicoResponsableId,
    Value<DateTime>? fechaRecepcion,
    Value<DateTime?>? fechaCierre,
    Value<String?>? notas,
  }) {
    return OrdenesCompanion(
      id: id ?? this.id,
      equipoId: equipoId ?? this.equipoId,
      fallaReportada: fallaReportada ?? this.fallaReportada,
      estado: estado ?? this.estado,
      tecnicoResponsableId: tecnicoResponsableId ?? this.tecnicoResponsableId,
      fechaRecepcion: fechaRecepcion ?? this.fechaRecepcion,
      fechaCierre: fechaCierre ?? this.fechaCierre,
      notas: notas ?? this.notas,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (equipoId.present) {
      map['equipo_id'] = Variable<int>(equipoId.value);
    }
    if (fallaReportada.present) {
      map['falla_reportada'] = Variable<String>(fallaReportada.value);
    }
    if (estado.present) {
      map['estado'] = Variable<String>(estado.value);
    }
    if (tecnicoResponsableId.present) {
      map['tecnico_responsable_id'] = Variable<int>(tecnicoResponsableId.value);
    }
    if (fechaRecepcion.present) {
      map['fecha_recepcion'] = Variable<DateTime>(fechaRecepcion.value);
    }
    if (fechaCierre.present) {
      map['fecha_cierre'] = Variable<DateTime>(fechaCierre.value);
    }
    if (notas.present) {
      map['notas'] = Variable<String>(notas.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('OrdenesCompanion(')
          ..write('id: $id, ')
          ..write('equipoId: $equipoId, ')
          ..write('fallaReportada: $fallaReportada, ')
          ..write('estado: $estado, ')
          ..write('tecnicoResponsableId: $tecnicoResponsableId, ')
          ..write('fechaRecepcion: $fechaRecepcion, ')
          ..write('fechaCierre: $fechaCierre, ')
          ..write('notas: $notas')
          ..write(')'))
        .toString();
  }
}

class $TrabajosTable extends Trabajos with TableInfo<$TrabajosTable, Trabajo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $TrabajosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ordenIdMeta = const VerificationMeta(
    'ordenId',
  );
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
    'orden_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ordenes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _descripcionMeta = const VerificationMeta(
    'descripcion',
  );
  @override
  late final GeneratedColumn<String> descripcion = GeneratedColumn<String>(
    'descripcion',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _costoManoObraMeta = const VerificationMeta(
    'costoManoObra',
  );
  @override
  late final GeneratedColumn<double> costoManoObra = GeneratedColumn<double>(
    'costo_mano_obra',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ordenId,
    descripcion,
    costoManoObra,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'trabajos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Trabajo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(
        _ordenIdMeta,
        ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('descripcion')) {
      context.handle(
        _descripcionMeta,
        descripcion.isAcceptableOrUnknown(
          data['descripcion']!,
          _descripcionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descripcionMeta);
    }
    if (data.containsKey('costo_mano_obra')) {
      context.handle(
        _costoManoObraMeta,
        costoManoObra.isAcceptableOrUnknown(
          data['costo_mano_obra']!,
          _costoManoObraMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_costoManoObraMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Trabajo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Trabajo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ordenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden_id'],
      )!,
      descripcion: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}descripcion'],
      )!,
      costoManoObra: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}costo_mano_obra'],
      )!,
    );
  }

  @override
  $TrabajosTable createAlias(String alias) {
    return $TrabajosTable(attachedDatabase, alias);
  }
}

class Trabajo extends DataClass implements Insertable<Trabajo> {
  final int id;
  final int ordenId;
  final String descripcion;
  final double costoManoObra;
  const Trabajo({
    required this.id,
    required this.ordenId,
    required this.descripcion,
    required this.costoManoObra,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['descripcion'] = Variable<String>(descripcion);
    map['costo_mano_obra'] = Variable<double>(costoManoObra);
    return map;
  }

  TrabajosCompanion toCompanion(bool nullToAbsent) {
    return TrabajosCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      descripcion: Value(descripcion),
      costoManoObra: Value(costoManoObra),
    );
  }

  factory Trabajo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Trabajo(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      descripcion: serializer.fromJson<String>(json['descripcion']),
      costoManoObra: serializer.fromJson<double>(json['costoManoObra']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'descripcion': serializer.toJson<String>(descripcion),
      'costoManoObra': serializer.toJson<double>(costoManoObra),
    };
  }

  Trabajo copyWith({
    int? id,
    int? ordenId,
    String? descripcion,
    double? costoManoObra,
  }) => Trabajo(
    id: id ?? this.id,
    ordenId: ordenId ?? this.ordenId,
    descripcion: descripcion ?? this.descripcion,
    costoManoObra: costoManoObra ?? this.costoManoObra,
  );
  Trabajo copyWithCompanion(TrabajosCompanion data) {
    return Trabajo(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      descripcion: data.descripcion.present
          ? data.descripcion.value
          : this.descripcion,
      costoManoObra: data.costoManoObra.present
          ? data.costoManoObra.value
          : this.costoManoObra,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Trabajo(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costoManoObra: $costoManoObra')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, ordenId, descripcion, costoManoObra);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Trabajo &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.descripcion == this.descripcion &&
          other.costoManoObra == this.costoManoObra);
}

class TrabajosCompanion extends UpdateCompanion<Trabajo> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<String> descripcion;
  final Value<double> costoManoObra;
  const TrabajosCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.descripcion = const Value.absent(),
    this.costoManoObra = const Value.absent(),
  });
  TrabajosCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required String descripcion,
    required double costoManoObra,
  }) : ordenId = Value(ordenId),
       descripcion = Value(descripcion),
       costoManoObra = Value(costoManoObra);
  static Insertable<Trabajo> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<String>? descripcion,
    Expression<double>? costoManoObra,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (descripcion != null) 'descripcion': descripcion,
      if (costoManoObra != null) 'costo_mano_obra': costoManoObra,
    });
  }

  TrabajosCompanion copyWith({
    Value<int>? id,
    Value<int>? ordenId,
    Value<String>? descripcion,
    Value<double>? costoManoObra,
  }) {
    return TrabajosCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      descripcion: descripcion ?? this.descripcion,
      costoManoObra: costoManoObra ?? this.costoManoObra,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (descripcion.present) {
      map['descripcion'] = Variable<String>(descripcion.value);
    }
    if (costoManoObra.present) {
      map['costo_mano_obra'] = Variable<double>(costoManoObra.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('TrabajosCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('descripcion: $descripcion, ')
          ..write('costoManoObra: $costoManoObra')
          ..write(')'))
        .toString();
  }
}

class $RepuestosTable extends Repuestos
    with TableInfo<$RepuestosTable, Repuesto> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepuestosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _nombreMeta = const VerificationMeta('nombre');
  @override
  late final GeneratedColumn<String> nombre = GeneratedColumn<String>(
    'nombre',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _codigoMeta = const VerificationMeta('codigo');
  @override
  late final GeneratedColumn<String> codigo = GeneratedColumn<String>(
    'codigo',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _precioMeta = const VerificationMeta('precio');
  @override
  late final GeneratedColumn<double> precio = GeneratedColumn<double>(
    'precio',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _existenciasMeta = const VerificationMeta(
    'existencias',
  );
  @override
  late final GeneratedColumn<int> existencias = GeneratedColumn<int>(
    'existencias',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    nombre,
    codigo,
    precio,
    existencias,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repuestos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Repuesto> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('nombre')) {
      context.handle(
        _nombreMeta,
        nombre.isAcceptableOrUnknown(data['nombre']!, _nombreMeta),
      );
    } else if (isInserting) {
      context.missing(_nombreMeta);
    }
    if (data.containsKey('codigo')) {
      context.handle(
        _codigoMeta,
        codigo.isAcceptableOrUnknown(data['codigo']!, _codigoMeta),
      );
    } else if (isInserting) {
      context.missing(_codigoMeta);
    }
    if (data.containsKey('precio')) {
      context.handle(
        _precioMeta,
        precio.isAcceptableOrUnknown(data['precio']!, _precioMeta),
      );
    } else if (isInserting) {
      context.missing(_precioMeta);
    }
    if (data.containsKey('existencias')) {
      context.handle(
        _existenciasMeta,
        existencias.isAcceptableOrUnknown(
          data['existencias']!,
          _existenciasMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_existenciasMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Repuesto map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Repuesto(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      nombre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nombre'],
      )!,
      codigo: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}codigo'],
      )!,
      precio: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio'],
      )!,
      existencias: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}existencias'],
      )!,
    );
  }

  @override
  $RepuestosTable createAlias(String alias) {
    return $RepuestosTable(attachedDatabase, alias);
  }
}

class Repuesto extends DataClass implements Insertable<Repuesto> {
  final int id;
  final String nombre;
  final String codigo;
  final double precio;
  final int existencias;
  const Repuesto({
    required this.id,
    required this.nombre,
    required this.codigo,
    required this.precio,
    required this.existencias,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['nombre'] = Variable<String>(nombre);
    map['codigo'] = Variable<String>(codigo);
    map['precio'] = Variable<double>(precio);
    map['existencias'] = Variable<int>(existencias);
    return map;
  }

  RepuestosCompanion toCompanion(bool nullToAbsent) {
    return RepuestosCompanion(
      id: Value(id),
      nombre: Value(nombre),
      codigo: Value(codigo),
      precio: Value(precio),
      existencias: Value(existencias),
    );
  }

  factory Repuesto.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Repuesto(
      id: serializer.fromJson<int>(json['id']),
      nombre: serializer.fromJson<String>(json['nombre']),
      codigo: serializer.fromJson<String>(json['codigo']),
      precio: serializer.fromJson<double>(json['precio']),
      existencias: serializer.fromJson<int>(json['existencias']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'nombre': serializer.toJson<String>(nombre),
      'codigo': serializer.toJson<String>(codigo),
      'precio': serializer.toJson<double>(precio),
      'existencias': serializer.toJson<int>(existencias),
    };
  }

  Repuesto copyWith({
    int? id,
    String? nombre,
    String? codigo,
    double? precio,
    int? existencias,
  }) => Repuesto(
    id: id ?? this.id,
    nombre: nombre ?? this.nombre,
    codigo: codigo ?? this.codigo,
    precio: precio ?? this.precio,
    existencias: existencias ?? this.existencias,
  );
  Repuesto copyWithCompanion(RepuestosCompanion data) {
    return Repuesto(
      id: data.id.present ? data.id.value : this.id,
      nombre: data.nombre.present ? data.nombre.value : this.nombre,
      codigo: data.codigo.present ? data.codigo.value : this.codigo,
      precio: data.precio.present ? data.precio.value : this.precio,
      existencias: data.existencias.present
          ? data.existencias.value
          : this.existencias,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Repuesto(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precio: $precio, ')
          ..write('existencias: $existencias')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, nombre, codigo, precio, existencias);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Repuesto &&
          other.id == this.id &&
          other.nombre == this.nombre &&
          other.codigo == this.codigo &&
          other.precio == this.precio &&
          other.existencias == this.existencias);
}

class RepuestosCompanion extends UpdateCompanion<Repuesto> {
  final Value<int> id;
  final Value<String> nombre;
  final Value<String> codigo;
  final Value<double> precio;
  final Value<int> existencias;
  const RepuestosCompanion({
    this.id = const Value.absent(),
    this.nombre = const Value.absent(),
    this.codigo = const Value.absent(),
    this.precio = const Value.absent(),
    this.existencias = const Value.absent(),
  });
  RepuestosCompanion.insert({
    this.id = const Value.absent(),
    required String nombre,
    required String codigo,
    required double precio,
    required int existencias,
  }) : nombre = Value(nombre),
       codigo = Value(codigo),
       precio = Value(precio),
       existencias = Value(existencias);
  static Insertable<Repuesto> custom({
    Expression<int>? id,
    Expression<String>? nombre,
    Expression<String>? codigo,
    Expression<double>? precio,
    Expression<int>? existencias,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (nombre != null) 'nombre': nombre,
      if (codigo != null) 'codigo': codigo,
      if (precio != null) 'precio': precio,
      if (existencias != null) 'existencias': existencias,
    });
  }

  RepuestosCompanion copyWith({
    Value<int>? id,
    Value<String>? nombre,
    Value<String>? codigo,
    Value<double>? precio,
    Value<int>? existencias,
  }) {
    return RepuestosCompanion(
      id: id ?? this.id,
      nombre: nombre ?? this.nombre,
      codigo: codigo ?? this.codigo,
      precio: precio ?? this.precio,
      existencias: existencias ?? this.existencias,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (nombre.present) {
      map['nombre'] = Variable<String>(nombre.value);
    }
    if (codigo.present) {
      map['codigo'] = Variable<String>(codigo.value);
    }
    if (precio.present) {
      map['precio'] = Variable<double>(precio.value);
    }
    if (existencias.present) {
      map['existencias'] = Variable<int>(existencias.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosCompanion(')
          ..write('id: $id, ')
          ..write('nombre: $nombre, ')
          ..write('codigo: $codigo, ')
          ..write('precio: $precio, ')
          ..write('existencias: $existencias')
          ..write(')'))
        .toString();
  }
}

class $RepuestosUsadosTable extends RepuestosUsados
    with TableInfo<$RepuestosUsadosTable, RepuestoUsado> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepuestosUsadosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _ordenIdMeta = const VerificationMeta(
    'ordenId',
  );
  @override
  late final GeneratedColumn<int> ordenId = GeneratedColumn<int>(
    'orden_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES ordenes (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _repuestoIdMeta = const VerificationMeta(
    'repuestoId',
  );
  @override
  late final GeneratedColumn<int> repuestoId = GeneratedColumn<int>(
    'repuesto_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repuestos (id) ON DELETE RESTRICT',
    ),
  );
  static const VerificationMeta _cantidadMeta = const VerificationMeta(
    'cantidad',
  );
  @override
  late final GeneratedColumn<int> cantidad = GeneratedColumn<int>(
    'cantidad',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _precioUnitarioMeta = const VerificationMeta(
    'precioUnitario',
  );
  @override
  late final GeneratedColumn<double> precioUnitario = GeneratedColumn<double>(
    'precio_unitario',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    ordenId,
    repuestoId,
    cantidad,
    precioUnitario,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repuestos_usados';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepuestoUsado> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('orden_id')) {
      context.handle(
        _ordenIdMeta,
        ordenId.isAcceptableOrUnknown(data['orden_id']!, _ordenIdMeta),
      );
    } else if (isInserting) {
      context.missing(_ordenIdMeta);
    }
    if (data.containsKey('repuesto_id')) {
      context.handle(
        _repuestoIdMeta,
        repuestoId.isAcceptableOrUnknown(data['repuesto_id']!, _repuestoIdMeta),
      );
    } else if (isInserting) {
      context.missing(_repuestoIdMeta);
    }
    if (data.containsKey('cantidad')) {
      context.handle(
        _cantidadMeta,
        cantidad.isAcceptableOrUnknown(data['cantidad']!, _cantidadMeta),
      );
    } else if (isInserting) {
      context.missing(_cantidadMeta);
    }
    if (data.containsKey('precio_unitario')) {
      context.handle(
        _precioUnitarioMeta,
        precioUnitario.isAcceptableOrUnknown(
          data['precio_unitario']!,
          _precioUnitarioMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_precioUnitarioMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepuestoUsado map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepuestoUsado(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      ordenId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}orden_id'],
      )!,
      repuestoId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repuesto_id'],
      )!,
      cantidad: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}cantidad'],
      )!,
      precioUnitario: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}precio_unitario'],
      )!,
    );
  }

  @override
  $RepuestosUsadosTable createAlias(String alias) {
    return $RepuestosUsadosTable(attachedDatabase, alias);
  }
}

class RepuestoUsado extends DataClass implements Insertable<RepuestoUsado> {
  final int id;
  final int ordenId;
  final int repuestoId;
  final int cantidad;
  final double precioUnitario;
  const RepuestoUsado({
    required this.id,
    required this.ordenId,
    required this.repuestoId,
    required this.cantidad,
    required this.precioUnitario,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['orden_id'] = Variable<int>(ordenId);
    map['repuesto_id'] = Variable<int>(repuestoId);
    map['cantidad'] = Variable<int>(cantidad);
    map['precio_unitario'] = Variable<double>(precioUnitario);
    return map;
  }

  RepuestosUsadosCompanion toCompanion(bool nullToAbsent) {
    return RepuestosUsadosCompanion(
      id: Value(id),
      ordenId: Value(ordenId),
      repuestoId: Value(repuestoId),
      cantidad: Value(cantidad),
      precioUnitario: Value(precioUnitario),
    );
  }

  factory RepuestoUsado.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepuestoUsado(
      id: serializer.fromJson<int>(json['id']),
      ordenId: serializer.fromJson<int>(json['ordenId']),
      repuestoId: serializer.fromJson<int>(json['repuestoId']),
      cantidad: serializer.fromJson<int>(json['cantidad']),
      precioUnitario: serializer.fromJson<double>(json['precioUnitario']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'ordenId': serializer.toJson<int>(ordenId),
      'repuestoId': serializer.toJson<int>(repuestoId),
      'cantidad': serializer.toJson<int>(cantidad),
      'precioUnitario': serializer.toJson<double>(precioUnitario),
    };
  }

  RepuestoUsado copyWith({
    int? id,
    int? ordenId,
    int? repuestoId,
    int? cantidad,
    double? precioUnitario,
  }) => RepuestoUsado(
    id: id ?? this.id,
    ordenId: ordenId ?? this.ordenId,
    repuestoId: repuestoId ?? this.repuestoId,
    cantidad: cantidad ?? this.cantidad,
    precioUnitario: precioUnitario ?? this.precioUnitario,
  );
  RepuestoUsado copyWithCompanion(RepuestosUsadosCompanion data) {
    return RepuestoUsado(
      id: data.id.present ? data.id.value : this.id,
      ordenId: data.ordenId.present ? data.ordenId.value : this.ordenId,
      repuestoId: data.repuestoId.present
          ? data.repuestoId.value
          : this.repuestoId,
      cantidad: data.cantidad.present ? data.cantidad.value : this.cantidad,
      precioUnitario: data.precioUnitario.present
          ? data.precioUnitario.value
          : this.precioUnitario,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepuestoUsado(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, ordenId, repuestoId, cantidad, precioUnitario);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepuestoUsado &&
          other.id == this.id &&
          other.ordenId == this.ordenId &&
          other.repuestoId == this.repuestoId &&
          other.cantidad == this.cantidad &&
          other.precioUnitario == this.precioUnitario);
}

class RepuestosUsadosCompanion extends UpdateCompanion<RepuestoUsado> {
  final Value<int> id;
  final Value<int> ordenId;
  final Value<int> repuestoId;
  final Value<int> cantidad;
  final Value<double> precioUnitario;
  const RepuestosUsadosCompanion({
    this.id = const Value.absent(),
    this.ordenId = const Value.absent(),
    this.repuestoId = const Value.absent(),
    this.cantidad = const Value.absent(),
    this.precioUnitario = const Value.absent(),
  });
  RepuestosUsadosCompanion.insert({
    this.id = const Value.absent(),
    required int ordenId,
    required int repuestoId,
    required int cantidad,
    required double precioUnitario,
  }) : ordenId = Value(ordenId),
       repuestoId = Value(repuestoId),
       cantidad = Value(cantidad),
       precioUnitario = Value(precioUnitario);
  static Insertable<RepuestoUsado> custom({
    Expression<int>? id,
    Expression<int>? ordenId,
    Expression<int>? repuestoId,
    Expression<int>? cantidad,
    Expression<double>? precioUnitario,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (ordenId != null) 'orden_id': ordenId,
      if (repuestoId != null) 'repuesto_id': repuestoId,
      if (cantidad != null) 'cantidad': cantidad,
      if (precioUnitario != null) 'precio_unitario': precioUnitario,
    });
  }

  RepuestosUsadosCompanion copyWith({
    Value<int>? id,
    Value<int>? ordenId,
    Value<int>? repuestoId,
    Value<int>? cantidad,
    Value<double>? precioUnitario,
  }) {
    return RepuestosUsadosCompanion(
      id: id ?? this.id,
      ordenId: ordenId ?? this.ordenId,
      repuestoId: repuestoId ?? this.repuestoId,
      cantidad: cantidad ?? this.cantidad,
      precioUnitario: precioUnitario ?? this.precioUnitario,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (ordenId.present) {
      map['orden_id'] = Variable<int>(ordenId.value);
    }
    if (repuestoId.present) {
      map['repuesto_id'] = Variable<int>(repuestoId.value);
    }
    if (cantidad.present) {
      map['cantidad'] = Variable<int>(cantidad.value);
    }
    if (precioUnitario.present) {
      map['precio_unitario'] = Variable<double>(precioUnitario.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepuestosUsadosCompanion(')
          ..write('id: $id, ')
          ..write('ordenId: $ordenId, ')
          ..write('repuestoId: $repuestoId, ')
          ..write('cantidad: $cantidad, ')
          ..write('precioUnitario: $precioUnitario')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ClientesTable clientes = $ClientesTable(this);
  late final $TecnicosTable tecnicos = $TecnicosTable(this);
  late final $EquiposTable equipos = $EquiposTable(this);
  late final $OrdenesTable ordenes = $OrdenesTable(this);
  late final $TrabajosTable trabajos = $TrabajosTable(this);
  late final $RepuestosTable repuestos = $RepuestosTable(this);
  late final $RepuestosUsadosTable repuestosUsados = $RepuestosUsadosTable(
    this,
  );
  late final WorkshopDao workshopDao = WorkshopDao(this as AppDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    clientes,
    tecnicos,
    equipos,
    ordenes,
    trabajos,
    repuestos,
    repuestosUsados,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'clientes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('equipos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'equipos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ordenes', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'tecnicos',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('ordenes', kind: UpdateKind.update)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ordenes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('trabajos', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'ordenes',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('repuestos_usados', kind: UpdateKind.delete)],
    ),
  ]);
}

typedef $$ClientesTableCreateCompanionBuilder =
    ClientesCompanion Function({
      Value<int> id,
      required String nombre,
      required String telefono,
    });
typedef $$ClientesTableUpdateCompanionBuilder =
    ClientesCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> telefono,
    });

final class $$ClientesTableReferences
    extends BaseReferences<_$AppDatabase, $ClientesTable, Cliente> {
  $$ClientesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$EquiposTable, List<Equipo>> _equiposRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.equipos,
    aliasName: 'clientes__id__equipos__cliente_id',
  );

  $$EquiposTableProcessedTableManager get equiposRefs {
    final manager = $$EquiposTableTableManager(
      $_db,
      $_db.equipos,
    ).filter((f) => f.clienteId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_equiposRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ClientesTableFilterComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> equiposRefs(
    Expression<bool> Function($$EquiposTableFilterComposer f) f,
  ) {
    final $$EquiposTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.equipos,
      getReferencedColumn: (t) => t.clienteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquiposTableFilterComposer(
            $db: $db,
            $table: $db.equipos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientesTableOrderingComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get telefono => $composableBuilder(
    column: $table.telefono,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ClientesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ClientesTable> {
  $$ClientesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get telefono =>
      $composableBuilder(column: $table.telefono, builder: (column) => column);

  Expression<T> equiposRefs<T extends Object>(
    Expression<T> Function($$EquiposTableAnnotationComposer a) f,
  ) {
    final $$EquiposTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.equipos,
      getReferencedColumn: (t) => t.clienteId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquiposTableAnnotationComposer(
            $db: $db,
            $table: $db.equipos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$ClientesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ClientesTable,
          Cliente,
          $$ClientesTableFilterComposer,
          $$ClientesTableOrderingComposer,
          $$ClientesTableAnnotationComposer,
          $$ClientesTableCreateCompanionBuilder,
          $$ClientesTableUpdateCompanionBuilder,
          (Cliente, $$ClientesTableReferences),
          Cliente,
          PrefetchHooks Function({bool equiposRefs})
        > {
  $$ClientesTableTableManager(_$AppDatabase db, $ClientesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ClientesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ClientesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ClientesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> telefono = const Value.absent(),
              }) =>
                  ClientesCompanion(id: id, nombre: nombre, telefono: telefono),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String telefono,
              }) => ClientesCompanion.insert(
                id: id,
                nombre: nombre,
                telefono: telefono,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$ClientesTable, Cliente>(table),
                  $$ClientesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({equiposRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (equiposRefs) db.equipos],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (equiposRefs)
                    await $_getPrefetchedDataByColumns<
                      Cliente,
                      $ClientesTable,
                      Equipo,
                      $EquiposTable
                    >(
                      currentTable: table,
                      referencedTable: $$ClientesTableReferences
                          ._equiposRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$ClientesTableReferences(db, table, p0).equiposRefs,
                      currentColumn: 'id',
                      referencedColumn: 'cliente_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ClientesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ClientesTable,
      Cliente,
      $$ClientesTableFilterComposer,
      $$ClientesTableOrderingComposer,
      $$ClientesTableAnnotationComposer,
      $$ClientesTableCreateCompanionBuilder,
      $$ClientesTableUpdateCompanionBuilder,
      (Cliente, $$ClientesTableReferences),
      Cliente,
      PrefetchHooks Function({bool equiposRefs})
    >;
typedef $$TecnicosTableCreateCompanionBuilder =
    TecnicosCompanion Function({Value<int> id, required String nombre});
typedef $$TecnicosTableUpdateCompanionBuilder =
    TecnicosCompanion Function({Value<int> id, Value<String> nombre});

final class $$TecnicosTableReferences
    extends BaseReferences<_$AppDatabase, $TecnicosTable, Tecnico> {
  $$TecnicosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$OrdenesTable, List<Orden>> _ordenesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ordenes,
    aliasName: 'tecnicos__id__ordenes__tecnico_responsable_id',
  );

  $$OrdenesTableProcessedTableManager get ordenesRefs {
    final manager = $$OrdenesTableTableManager($_db, $_db.ordenes).filter(
      (f) => f.tecnicoResponsableId.id.sqlEquals($_itemColumn<int>('id')!),
    );

    final cache = $_typedResult.readTableOrNull(_ordenesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$TecnicosTableFilterComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> ordenesRefs(
    Expression<bool> Function($$OrdenesTableFilterComposer f) f,
  ) {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.tecnicoResponsableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TecnicosTableOrderingComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$TecnicosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TecnicosTable> {
  $$TecnicosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  Expression<T> ordenesRefs<T extends Object>(
    Expression<T> Function($$OrdenesTableAnnotationComposer a) f,
  ) {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.tecnicoResponsableId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$TecnicosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TecnicosTable,
          Tecnico,
          $$TecnicosTableFilterComposer,
          $$TecnicosTableOrderingComposer,
          $$TecnicosTableAnnotationComposer,
          $$TecnicosTableCreateCompanionBuilder,
          $$TecnicosTableUpdateCompanionBuilder,
          (Tecnico, $$TecnicosTableReferences),
          Tecnico,
          PrefetchHooks Function({bool ordenesRefs})
        > {
  $$TecnicosTableTableManager(_$AppDatabase db, $TecnicosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TecnicosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TecnicosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TecnicosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
              }) => TecnicosCompanion(id: id, nombre: nombre),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
              }) => TecnicosCompanion.insert(id: id, nombre: nombre),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TecnicosTable, Tecnico>(table),
                  $$TecnicosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ordenesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ordenesRefs) db.ordenes],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordenesRefs)
                    await $_getPrefetchedDataByColumns<
                      Tecnico,
                      $TecnicosTable,
                      Orden,
                      $OrdenesTable
                    >(
                      currentTable: table,
                      referencedTable: $$TecnicosTableReferences
                          ._ordenesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$TecnicosTableReferences(db, table, p0).ordenesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'tecnico_responsable_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$TecnicosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TecnicosTable,
      Tecnico,
      $$TecnicosTableFilterComposer,
      $$TecnicosTableOrderingComposer,
      $$TecnicosTableAnnotationComposer,
      $$TecnicosTableCreateCompanionBuilder,
      $$TecnicosTableUpdateCompanionBuilder,
      (Tecnico, $$TecnicosTableReferences),
      Tecnico,
      PrefetchHooks Function({bool ordenesRefs})
    >;
typedef $$EquiposTableCreateCompanionBuilder =
    EquiposCompanion Function({
      Value<int> id,
      required int clienteId,
      required String tipo,
      required String marca,
      required String modelo,
      Value<String?> numeroSerie,
    });
typedef $$EquiposTableUpdateCompanionBuilder =
    EquiposCompanion Function({
      Value<int> id,
      Value<int> clienteId,
      Value<String> tipo,
      Value<String> marca,
      Value<String> modelo,
      Value<String?> numeroSerie,
    });

final class $$EquiposTableReferences
    extends BaseReferences<_$AppDatabase, $EquiposTable, Equipo> {
  $$EquiposTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $ClientesTable _clienteIdTable(_$AppDatabase db) =>
      db.clientes.createAlias('equipos__cliente_id__clientes__id');

  $$ClientesTableProcessedTableManager get clienteId {
    final $_column = $_itemColumn<int>('cliente_id')!;

    final manager = $$ClientesTableTableManager(
      $_db,
      $_db.clientes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_clienteIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$OrdenesTable, List<Orden>> _ordenesRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.ordenes,
    aliasName: 'equipos__id__ordenes__equipo_id',
  );

  $$OrdenesTableProcessedTableManager get ordenesRefs {
    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.equipoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_ordenesRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$EquiposTableFilterComposer
    extends Composer<_$AppDatabase, $EquiposTable> {
  $$EquiposTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get marca => $composableBuilder(
    column: $table.marca,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get numeroSerie => $composableBuilder(
    column: $table.numeroSerie,
    builder: (column) => ColumnFilters(column),
  );

  $$ClientesTableFilterComposer get clienteId {
    final $$ClientesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clienteId,
      referencedTable: $db.clientes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTableFilterComposer(
            $db: $db,
            $table: $db.clientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> ordenesRefs(
    Expression<bool> Function($$OrdenesTableFilterComposer f) f,
  ) {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EquiposTableOrderingComposer
    extends Composer<_$AppDatabase, $EquiposTable> {
  $$EquiposTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get tipo => $composableBuilder(
    column: $table.tipo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get marca => $composableBuilder(
    column: $table.marca,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get modelo => $composableBuilder(
    column: $table.modelo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get numeroSerie => $composableBuilder(
    column: $table.numeroSerie,
    builder: (column) => ColumnOrderings(column),
  );

  $$ClientesTableOrderingComposer get clienteId {
    final $$ClientesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clienteId,
      referencedTable: $db.clientes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTableOrderingComposer(
            $db: $db,
            $table: $db.clientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$EquiposTableAnnotationComposer
    extends Composer<_$AppDatabase, $EquiposTable> {
  $$EquiposTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get tipo =>
      $composableBuilder(column: $table.tipo, builder: (column) => column);

  GeneratedColumn<String> get marca =>
      $composableBuilder(column: $table.marca, builder: (column) => column);

  GeneratedColumn<String> get modelo =>
      $composableBuilder(column: $table.modelo, builder: (column) => column);

  GeneratedColumn<String> get numeroSerie => $composableBuilder(
    column: $table.numeroSerie,
    builder: (column) => column,
  );

  $$ClientesTableAnnotationComposer get clienteId {
    final $$ClientesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.clienteId,
      referencedTable: $db.clientes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ClientesTableAnnotationComposer(
            $db: $db,
            $table: $db.clientes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> ordenesRefs<T extends Object>(
    Expression<T> Function($$OrdenesTableAnnotationComposer a) f,
  ) {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.equipoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$EquiposTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $EquiposTable,
          Equipo,
          $$EquiposTableFilterComposer,
          $$EquiposTableOrderingComposer,
          $$EquiposTableAnnotationComposer,
          $$EquiposTableCreateCompanionBuilder,
          $$EquiposTableUpdateCompanionBuilder,
          (Equipo, $$EquiposTableReferences),
          Equipo,
          PrefetchHooks Function({bool clienteId, bool ordenesRefs})
        > {
  $$EquiposTableTableManager(_$AppDatabase db, $EquiposTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$EquiposTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$EquiposTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$EquiposTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> clienteId = const Value.absent(),
                Value<String> tipo = const Value.absent(),
                Value<String> marca = const Value.absent(),
                Value<String> modelo = const Value.absent(),
                Value<String?> numeroSerie = const Value.absent(),
              }) => EquiposCompanion(
                id: id,
                clienteId: clienteId,
                tipo: tipo,
                marca: marca,
                modelo: modelo,
                numeroSerie: numeroSerie,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int clienteId,
                required String tipo,
                required String marca,
                required String modelo,
                Value<String?> numeroSerie = const Value.absent(),
              }) => EquiposCompanion.insert(
                id: id,
                clienteId: clienteId,
                tipo: tipo,
                marca: marca,
                modelo: modelo,
                numeroSerie: numeroSerie,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$EquiposTable, Equipo>(table),
                  $$EquiposTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({clienteId = false, ordenesRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [if (ordenesRefs) db.ordenes],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (clienteId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.clienteId,
                                referencedTable: $$EquiposTableReferences
                                    ._clienteIdTable(db),
                                referencedColumn: $$EquiposTableReferences
                                    ._clienteIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [
                  if (ordenesRefs)
                    await $_getPrefetchedDataByColumns<
                      Equipo,
                      $EquiposTable,
                      Orden,
                      $OrdenesTable
                    >(
                      currentTable: table,
                      referencedTable: $$EquiposTableReferences
                          ._ordenesRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$EquiposTableReferences(db, table, p0).ordenesRefs,
                      currentColumn: 'id',
                      referencedColumn: 'equipo_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$EquiposTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $EquiposTable,
      Equipo,
      $$EquiposTableFilterComposer,
      $$EquiposTableOrderingComposer,
      $$EquiposTableAnnotationComposer,
      $$EquiposTableCreateCompanionBuilder,
      $$EquiposTableUpdateCompanionBuilder,
      (Equipo, $$EquiposTableReferences),
      Equipo,
      PrefetchHooks Function({bool clienteId, bool ordenesRefs})
    >;
typedef $$OrdenesTableCreateCompanionBuilder =
    OrdenesCompanion Function({
      Value<int> id,
      required int equipoId,
      required String fallaReportada,
      Value<String> estado,
      Value<int?> tecnicoResponsableId,
      Value<DateTime> fechaRecepcion,
      Value<DateTime?> fechaCierre,
      Value<String?> notas,
    });
typedef $$OrdenesTableUpdateCompanionBuilder =
    OrdenesCompanion Function({
      Value<int> id,
      Value<int> equipoId,
      Value<String> fallaReportada,
      Value<String> estado,
      Value<int?> tecnicoResponsableId,
      Value<DateTime> fechaRecepcion,
      Value<DateTime?> fechaCierre,
      Value<String?> notas,
    });

final class $$OrdenesTableReferences
    extends BaseReferences<_$AppDatabase, $OrdenesTable, Orden> {
  $$OrdenesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $EquiposTable _equipoIdTable(_$AppDatabase db) =>
      db.equipos.createAlias('ordenes__equipo_id__equipos__id');

  $$EquiposTableProcessedTableManager get equipoId {
    final $_column = $_itemColumn<int>('equipo_id')!;

    final manager = $$EquiposTableTableManager(
      $_db,
      $_db.equipos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_equipoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $TecnicosTable _tecnicoResponsableIdTable(_$AppDatabase db) =>
      db.tecnicos.createAlias('ordenes__tecnico_responsable_id__tecnicos__id');

  $$TecnicosTableProcessedTableManager? get tecnicoResponsableId {
    final $_column = $_itemColumn<int>('tecnico_responsable_id');
    if ($_column == null) return null;
    final manager = $$TecnicosTableTableManager(
      $_db,
      $_db.tecnicos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(
      _tecnicoResponsableIdTable($_db),
    );
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$TrabajosTable, List<Trabajo>> _trabajosRefsTable(
    _$AppDatabase db,
  ) => MultiTypedResultKey.fromTable(
    db.trabajos,
    aliasName: 'ordenes__id__trabajos__orden_id',
  );

  $$TrabajosTableProcessedTableManager get trabajosRefs {
    final manager = $$TrabajosTableTableManager(
      $_db,
      $_db.trabajos,
    ).filter((f) => f.ordenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_trabajosRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<$RepuestosUsadosTable, List<RepuestoUsado>>
  _repuestosUsadosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.repuestosUsados,
    aliasName: 'ordenes__id__repuestos_usados__orden_id',
  );

  $$RepuestosUsadosTableProcessedTableManager get repuestosUsadosRefs {
    final manager = $$RepuestosUsadosTableTableManager(
      $_db,
      $_db.repuestosUsados,
    ).filter((f) => f.ordenId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _repuestosUsadosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$OrdenesTableFilterComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fallaReportada => $composableBuilder(
    column: $table.fallaReportada,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaRecepcion => $composableBuilder(
    column: $table.fechaRecepcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get fechaCierre => $composableBuilder(
    column: $table.fechaCierre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnFilters(column),
  );

  $$EquiposTableFilterComposer get equipoId {
    final $$EquiposTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipoId,
      referencedTable: $db.equipos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquiposTableFilterComposer(
            $db: $db,
            $table: $db.equipos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TecnicosTableFilterComposer get tecnicoResponsableId {
    final $$TecnicosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tecnicoResponsableId,
      referencedTable: $db.tecnicos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TecnicosTableFilterComposer(
            $db: $db,
            $table: $db.tecnicos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> trabajosRefs(
    Expression<bool> Function($$TrabajosTableFilterComposer f) f,
  ) {
    final $$TrabajosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trabajos,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajosTableFilterComposer(
            $db: $db,
            $table: $db.trabajos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> repuestosUsadosRefs(
    Expression<bool> Function($$RepuestosUsadosTableFilterComposer f) f,
  ) {
    final $$RepuestosUsadosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repuestosUsados,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosUsadosTableFilterComposer(
            $db: $db,
            $table: $db.repuestosUsados,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdenesTableOrderingComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fallaReportada => $composableBuilder(
    column: $table.fallaReportada,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get estado => $composableBuilder(
    column: $table.estado,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaRecepcion => $composableBuilder(
    column: $table.fechaRecepcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get fechaCierre => $composableBuilder(
    column: $table.fechaCierre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notas => $composableBuilder(
    column: $table.notas,
    builder: (column) => ColumnOrderings(column),
  );

  $$EquiposTableOrderingComposer get equipoId {
    final $$EquiposTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipoId,
      referencedTable: $db.equipos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquiposTableOrderingComposer(
            $db: $db,
            $table: $db.equipos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TecnicosTableOrderingComposer get tecnicoResponsableId {
    final $$TecnicosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tecnicoResponsableId,
      referencedTable: $db.tecnicos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TecnicosTableOrderingComposer(
            $db: $db,
            $table: $db.tecnicos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$OrdenesTableAnnotationComposer
    extends Composer<_$AppDatabase, $OrdenesTable> {
  $$OrdenesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get fallaReportada => $composableBuilder(
    column: $table.fallaReportada,
    builder: (column) => column,
  );

  GeneratedColumn<String> get estado =>
      $composableBuilder(column: $table.estado, builder: (column) => column);

  GeneratedColumn<DateTime> get fechaRecepcion => $composableBuilder(
    column: $table.fechaRecepcion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get fechaCierre => $composableBuilder(
    column: $table.fechaCierre,
    builder: (column) => column,
  );

  GeneratedColumn<String> get notas =>
      $composableBuilder(column: $table.notas, builder: (column) => column);

  $$EquiposTableAnnotationComposer get equipoId {
    final $$EquiposTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.equipoId,
      referencedTable: $db.equipos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$EquiposTableAnnotationComposer(
            $db: $db,
            $table: $db.equipos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$TecnicosTableAnnotationComposer get tecnicoResponsableId {
    final $$TecnicosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.tecnicoResponsableId,
      referencedTable: $db.tecnicos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TecnicosTableAnnotationComposer(
            $db: $db,
            $table: $db.tecnicos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> trabajosRefs<T extends Object>(
    Expression<T> Function($$TrabajosTableAnnotationComposer a) f,
  ) {
    final $$TrabajosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.trabajos,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$TrabajosTableAnnotationComposer(
            $db: $db,
            $table: $db.trabajos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> repuestosUsadosRefs<T extends Object>(
    Expression<T> Function($$RepuestosUsadosTableAnnotationComposer a) f,
  ) {
    final $$RepuestosUsadosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repuestosUsados,
      getReferencedColumn: (t) => t.ordenId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosUsadosTableAnnotationComposer(
            $db: $db,
            $table: $db.repuestosUsados,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$OrdenesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $OrdenesTable,
          Orden,
          $$OrdenesTableFilterComposer,
          $$OrdenesTableOrderingComposer,
          $$OrdenesTableAnnotationComposer,
          $$OrdenesTableCreateCompanionBuilder,
          $$OrdenesTableUpdateCompanionBuilder,
          (Orden, $$OrdenesTableReferences),
          Orden,
          PrefetchHooks Function({
            bool equipoId,
            bool tecnicoResponsableId,
            bool trabajosRefs,
            bool repuestosUsadosRefs,
          })
        > {
  $$OrdenesTableTableManager(_$AppDatabase db, $OrdenesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$OrdenesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$OrdenesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$OrdenesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> equipoId = const Value.absent(),
                Value<String> fallaReportada = const Value.absent(),
                Value<String> estado = const Value.absent(),
                Value<int?> tecnicoResponsableId = const Value.absent(),
                Value<DateTime> fechaRecepcion = const Value.absent(),
                Value<DateTime?> fechaCierre = const Value.absent(),
                Value<String?> notas = const Value.absent(),
              }) => OrdenesCompanion(
                id: id,
                equipoId: equipoId,
                fallaReportada: fallaReportada,
                estado: estado,
                tecnicoResponsableId: tecnicoResponsableId,
                fechaRecepcion: fechaRecepcion,
                fechaCierre: fechaCierre,
                notas: notas,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int equipoId,
                required String fallaReportada,
                Value<String> estado = const Value.absent(),
                Value<int?> tecnicoResponsableId = const Value.absent(),
                Value<DateTime> fechaRecepcion = const Value.absent(),
                Value<DateTime?> fechaCierre = const Value.absent(),
                Value<String?> notas = const Value.absent(),
              }) => OrdenesCompanion.insert(
                id: id,
                equipoId: equipoId,
                fallaReportada: fallaReportada,
                estado: estado,
                tecnicoResponsableId: tecnicoResponsableId,
                fechaRecepcion: fechaRecepcion,
                fechaCierre: fechaCierre,
                notas: notas,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$OrdenesTable, Orden>(table),
                  $$OrdenesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                equipoId = false,
                tecnicoResponsableId = false,
                trabajosRefs = false,
                repuestosUsadosRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (trabajosRefs) db.trabajos,
                    if (repuestosUsadosRefs) db.repuestosUsados,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (equipoId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.equipoId,
                                    referencedTable: $$OrdenesTableReferences
                                        ._equipoIdTable(db),
                                    referencedColumn: $$OrdenesTableReferences
                                        ._equipoIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }
                        if (tecnicoResponsableId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.tecnicoResponsableId,
                                    referencedTable: $$OrdenesTableReferences
                                        ._tecnicoResponsableIdTable(db),
                                    referencedColumn: $$OrdenesTableReferences
                                        ._tecnicoResponsableIdTable(db)
                                        .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (trabajosRefs)
                        await $_getPrefetchedDataByColumns<
                          Orden,
                          $OrdenesTable,
                          Trabajo,
                          $TrabajosTable
                        >(
                          currentTable: table,
                          referencedTable: $$OrdenesTableReferences
                              ._trabajosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdenesTableReferences(
                                db,
                                table,
                                p0,
                              ).trabajosRefs,
                          currentColumn: 'id',
                          referencedColumn: 'orden_id',
                          typedResults: items,
                        ),
                      if (repuestosUsadosRefs)
                        await $_getPrefetchedDataByColumns<
                          Orden,
                          $OrdenesTable,
                          RepuestoUsado,
                          $RepuestosUsadosTable
                        >(
                          currentTable: table,
                          referencedTable: $$OrdenesTableReferences
                              ._repuestosUsadosRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$OrdenesTableReferences(
                                db,
                                table,
                                p0,
                              ).repuestosUsadosRefs,
                          currentColumn: 'id',
                          referencedColumn: 'orden_id',
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$OrdenesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $OrdenesTable,
      Orden,
      $$OrdenesTableFilterComposer,
      $$OrdenesTableOrderingComposer,
      $$OrdenesTableAnnotationComposer,
      $$OrdenesTableCreateCompanionBuilder,
      $$OrdenesTableUpdateCompanionBuilder,
      (Orden, $$OrdenesTableReferences),
      Orden,
      PrefetchHooks Function({
        bool equipoId,
        bool tecnicoResponsableId,
        bool trabajosRefs,
        bool repuestosUsadosRefs,
      })
    >;
typedef $$TrabajosTableCreateCompanionBuilder =
    TrabajosCompanion Function({
      Value<int> id,
      required int ordenId,
      required String descripcion,
      required double costoManoObra,
    });
typedef $$TrabajosTableUpdateCompanionBuilder =
    TrabajosCompanion Function({
      Value<int> id,
      Value<int> ordenId,
      Value<String> descripcion,
      Value<double> costoManoObra,
    });

final class $$TrabajosTableReferences
    extends BaseReferences<_$AppDatabase, $TrabajosTable, Trabajo> {
  $$TrabajosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $OrdenesTable _ordenIdTable(_$AppDatabase db) =>
      db.ordenes.createAlias('trabajos__orden_id__ordenes__id');

  $$OrdenesTableProcessedTableManager get ordenId {
    final $_column = $_itemColumn<int>('orden_id')!;

    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ordenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$TrabajosTableFilterComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get costoManoObra => $composableBuilder(
    column: $table.costoManoObra,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdenesTableFilterComposer get ordenId {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrabajosTableOrderingComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get costoManoObra => $composableBuilder(
    column: $table.costoManoObra,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdenesTableOrderingComposer get ordenId {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableOrderingComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrabajosTableAnnotationComposer
    extends Composer<_$AppDatabase, $TrabajosTable> {
  $$TrabajosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get descripcion => $composableBuilder(
    column: $table.descripcion,
    builder: (column) => column,
  );

  GeneratedColumn<double> get costoManoObra => $composableBuilder(
    column: $table.costoManoObra,
    builder: (column) => column,
  );

  $$OrdenesTableAnnotationComposer get ordenId {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$TrabajosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $TrabajosTable,
          Trabajo,
          $$TrabajosTableFilterComposer,
          $$TrabajosTableOrderingComposer,
          $$TrabajosTableAnnotationComposer,
          $$TrabajosTableCreateCompanionBuilder,
          $$TrabajosTableUpdateCompanionBuilder,
          (Trabajo, $$TrabajosTableReferences),
          Trabajo,
          PrefetchHooks Function({bool ordenId})
        > {
  $$TrabajosTableTableManager(_$AppDatabase db, $TrabajosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$TrabajosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$TrabajosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$TrabajosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ordenId = const Value.absent(),
                Value<String> descripcion = const Value.absent(),
                Value<double> costoManoObra = const Value.absent(),
              }) => TrabajosCompanion(
                id: id,
                ordenId: ordenId,
                descripcion: descripcion,
                costoManoObra: costoManoObra,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ordenId,
                required String descripcion,
                required double costoManoObra,
              }) => TrabajosCompanion.insert(
                id: id,
                ordenId: ordenId,
                descripcion: descripcion,
                costoManoObra: costoManoObra,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$TrabajosTable, Trabajo>(table),
                  $$TrabajosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ordenId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ordenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ordenId,
                                referencedTable: $$TrabajosTableReferences
                                    ._ordenIdTable(db),
                                referencedColumn: $$TrabajosTableReferences
                                    ._ordenIdTable(db)
                                    .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$TrabajosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $TrabajosTable,
      Trabajo,
      $$TrabajosTableFilterComposer,
      $$TrabajosTableOrderingComposer,
      $$TrabajosTableAnnotationComposer,
      $$TrabajosTableCreateCompanionBuilder,
      $$TrabajosTableUpdateCompanionBuilder,
      (Trabajo, $$TrabajosTableReferences),
      Trabajo,
      PrefetchHooks Function({bool ordenId})
    >;
typedef $$RepuestosTableCreateCompanionBuilder =
    RepuestosCompanion Function({
      Value<int> id,
      required String nombre,
      required String codigo,
      required double precio,
      required int existencias,
    });
typedef $$RepuestosTableUpdateCompanionBuilder =
    RepuestosCompanion Function({
      Value<int> id,
      Value<String> nombre,
      Value<String> codigo,
      Value<double> precio,
      Value<int> existencias,
    });

final class $$RepuestosTableReferences
    extends BaseReferences<_$AppDatabase, $RepuestosTable, Repuesto> {
  $$RepuestosTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<$RepuestosUsadosTable, List<RepuestoUsado>>
  _repuestosUsadosRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.repuestosUsados,
    aliasName: 'repuestos__id__repuestos_usados__repuesto_id',
  );

  $$RepuestosUsadosTableProcessedTableManager get repuestosUsadosRefs {
    final manager = $$RepuestosUsadosTableTableManager(
      $_db,
      $_db.repuestosUsados,
    ).filter((f) => f.repuestoId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _repuestosUsadosRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RepuestosTableFilterComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get existencias => $composableBuilder(
    column: $table.existencias,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> repuestosUsadosRefs(
    Expression<bool> Function($$RepuestosUsadosTableFilterComposer f) f,
  ) {
    final $$RepuestosUsadosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repuestosUsados,
      getReferencedColumn: (t) => t.repuestoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosUsadosTableFilterComposer(
            $db: $db,
            $table: $db.repuestosUsados,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RepuestosTableOrderingComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nombre => $composableBuilder(
    column: $table.nombre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get codigo => $composableBuilder(
    column: $table.codigo,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precio => $composableBuilder(
    column: $table.precio,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get existencias => $composableBuilder(
    column: $table.existencias,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$RepuestosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepuestosTable> {
  $$RepuestosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get nombre =>
      $composableBuilder(column: $table.nombre, builder: (column) => column);

  GeneratedColumn<String> get codigo =>
      $composableBuilder(column: $table.codigo, builder: (column) => column);

  GeneratedColumn<double> get precio =>
      $composableBuilder(column: $table.precio, builder: (column) => column);

  GeneratedColumn<int> get existencias => $composableBuilder(
    column: $table.existencias,
    builder: (column) => column,
  );

  Expression<T> repuestosUsadosRefs<T extends Object>(
    Expression<T> Function($$RepuestosUsadosTableAnnotationComposer a) f,
  ) {
    final $$RepuestosUsadosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repuestosUsados,
      getReferencedColumn: (t) => t.repuestoId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosUsadosTableAnnotationComposer(
            $db: $db,
            $table: $db.repuestosUsados,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RepuestosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepuestosTable,
          Repuesto,
          $$RepuestosTableFilterComposer,
          $$RepuestosTableOrderingComposer,
          $$RepuestosTableAnnotationComposer,
          $$RepuestosTableCreateCompanionBuilder,
          $$RepuestosTableUpdateCompanionBuilder,
          (Repuesto, $$RepuestosTableReferences),
          Repuesto,
          PrefetchHooks Function({bool repuestosUsadosRefs})
        > {
  $$RepuestosTableTableManager(_$AppDatabase db, $RepuestosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepuestosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepuestosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepuestosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> nombre = const Value.absent(),
                Value<String> codigo = const Value.absent(),
                Value<double> precio = const Value.absent(),
                Value<int> existencias = const Value.absent(),
              }) => RepuestosCompanion(
                id: id,
                nombre: nombre,
                codigo: codigo,
                precio: precio,
                existencias: existencias,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String nombre,
                required String codigo,
                required double precio,
                required int existencias,
              }) => RepuestosCompanion.insert(
                id: id,
                nombre: nombre,
                codigo: codigo,
                precio: precio,
                existencias: existencias,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RepuestosTable, Repuesto>(table),
                  $$RepuestosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({repuestosUsadosRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (repuestosUsadosRefs) db.repuestosUsados,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (repuestosUsadosRefs)
                    await $_getPrefetchedDataByColumns<
                      Repuesto,
                      $RepuestosTable,
                      RepuestoUsado,
                      $RepuestosUsadosTable
                    >(
                      currentTable: table,
                      referencedTable: $$RepuestosTableReferences
                          ._repuestosUsadosRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$RepuestosTableReferences(
                            db,
                            table,
                            p0,
                          ).repuestosUsadosRefs,
                      currentColumn: 'id',
                      referencedColumn: 'repuesto_id',
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$RepuestosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepuestosTable,
      Repuesto,
      $$RepuestosTableFilterComposer,
      $$RepuestosTableOrderingComposer,
      $$RepuestosTableAnnotationComposer,
      $$RepuestosTableCreateCompanionBuilder,
      $$RepuestosTableUpdateCompanionBuilder,
      (Repuesto, $$RepuestosTableReferences),
      Repuesto,
      PrefetchHooks Function({bool repuestosUsadosRefs})
    >;
typedef $$RepuestosUsadosTableCreateCompanionBuilder =
    RepuestosUsadosCompanion Function({
      Value<int> id,
      required int ordenId,
      required int repuestoId,
      required int cantidad,
      required double precioUnitario,
    });
typedef $$RepuestosUsadosTableUpdateCompanionBuilder =
    RepuestosUsadosCompanion Function({
      Value<int> id,
      Value<int> ordenId,
      Value<int> repuestoId,
      Value<int> cantidad,
      Value<double> precioUnitario,
    });

final class $$RepuestosUsadosTableReferences
    extends
        BaseReferences<_$AppDatabase, $RepuestosUsadosTable, RepuestoUsado> {
  $$RepuestosUsadosTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $OrdenesTable _ordenIdTable(_$AppDatabase db) =>
      db.ordenes.createAlias('repuestos_usados__orden_id__ordenes__id');

  $$OrdenesTableProcessedTableManager get ordenId {
    final $_column = $_itemColumn<int>('orden_id')!;

    final manager = $$OrdenesTableTableManager(
      $_db,
      $_db.ordenes,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_ordenIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $RepuestosTable _repuestoIdTable(_$AppDatabase db) =>
      db.repuestos.createAlias('repuestos_usados__repuesto_id__repuestos__id');

  $$RepuestosTableProcessedTableManager get repuestoId {
    final $_column = $_itemColumn<int>('repuesto_id')!;

    final manager = $$RepuestosTableTableManager(
      $_db,
      $_db.repuestos,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repuestoIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RepuestosUsadosTableFilterComposer
    extends Composer<_$AppDatabase, $RepuestosUsadosTable> {
  $$RepuestosUsadosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnFilters(column),
  );

  $$OrdenesTableFilterComposer get ordenId {
    final $$OrdenesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableFilterComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepuestosTableFilterComposer get repuestoId {
    final $$RepuestosTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repuestoId,
      referencedTable: $db.repuestos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosTableFilterComposer(
            $db: $db,
            $table: $db.repuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepuestosUsadosTableOrderingComposer
    extends Composer<_$AppDatabase, $RepuestosUsadosTable> {
  $$RepuestosUsadosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get cantidad => $composableBuilder(
    column: $table.cantidad,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => ColumnOrderings(column),
  );

  $$OrdenesTableOrderingComposer get ordenId {
    final $$OrdenesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableOrderingComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepuestosTableOrderingComposer get repuestoId {
    final $$RepuestosTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repuestoId,
      referencedTable: $db.repuestos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosTableOrderingComposer(
            $db: $db,
            $table: $db.repuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepuestosUsadosTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepuestosUsadosTable> {
  $$RepuestosUsadosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<int> get cantidad =>
      $composableBuilder(column: $table.cantidad, builder: (column) => column);

  GeneratedColumn<double> get precioUnitario => $composableBuilder(
    column: $table.precioUnitario,
    builder: (column) => column,
  );

  $$OrdenesTableAnnotationComposer get ordenId {
    final $$OrdenesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.ordenId,
      referencedTable: $db.ordenes,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$OrdenesTableAnnotationComposer(
            $db: $db,
            $table: $db.ordenes,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$RepuestosTableAnnotationComposer get repuestoId {
    final $$RepuestosTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repuestoId,
      referencedTable: $db.repuestos,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepuestosTableAnnotationComposer(
            $db: $db,
            $table: $db.repuestos,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepuestosUsadosTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepuestosUsadosTable,
          RepuestoUsado,
          $$RepuestosUsadosTableFilterComposer,
          $$RepuestosUsadosTableOrderingComposer,
          $$RepuestosUsadosTableAnnotationComposer,
          $$RepuestosUsadosTableCreateCompanionBuilder,
          $$RepuestosUsadosTableUpdateCompanionBuilder,
          (RepuestoUsado, $$RepuestosUsadosTableReferences),
          RepuestoUsado,
          PrefetchHooks Function({bool ordenId, bool repuestoId})
        > {
  $$RepuestosUsadosTableTableManager(
    _$AppDatabase db,
    $RepuestosUsadosTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepuestosUsadosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepuestosUsadosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepuestosUsadosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> ordenId = const Value.absent(),
                Value<int> repuestoId = const Value.absent(),
                Value<int> cantidad = const Value.absent(),
                Value<double> precioUnitario = const Value.absent(),
              }) => RepuestosUsadosCompanion(
                id: id,
                ordenId: ordenId,
                repuestoId: repuestoId,
                cantidad: cantidad,
                precioUnitario: precioUnitario,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int ordenId,
                required int repuestoId,
                required int cantidad,
                required double precioUnitario,
              }) => RepuestosUsadosCompanion.insert(
                id: id,
                ordenId: ordenId,
                repuestoId: repuestoId,
                cantidad: cantidad,
                precioUnitario: precioUnitario,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$RepuestosUsadosTable, RepuestoUsado>(table),
                  $$RepuestosUsadosTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({ordenId = false, repuestoId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (ordenId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.ordenId,
                                referencedTable:
                                    $$RepuestosUsadosTableReferences
                                        ._ordenIdTable(db),
                                referencedColumn:
                                    $$RepuestosUsadosTableReferences
                                        ._ordenIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (repuestoId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.repuestoId,
                                referencedTable:
                                    $$RepuestosUsadosTableReferences
                                        ._repuestoIdTable(db),
                                referencedColumn:
                                    $$RepuestosUsadosTableReferences
                                        ._repuestoIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$RepuestosUsadosTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepuestosUsadosTable,
      RepuestoUsado,
      $$RepuestosUsadosTableFilterComposer,
      $$RepuestosUsadosTableOrderingComposer,
      $$RepuestosUsadosTableAnnotationComposer,
      $$RepuestosUsadosTableCreateCompanionBuilder,
      $$RepuestosUsadosTableUpdateCompanionBuilder,
      (RepuestoUsado, $$RepuestosUsadosTableReferences),
      RepuestoUsado,
      PrefetchHooks Function({bool ordenId, bool repuestoId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db, _db.clientes);
  $$TecnicosTableTableManager get tecnicos =>
      $$TecnicosTableTableManager(_db, _db.tecnicos);
  $$EquiposTableTableManager get equipos =>
      $$EquiposTableTableManager(_db, _db.equipos);
  $$OrdenesTableTableManager get ordenes =>
      $$OrdenesTableTableManager(_db, _db.ordenes);
  $$TrabajosTableTableManager get trabajos =>
      $$TrabajosTableTableManager(_db, _db.trabajos);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db, _db.repuestos);
  $$RepuestosUsadosTableTableManager get repuestosUsados =>
      $$RepuestosUsadosTableTableManager(_db, _db.repuestosUsados);
}
