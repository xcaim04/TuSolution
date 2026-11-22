import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // DateFormat('…', 'es_ES') lanza LocaleDataException sin esto.
  await initializeDateFormatting('es_ES');
  runApp(const ProviderScope(child: TuSolutionApp()));
}
