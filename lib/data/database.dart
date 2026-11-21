import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';

import 'dao.dart';
import 'tables.dart';

part 'database.g.dart';

/// Base de datos local SQLite. El archivo se crea en el directorio de
/// documentos de la app, por lo que sobrevive al cierre de la aplicación.
@DriftDatabase(
  tables: [
    Clientes,
    Tecnicos,
    Equipos,
    Ordenes,
    Trabajos,
    Repuestos,
    RepuestosUsados,
  ],
  daos: [WorkshopDao],
)
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(driftDatabase(name: 'tu_solution'));

  /// Constructor para tests en memoria.
  AppDatabase.connect(super.connection);

  @override
  int get schemaVersion => 1;

  @override
  MigrationStrategy get migration => MigrationStrategy(
        beforeOpen: (details) async {
          await customStatement('PRAGMA foreign_keys = ON');
        },
        onCreate: (m) async => m.createAll(),
        onUpgrade: (m, from, to) async {
          // v1 es el esquema inicial. Versiones futuras agregan sus pasos aquí.
        },
      );
}
