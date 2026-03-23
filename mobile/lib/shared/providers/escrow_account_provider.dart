import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/escrow_account_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// EscrowAccount Providers

final EscrowAccountServiceProvider = Provider<EscrowAccountService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EscrowAccountService(dioClient);
});

// List Provider
final escrowAccountProvider = FutureProvider.autoDispose<List<EscrowAccount>>((ref) async {
  final service = ref.watch(EscrowAccountServiceProvider);
  return service.getEscrowAccounts();
});

// Create Provider
final EscrowAccountCreateProvider = FutureProvider.autoDispose<EscrowAccount>((ref) async {
  final service = ref.watch(EscrowAccountServiceProvider);
  return service.createEscrowAccount(EscrowAccount());
});

// Update Provider  
final EscrowAccountUpdateProvider = FutureProvider.autoDispose<EscrowAccount>((ref) async {
  final service = ref.watch(EscrowAccountServiceProvider);
  final state = ref.watch(EscrowAccountUpdateStateProvider);
  if (state['id'] != null && state['escrow_account'] != null) {
    return service.updateEscrowAccount(state['id'], state['escrow_account']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final EscrowAccountDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(EscrowAccountServiceProvider);
  final state = ref.watch(EscrowAccountDeleteStateProvider);
  if (state != null) {
    return service.deleteEscrowAccount(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final EscrowAccountUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final EscrowAccountDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final EscrowAccountLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(escrowAccountProvider);
  final createAsync = ref.watch(EscrowAccountCreateProvider);
  final updateAsync = ref.watch(EscrowAccountUpdateProvider);
  final deleteAsync = ref.watch(EscrowAccountDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
