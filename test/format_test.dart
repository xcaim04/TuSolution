import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tu_solution/core/format.dart';

void main() {
  test('formatDate funciona tras inicializar es_ES (como en main)', () async {
    await initializeDateFormatting('es_ES');
    expect(formatDate(DateTime(2026, 1, 5)), contains('2026'));
  });
}
