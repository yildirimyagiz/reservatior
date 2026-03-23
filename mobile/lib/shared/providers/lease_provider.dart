import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/lease_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Lease Providers

final LeaseServiceProvider = Provider<LeaseService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LeaseService(dioClient);
});

// List Provider
final leaseProvider = FutureProvider.autoDispose<List<Lease>>((ref) async {
  final service = ref.watch(LeaseServiceProvider);
  return service.getLeases();
});

// Create Provider
final LeaseCreateProvider = FutureProvider.autoDispose<Lease>((ref) async {
  final service = ref.watch(LeaseServiceProvider);
  return service.createLease(Lease());
});

// Update Provider  
final LeaseUpdateProvider = FutureProvider.autoDispose<Lease>((ref) async {
  final service = ref.watch(LeaseServiceProvider);
  final state = ref.watch(LeaseUpdateStateProvider);
  if (state['id'] != null && state['lease'] != null) {
    return service.updateLease(state['id'], state['lease']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final LeaseDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(LeaseServiceProvider);
  final state = ref.watch(LeaseDeleteStateProvider);
  if (state != null) {
    return service.deleteLease(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final LeaseUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final LeaseDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final LeaseLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(leaseProvider);
  final createAsync = ref.watch(LeaseCreateProvider);
  final updateAsync = ref.watch(LeaseUpdateProvider);
  final deleteAsync = ref.watch(LeaseDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
