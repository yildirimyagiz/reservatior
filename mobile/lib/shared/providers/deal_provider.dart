import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/deal_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Deal Providers

final dealServiceProvider = Provider<DealService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return DealService(dioClient);
});

// List Provider
final dealListProvider = FutureProvider.autoDispose<List<Deal>>((ref) async {
  final service = ref.watch(dealServiceProvider);
  return service.getDeals();
});

// Create Provider
final dealCreateProvider = FutureProvider.autoDispose<Deal>((ref) async {
  final service = ref.watch(dealServiceProvider);
  return service.createDeal(Deal());
});

// Update Provider  
final dealUpdateProvider = FutureProvider.autoDispose<Deal>((ref) async {
  final service = ref.watch(dealServiceProvider);
  final state = ref.watch(dealUpdateStateProvider);
  if (state['id'] != null && state['deal'] != null) {
    return service.updateDeal(state['id'], state['deal']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final dealDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(dealServiceProvider);
  final state = ref.watch(dealDeleteStateProvider);
  if (state != null) {
    return service.deleteDeal(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final dealCreateStateProvider = StateProvider<Deal?>((ref) => null);
final dealUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final dealDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final dealLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(dealListProvider);
  final createAsync = ref.watch(dealCreateProvider);
  final updateAsync = ref.watch(dealUpdateProvider);
  final deleteAsync = ref.watch(dealDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
