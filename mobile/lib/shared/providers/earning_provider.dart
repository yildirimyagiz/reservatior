import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/earning_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Earning Providers

final EarningServiceProvider = Provider<EarningService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return EarningService(dioClient);
});

// List Provider
final earningProvider = FutureProvider.autoDispose<List<Earning>>((ref) async {
  final service = ref.watch(EarningServiceProvider);
  return service.getEarnings();
});

// Create Provider
final EarningCreateProvider = FutureProvider.autoDispose<Earning>((ref) async {
  final service = ref.watch(EarningServiceProvider);
  return service.createEarning(Earning());
});

// Update Provider  
final EarningUpdateProvider = FutureProvider.autoDispose<Earning>((ref) async {
  final service = ref.watch(EarningServiceProvider);
  final state = ref.watch(EarningUpdateStateProvider);
  if (state['id'] != null && state['earning'] != null) {
    return service.updateEarning(state['id'], state['earning']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final EarningDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(EarningServiceProvider);
  final state = ref.watch(EarningDeleteStateProvider);
  if (state != null) {
    return service.deleteEarning(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final EarningUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final EarningDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final EarningLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(earningProvider);
  final createAsync = ref.watch(EarningCreateProvider);
  final updateAsync = ref.watch(EarningUpdateProvider);
  final deleteAsync = ref.watch(EarningDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
