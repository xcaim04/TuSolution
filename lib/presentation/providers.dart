import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../data/database.dart';
import '../data/repository_impl.dart';
import '../data/seed.dart';
import '../domain/repository.dart';

final databaseProvider = Provider<AppDatabase>((ref) {
  final db = AppDatabase();
  ref.onDispose(db.close);
  return db;
});

final repositoryProvider = Provider<WorkshopRepository>((ref) {
  return WorkshopRepositoryImpl(ref.watch(databaseProvider));
});

/// Carga los técnicos y datos de ejemplo la primera vez que se abre la app.
final seedProvider = FutureProvider<void>((ref) async {
  await seedDemoData(ref.watch(databaseProvider));
});
