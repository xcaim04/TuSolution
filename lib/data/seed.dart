import 'package:drift/drift.dart';

import '../domain/order_status.dart';
import 'database.dart';

/// Datos de demostración. Solo se insertan la primera vez que se abre la app
/// (o en un test con base en memoria), para que la revisión sea inmediata.
Future<void> seedDemoData(AppDatabase db) async {
  final existing = await db.select(db.tecnicos).get();
  if (existing.isNotEmpty) return;

  await db.transaction(() async {
    final techIds = <int>[];
    for (final nombre in ['Ana López', 'Carlos Ruiz', 'Mariana Torres']) {
      techIds.add(
        await db.into(db.tecnicos).insert(TecnicosCompanion.insert(nombre: nombre)),
      );
    }

    final partIds = <int>[];
    final pricesById = <int, double>{};
    final parts = [
      ('Pantalla OLED', 'PAN-OLED', 1250.0, 3),
      ('Batería', 'BAT-001', 380.0, 2),
      ('Conector de carga', 'CON-CARG', 120.0, 1),
      ('Módulo de cámara', 'CAM-004', 560.0, 5),
      ('Flex de volumen', 'FLEX-VOL', 85.0, 0),
      ('Tapa trasera', 'TAPA-01', 240.0, 4),
    ];
    for (final (nombre, codigo, precio, stock) in parts) {
      final id = await db.into(db.repuestos).insert(
            RepuestosCompanion.insert(
              nombre: nombre,
              codigo: codigo,
              precio: precio,
              existencias: stock,
            ),
          );
      partIds.add(id);
      pricesById[id] = precio;
    }

    final clientIds = <int>[];
    final clients = [
      ('Marta Fuentes', '5550-1122'),
      ('Julio Castañeda', '5551-2233'),
      ('Rosa Mejía', '5552-3344'),
      ('Daniel Paredes', '5553-4455'),
    ];
    for (final (nombre, telefono) in clients) {
      clientIds.add(
        await db.into(db.clientes).insert(
              ClientesCompanion.insert(nombre: nombre, telefono: telefono),
            ),
      );
    }

    Future<int> equipo(
      int cliente,
      String tipo,
      String marca,
      String modelo,
      String serie,
    ) =>
        db.into(db.equipos).insert(
              EquiposCompanion.insert(
                clienteId: cliente,
                tipo: tipo,
                marca: marca,
                modelo: modelo,
                numeroSerie: Value(serie),
              ),
            );

    final e1 = await equipo(clientIds[0], 'Celular', 'Samsung', 'Galaxy A54', 'SM-A546B001');
    final e2 = await equipo(clientIds[0], 'Celular', 'Apple', 'iPhone 11', 'F2LX9Q8KMDXT');
    final e3 = await equipo(clientIds[1], 'Laptop', 'Lenovo', 'IdeaPad 3', 'PF3XK21M');
    final e4 = await equipo(clientIds[2], 'Tablet', 'Apple', 'iPad Air 4', 'F8FT20Q1J4');
    final e5 = await equipo(clientIds[3], 'Celular', 'Xiaomi', 'Redmi Note 12', '25060RK10M');
    final e6 = await equipo(clientIds[1], 'Laptop', 'HP', 'Pavilion 15', '5CD9421AB7');

    final now = DateTime.now();
    DateTime daysAgo(int days) => now.subtract(Duration(days: days));

    Future<int> orden(
      int equipoId,
      String falla,
      OrderStatus estado, {
      int? tecnico,
      DateTime? cierre,
      DateTime? recepcion,
    }) =>
        db.into(db.ordenes).insert(
              OrdenesCompanion.insert(
                equipoId: equipoId,
                fallaReportada: falla,
                estado: Value(estado.dbName),
                tecnicoResponsableId: Value(tecnico),
                fechaRecepcion: Value(recepcion ?? daysAgo(1)),
                fechaCierre: Value(cierre),
              ),
            );

    final o1 = await orden(
      e1,
      'Pantalla rota después de una caída, no responde al tacto',
      OrderStatus.enReparacion,
      tecnico: techIds[0],
      recepcion: daysAgo(2),
    );
    final o2 = await orden(
      e2,
      'La batería dura menos de dos horas',
      OrderStatus.lista,
      tecnico: techIds[1],
      recepcion: daysAgo(4),
    );
    await orden(
      e3,
      'No carga; el conector parece suelto',
      OrderStatus.recibida,
      recepcion: daysAgo(1),
    );
    final o4 = await orden(
      e4,
      'Cámara trasera sale borrosa',
      OrderStatus.entregada,
      tecnico: techIds[2],
      recepcion: daysAgo(10),
      cierre: daysAgo(7),
    );
    await orden(
      e5,
      'No enciende después de un golpe',
      OrderStatus.enReparacion,
      tecnico: techIds[1],
      recepcion: daysAgo(1),
    );
    await orden(
      e6,
      'Varias teclas no responden',
      OrderStatus.recibida,
      recepcion: now.subtract(const Duration(hours: 3)),
    );
    final o7 = await orden(
      e1,
      'Dejó de cargar de un día para otro',
      OrderStatus.entregada,
      tecnico: techIds[0],
      recepcion: daysAgo(40),
      cierre: daysAgo(38),
    );

    Future<void> trabajo(int orden, String descripcion, double costo) =>
        db.into(db.trabajos).insert(
              TrabajosCompanion.insert(
                ordenId: orden,
                descripcion: descripcion,
                costoManoObra: costo,
              ),
            );

    await trabajo(o1, 'Diagnóstico y cambio de pantalla', 350);
    await trabajo(o2, 'Prueba de carga y reemplazo de batería', 250);
    await trabajo(o4, 'Limpieza y reemplazo de módulo de cámara', 300);
    await trabajo(o7, 'Resoldadura de conector de carga', 200);

    Future<void> usado(int orden, int repuesto, int cantidad) =>
        db.into(db.repuestosUsados).insert(
              RepuestosUsadosCompanion.insert(
                ordenId: orden,
                repuestoId: repuesto,
                cantidad: cantidad,
                precioUnitario: pricesById[repuesto] ?? 0,
              ),
            );

    await usado(o1, partIds[0], 1);
    await usado(o2, partIds[1], 1);
    await usado(o4, partIds[3], 1);
    await usado(o7, partIds[2], 1);
  });
}
