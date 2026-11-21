import 'package:drift/drift.dart';

/// Dueño de los equipos. Un cliente puede traer varios equipos distintos.
@DataClassName('Cliente')
class Clientes extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get telefono => text()();

}

/// Técnicos fijos del taller. No existe login: se eligen al tomar una orden.
@DataClassName('Tecnico')
class Tecnicos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();

}

/// Un equipo físico puede volver al taller muchas veces (una orden por visita).
@DataClassName('Equipo')
class Equipos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get clienteId =>
      integer().references(Clientes, #id, onDelete: KeyAction.cascade)();
  TextColumn get tipo => text()();
  TextColumn get marca => text()();
  TextColumn get modelo => text()();
  TextColumn get numeroSerie => text().nullable()();

}

/// Cada visita del equipo al taller. `estado` guarda el nombre enum de dominio.
@DataClassName('Orden')
class Ordenes extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get equipoId =>
      integer().references(Equipos, #id, onDelete: KeyAction.cascade)();
  TextColumn get fallaReportada => text()();
  TextColumn get estado => text().withDefault(const Constant('recibida'))();
  IntColumn get tecnicoResponsableId => integer()
      .nullable()
      .references(Tecnicos, #id, onDelete: KeyAction.setNull)();
  DateTimeColumn get fechaRecepcion =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get fechaCierre => dateTime().nullable()();
  TextColumn get notas => text().nullable()();

}

/// Mano de obra de una orden (puede haber varias).
@DataClassName('Trabajo')
class Trabajos extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId =>
      integer().references(Ordenes, #id, onDelete: KeyAction.cascade)();
  TextColumn get descripcion => text()();
  RealColumn get costoManoObra => real()();

}

/// Inventario del almacén.
@DataClassName('Repuesto')
class Repuestos extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get nombre => text()();
  TextColumn get codigo => text().unique()();
  RealColumn get precio => real()();
  IntColumn get existencias => integer()();

}

/// Piezas consumidas por orden. El precio se congela al momento del uso.
@DataClassName('RepuestoUsado')
class RepuestosUsados extends Table {
  IntColumn get id => integer().autoIncrement()();
  IntColumn get ordenId =>
      integer().references(Ordenes, #id, onDelete: KeyAction.cascade)();
  IntColumn get repuestoId =>
      integer().references(Repuestos, #id, onDelete: KeyAction.restrict)();
  IntColumn get cantidad => integer()();
  RealColumn get precioUnitario => real()();

}
