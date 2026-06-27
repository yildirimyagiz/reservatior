import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/lease_service.dart';
import 'package:reservatior/shared/repositories/lease_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final leaseServiceProvider = Provider<LeaseService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LeaseService(dioClient);
});

final leaseRepositoryProvider = Provider<LeaseRepository>((ref) {
  final service = ref.watch(leaseServiceProvider);
  return LeaseRepositoryImpl(service);
});

final leaseListProvider = FutureProvider.autoDispose<List<Lease>>((ref) async {
  final repository = ref.watch(leaseRepositoryProvider);
  return repository.getAll();
});

final leaseCreateProvider = StateProvider<Lease?>((ref) => null);
final leaseUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final leaseDeleteProvider = StateProvider<String?>((ref) => null);
final leaseLoadingProvider = StateProvider<bool>((ref) => false);
