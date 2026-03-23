import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/lease_renewal_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// LeaseRenewal Providers

final LeaseRenewalServiceProvider = Provider<LeaseRenewalService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LeaseRenewalService(dioClient);
});

// List Provider
final leaseRenewalProvider = FutureProvider.autoDispose<List<LeaseRenewal>>((ref) async {
  final service = ref.watch(LeaseRenewalServiceProvider);
  return service.getLeaseRenewals();
});

// Create Provider
final LeaseRenewalCreateProvider = FutureProvider.autoDispose<LeaseRenewal>((ref) async {
  final service = ref.watch(LeaseRenewalServiceProvider);
  return service.createLeaseRenewal(LeaseRenewal());
});

// Update Provider  
final LeaseRenewalUpdateProvider = FutureProvider.autoDispose<LeaseRenewal>((ref) async {
  final service = ref.watch(LeaseRenewalServiceProvider);
  final state = ref.watch(LeaseRenewalUpdateStateProvider);
  if (state['id'] != null && state['lease_renewal'] != null) {
    return service.updateLeaseRenewal(state['id'], state['lease_renewal']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final LeaseRenewalDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(LeaseRenewalServiceProvider);
  final state = ref.watch(LeaseRenewalDeleteStateProvider);
  if (state != null) {
    return service.deleteLeaseRenewal(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final LeaseRenewalUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final LeaseRenewalDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final LeaseRenewalLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(leaseRenewalProvider);
  final createAsync = ref.watch(LeaseRenewalCreateProvider);
  final updateAsync = ref.watch(LeaseRenewalUpdateProvider);
  final deleteAsync = ref.watch(LeaseRenewalDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
