// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dao.dart';

// ignore_for_file: type=lint
mixin _$WorkshopDaoMixin on DatabaseAccessor<AppDatabase> {
  $ClientesTable get clientes => attachedDatabase.clientes;
  $EquiposTable get equipos => attachedDatabase.equipos;
  $TecnicosTable get tecnicos => attachedDatabase.tecnicos;
  $OrdenesTable get ordenes => attachedDatabase.ordenes;
  $TrabajosTable get trabajos => attachedDatabase.trabajos;
  $RepuestosTable get repuestos => attachedDatabase.repuestos;
  $RepuestosUsadosTable get repuestosUsados => attachedDatabase.repuestosUsados;
  WorkshopDaoManager get managers => WorkshopDaoManager(this);
}

class WorkshopDaoManager {
  final _$WorkshopDaoMixin _db;
  WorkshopDaoManager(this._db);
  $$ClientesTableTableManager get clientes =>
      $$ClientesTableTableManager(_db.attachedDatabase, _db.clientes);
  $$EquiposTableTableManager get equipos =>
      $$EquiposTableTableManager(_db.attachedDatabase, _db.equipos);
  $$TecnicosTableTableManager get tecnicos =>
      $$TecnicosTableTableManager(_db.attachedDatabase, _db.tecnicos);
  $$OrdenesTableTableManager get ordenes =>
      $$OrdenesTableTableManager(_db.attachedDatabase, _db.ordenes);
  $$TrabajosTableTableManager get trabajos =>
      $$TrabajosTableTableManager(_db.attachedDatabase, _db.trabajos);
  $$RepuestosTableTableManager get repuestos =>
      $$RepuestosTableTableManager(_db.attachedDatabase, _db.repuestos);
  $$RepuestosUsadosTableTableManager get repuestosUsados =>
      $$RepuestosUsadosTableTableManager(
        _db.attachedDatabase,
        _db.repuestosUsados,
      );
}
