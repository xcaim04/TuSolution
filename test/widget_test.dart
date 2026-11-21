import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:tu_solution/domain/order_status.dart';
import 'package:tu_solution/presentation/widgets.dart';

void main() {
  test('transiciones válidas de estado', () {
    expect(canTransition(OrderStatus.recibida, OrderStatus.enReparacion), isTrue);
    expect(canTransition(OrderStatus.recibida, OrderStatus.lista), isFalse);
    expect(canTransition(OrderStatus.enReparacion, OrderStatus.lista), isTrue);
    expect(canTransition(OrderStatus.lista, OrderStatus.entregada), isTrue);
    expect(canTransition(OrderStatus.entregada, OrderStatus.recibida), isFalse);
  });

  test('cancelación solo antes de trabajos o repuestos', () {
    expect(canTransition(OrderStatus.recibida, OrderStatus.cancelada), isTrue);
    expect(canTransition(OrderStatus.enReparacion, OrderStatus.cancelada), isTrue);
    expect(canTransition(OrderStatus.lista, OrderStatus.cancelada), isFalse);
  });

  testWidgets('StatusChip muestra la etiqueta del estado', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: StatusChip(OrderStatus.lista))),
    );
    expect(find.text('Lista'), findsOneWidget);
  });
}
