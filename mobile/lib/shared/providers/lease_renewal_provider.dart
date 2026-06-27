import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/lease_renewal_service.dart';
import 'package:reservatior/shared/repositories/lease_renewal_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final leaseRenewalServiceProvider = Provider<LeaseRenewalService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LeaseRenewalService(dioClient);
});

final leaseRenewalRepositoryProvider = Provider<LeaseRenewalRepository>((ref) {
  final service = ref.watch(leaseRenewalServiceProvider);
  return LeaseRenewalRepositoryImpl(service);
});

final leaseRenewalListProvider = FutureProvider.autoDispose<List<LeaseRenewal>>((ref) async {
  final repository = ref.watch(leaseRenewalRepositoryProvider);
  return repository.getAll();
});

final leaseRenewalCreateProvider = StateProvider<LeaseRenewal?>((ref) => null);
final leaseRenewalUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final leaseRenewalDeleteProvider = StateProvider<String?>((ref) => null);
final leaseRenewalLoadingProvider = StateProvider<bool>((ref) => false);
