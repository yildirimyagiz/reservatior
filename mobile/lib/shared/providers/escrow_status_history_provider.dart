import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/escrow_status_history_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// EscrowStatusHistory Providers

final EscrowStatusHistoryServiceProvider = Provider<EscrowStatusHistoryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EscrowStatusHistoryService(dioClient);
});

// List Provider
final escrowStatusHistoryProvider = FutureProvider.autoDispose<List<EscrowStatusHistory>>((ref) async {
  final service = ref.watch(EscrowStatusHistoryServiceProvider);
  return service.getEscrowStatusHistorys();
});

// Create Provider
final EscrowStatusHistoryCreateProvider = FutureProvider.autoDispose<EscrowStatusHistory>((ref) async {
  final service = ref.watch(EscrowStatusHistoryServiceProvider);
  return service.createEscrowStatusHistory(EscrowStatusHistory());
});

// Update Provider  
final EscrowStatusHistoryUpdateProvider = FutureProvider.autoDispose<EscrowStatusHistory>((ref) async {
  final service = ref.watch(EscrowStatusHistoryServiceProvider);
  final state = ref.watch(EscrowStatusHistoryUpdateStateProvider);
  if (state['id'] != null && state['escrow_status_history'] != null) {
    return service.updateEscrowStatusHistory(state['id'], state['escrow_status_history']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final EscrowStatusHistoryDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(EscrowStatusHistoryServiceProvider);
  final state = ref.watch(EscrowStatusHistoryDeleteStateProvider);
  if (state != null) {
    return service.deleteEscrowStatusHistory(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final EscrowStatusHistoryUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final EscrowStatusHistoryDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final EscrowStatusHistoryLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(escrowStatusHistoryProvider);
  final createAsync = ref.watch(EscrowStatusHistoryCreateProvider);
  final updateAsync = ref.watch(EscrowStatusHistoryUpdateProvider);
  final deleteAsync = ref.watch(EscrowStatusHistoryDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
