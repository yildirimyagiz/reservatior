import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/agency_service.dart';
import 'package:reservatior/shared/repositories/agency_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final agencyServiceProvider = Provider<AgencyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AgencyService(dioClient);
});

final agencyRepositoryProvider = Provider<AgencyRepository>((ref) {
  final service = ref.watch(agencyServiceProvider);
  return AgencyRepositoryImpl(service);
});

final agencyListProvider = FutureProvider.autoDispose<List<Agency>>((ref) async {
  final repository = ref.watch(agencyRepositoryProvider);
  return repository.getAll();
});

final agencyAgentsProvider = FutureProvider.family.autoDispose<List<Map<String, dynamic>>, String>((ref, id) async {
  final repository = ref.watch(agencyRepositoryProvider);
  return repository.getAgents(id);
});

final agencyStatsProvider = FutureProvider.family.autoDispose<Map<String, dynamic>, String>((ref, id) async {
  final repository = ref.watch(agencyRepositoryProvider);
  return repository.getStats(id);
});

final agencyListingsProvider = FutureProvider.family.autoDispose<List<Map<String, dynamic>>, String>((ref, id) async {
  final repository = ref.watch(agencyRepositoryProvider);
  return repository.getListings(id);
});

final agencyCreateProvider = StateProvider<Agency?>((ref) => null);
final agencyUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final agencyDeleteProvider = StateProvider<String?>((ref) => null);
final agencyLoadingProvider = StateProvider<bool>((ref) => false);
