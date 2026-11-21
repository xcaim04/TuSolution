import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/models.dart';
import '../../domain/repository.dart';
import '../providers.dart';

class WorkloadViewModel extends StreamNotifier<List<TechnicianWorkload>> {
  @override
  Stream<List<TechnicianWorkload>> build() =>
      ref.watch(repositoryProvider).watchWorkload();
}

final workloadProvider = StreamNotifierProvider<WorkloadViewModel,
    List<TechnicianWorkload>>(WorkloadViewModel.new);

class LowStockViewModel extends StreamNotifier<List<Part>> {
  @override
  Stream<List<Part>> build() => ref.watch(repositoryProvider).watchLowStockParts();
}

final lowStockProvider =
    StreamNotifierProvider<LowStockViewModel, List<Part>>(LowStockViewModel.new);

class TechniciansViewModel extends StreamNotifier<List<Technician>> {
  @override
  Stream<List<Technician>> build() =>
      ref.watch(repositoryProvider).watchTechnicians();
}

final techniciansProvider =
    StreamNotifierProvider<TechniciansViewModel, List<Technician>>(
        TechniciansViewModel.new);

class ClientsViewModel extends StreamNotifier<List<ClientOption>> {
  @override
  Stream<List<ClientOption>> build() => ref.watch(repositoryProvider).watchClients();
}

final clientsProvider =
    StreamNotifierProvider<ClientsViewModel, List<ClientOption>>(
        ClientsViewModel.new);
