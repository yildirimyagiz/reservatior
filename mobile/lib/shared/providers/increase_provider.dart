import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/increase_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Increase Providers

final IncreaseServiceProvider = Provider<IncreaseService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return IncreaseService(dioClient);
});

// List Provider
final increaseProvider = FutureProvider.autoDispose<List<Increase>>((ref) async {
  final service = ref.watch(IncreaseServiceProvider);
  return service.getIncreases();
});

// Create Provider
final IncreaseCreateProvider = FutureProvider.autoDispose<Increase>((ref) async {
  final service = ref.watch(IncreaseServiceProvider);
  return service.createIncrease(Increase());
});

// Update Provider  
final IncreaseUpdateProvider = FutureProvider.autoDispose<Increase>((ref) async {
  final service = ref.watch(IncreaseServiceProvider);
  final state = ref.watch(IncreaseUpdateStateProvider);
  if (state['id'] != null && state['increase'] != null) {
    return service.updateIncrease(state['id'], state['increase']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final IncreaseDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(IncreaseServiceProvider);
  final state = ref.watch(IncreaseDeleteStateProvider);
  if (state != null) {
    return service.deleteIncrease(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final IncreaseUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final IncreaseDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final IncreaseLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(increaseProvider);
  final createAsync = ref.watch(IncreaseCreateProvider);
  final updateAsync = ref.watch(IncreaseUpdateProvider);
  final deleteAsync = ref.watch(IncreaseDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
