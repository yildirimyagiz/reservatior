import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/loyalty_account_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// LoyaltyAccount Providers

final LoyaltyAccountServiceProvider = Provider<LoyaltyAccountService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return LoyaltyAccountService(dioClient);
});

// List Provider
final loyaltyAccountProvider = FutureProvider.autoDispose<List<LoyaltyAccount>>((ref) async {
  final service = ref.watch(LoyaltyAccountServiceProvider);
  return service.getLoyaltyAccounts();
});

// Create Provider
final LoyaltyAccountCreateProvider = FutureProvider.autoDispose<LoyaltyAccount>((ref) async {
  final service = ref.watch(LoyaltyAccountServiceProvider);
  return service.createLoyaltyAccount(LoyaltyAccount());
});

// Update Provider  
final LoyaltyAccountUpdateProvider = FutureProvider.autoDispose<LoyaltyAccount>((ref) async {
  final service = ref.watch(LoyaltyAccountServiceProvider);
  final state = ref.watch(LoyaltyAccountUpdateStateProvider);
  if (state['id'] != null && state['loyalty_account'] != null) {
    return service.updateLoyaltyAccount(state['id'], state['loyalty_account']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final LoyaltyAccountDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(LoyaltyAccountServiceProvider);
  final state = ref.watch(LoyaltyAccountDeleteStateProvider);
  if (state != null) {
    return service.deleteLoyaltyAccount(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final LoyaltyAccountUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final LoyaltyAccountDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final LoyaltyAccountLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(loyaltyAccountProvider);
  final createAsync = ref.watch(LoyaltyAccountCreateProvider);
  final updateAsync = ref.watch(LoyaltyAccountUpdateProvider);
  final deleteAsync = ref.watch(LoyaltyAccountDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
