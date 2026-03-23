import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/payout_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Payout Providers

final PayoutServiceProvider = Provider<PayoutService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PayoutService(dioClient);
});

// List Provider
final payoutProvider = FutureProvider.autoDispose<List<Payout>>((ref) async {
  final service = ref.watch(PayoutServiceProvider);
  return service.getPayouts();
});

// Create Provider
final PayoutCreateProvider = FutureProvider.autoDispose<Payout>((ref) async {
  final service = ref.watch(PayoutServiceProvider);
  return service.createPayout(Payout());
});

// Update Provider  
final PayoutUpdateProvider = FutureProvider.autoDispose<Payout>((ref) async {
  final service = ref.watch(PayoutServiceProvider);
  final state = ref.watch(PayoutUpdateStateProvider);
  if (state['id'] != null && state['payout'] != null) {
    return service.updatePayout(state['id'], state['payout']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PayoutDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PayoutServiceProvider);
  final state = ref.watch(PayoutDeleteStateProvider);
  if (state != null) {
    return service.deletePayout(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PayoutUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PayoutDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PayoutLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(payoutProvider);
  final createAsync = ref.watch(PayoutCreateProvider);
  final updateAsync = ref.watch(PayoutUpdateProvider);
  final deleteAsync = ref.watch(PayoutDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
