import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/escrow_release_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// EscrowRelease Providers

final EscrowReleaseServiceProvider = Provider<EscrowReleaseService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EscrowReleaseService(dioClient);
});

// List Provider
final escrowReleaseProvider = FutureProvider.autoDispose<List<EscrowRelease>>((ref) async {
  final service = ref.watch(EscrowReleaseServiceProvider);
  return service.getEscrowReleases();
});

// Create Provider
final EscrowReleaseCreateProvider = FutureProvider.autoDispose<EscrowRelease>((ref) async {
  final service = ref.watch(EscrowReleaseServiceProvider);
  return service.createEscrowRelease(EscrowRelease());
});

// Update Provider  
final EscrowReleaseUpdateProvider = FutureProvider.autoDispose<EscrowRelease>((ref) async {
  final service = ref.watch(EscrowReleaseServiceProvider);
  final state = ref.watch(EscrowReleaseUpdateStateProvider);
  if (state['id'] != null && state['escrow_release'] != null) {
    return service.updateEscrowRelease(state['id'], state['escrow_release']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final EscrowReleaseDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(EscrowReleaseServiceProvider);
  final state = ref.watch(EscrowReleaseDeleteStateProvider);
  if (state != null) {
    return service.deleteEscrowRelease(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final EscrowReleaseUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final EscrowReleaseDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final EscrowReleaseLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(escrowReleaseProvider);
  final createAsync = ref.watch(EscrowReleaseCreateProvider);
  final updateAsync = ref.watch(EscrowReleaseUpdateProvider);
  final deleteAsync = ref.watch(EscrowReleaseDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
