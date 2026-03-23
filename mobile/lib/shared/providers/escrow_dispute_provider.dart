import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/escrow_dispute_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// EscrowDispute Providers

final EscrowDisputeServiceProvider = Provider<EscrowDisputeService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EscrowDisputeService(dioClient);
});

// List Provider
final escrowDisputeProvider = FutureProvider.autoDispose<List<EscrowDispute>>((ref) async {
  final service = ref.watch(EscrowDisputeServiceProvider);
  return service.getEscrowDisputes();
});

// Create Provider
final EscrowDisputeCreateProvider = FutureProvider.autoDispose<EscrowDispute>((ref) async {
  final service = ref.watch(EscrowDisputeServiceProvider);
  return service.createEscrowDispute(EscrowDispute());
});

// Update Provider  
final EscrowDisputeUpdateProvider = FutureProvider.autoDispose<EscrowDispute>((ref) async {
  final service = ref.watch(EscrowDisputeServiceProvider);
  final state = ref.watch(EscrowDisputeUpdateStateProvider);
  if (state['id'] != null && state['escrow_dispute'] != null) {
    return service.updateEscrowDispute(state['id'], state['escrow_dispute']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final EscrowDisputeDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(EscrowDisputeServiceProvider);
  final state = ref.watch(EscrowDisputeDeleteStateProvider);
  if (state != null) {
    return service.deleteEscrowDispute(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final EscrowDisputeUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final EscrowDisputeDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final EscrowDisputeLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(escrowDisputeProvider);
  final createAsync = ref.watch(EscrowDisputeCreateProvider);
  final updateAsync = ref.watch(EscrowDisputeUpdateProvider);
  final deleteAsync = ref.watch(EscrowDisputeDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
