import 'package:drift/drift.dart' show DatabaseConnection;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_solution/data/database.dart';
import 'package:tu_solution/data/repository_impl.dart';
import 'package:tu_solution/data/seed.dart';
import 'package:tu_solution/domain/exceptions.dart';
import 'package:tu_solution/domain/order_status.dart';

void main() {
  late AppDatabase db;
  late WorkshopRepositoryImpl repo;

  setUp(() async {
    db = AppDatabase.connect(DatabaseConnection(NativeDatabase.memory()));
    repo = WorkshopRepositoryImpl(db);
    await seedDemoData(db);
  });

  tearDown(() async {
    await db.close();
  });

  Future<int> newOrder() => repo.createOrder(
        clienteNombre: 'Cliente Prueba',
        clienteTelefono: '5555-0000',
        clienteId: null,
        tipo: 'Laptop',
        marca: 'Lenovo',
        modelo: 'T480',
        numeroSerie: 'SN-1',
        fallaReportada: 'No enciende',
      );

  Future<int> techId() async =>
      (await repo.watchTechnicians().first).first.id;

  Future<int> partId() async => (await repo.watchParts().first).first.id;

  test('crear orden la deja recibida y sin responsable', () async {
    final id = await newOrder();
    final detail = await repo.watchOrderDetail(id).first;
    expect(detail!.summary.status, OrderStatus.recibida);
    expect(detail.summary.tecnicoId, isNull);
  });

  test('tomar orden es atómico y solo funciona una vez', () async {
    final id = await newOrder();
    final technician = await techId();
    await repo.takeOrder(id, technician);

    final detail = await repo.watchOrderDetail(id).first;
    expect(detail!.summary.status, OrderStatus.enReparacion);
    expect(detail.summary.tecnicoId, technician);

    expect(
      repo.takeOrder(id, technician),
      throwsA(isA<AlreadyAssignedException>()),
    );
  });

  test('trabajos y repuestos calculan total con precio congelado', () async {
    final id = await newOrder();
    await repo.takeOrder(id, await techId());
    final repuesto = await partId();

    await repo.addWork(id, 'Diagnóstico', 150);
    await repo.addUsedPart(id, repuesto, 2);

    var detail = await repo.watchOrderDetail(id).first;
    final frozenPrice = detail!.repuestosUsados.single.precioUnitario;
    final expected = 150 + (2 * frozenPrice);
    expect(detail.total, closeTo(expected, 0.001));

    await repo.savePart(
      id: repuesto,
      nombre: 'Repuesto caro',
      codigo: 'NUEVO-1',
      precio: 9999,
      existencias: 50,
    );
    detail = await repo.watchOrderDetail(id).first;
    expect(detail!.repuestosUsados.single.precioUnitario, frozenPrice);
    expect(detail.total, closeTo(expected, 0.001));
  });

  test('no se puede cancelar una orden con trabajo registrado', () async {
    final id = await newOrder();
    await repo.takeOrder(id, await techId());
    await repo.addWork(id, 'Prueba', 10);

    expect(
      repo.changeStatus(id, OrderStatus.cancelada),
      throwsA(isA<CannotCancelStartedException>()),
    );
  });

  test('no se puede descontar más stock del disponible', () async {
    final id = await newOrder();
    await repo.takeOrder(id, await techId());
    final part = (await repo.watchParts().first).first;

    expect(
      repo.addUsedPart(id, part.id, part.existencias + 1),
      throwsA(isA<InsufficientStockException>()),
    );
  });

  test('transiciones inválidas se rechazan', () async {
    final id = await newOrder();
    expect(
      repo.changeStatus(id, OrderStatus.entregada),
      throwsA(isA<InvalidTransitionException>()),
    );
  });

  test('órdenes se listan en el orden del flujo, no alfabético', () async {
    await newOrder();
    final orders = await repo.watchOrders().first;
    final indexes = orders.map((o) => o.status.index).toList();
    expect(indexes, [...indexes]..sort());
    expect(orders.first.status, OrderStatus.recibida);
  });
}
