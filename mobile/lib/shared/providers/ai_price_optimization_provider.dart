import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/aiPriceOptimizationService.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// aiPriceOptimization Providers

final aiPriceOptimizationServiceProvider = Provider<aiPriceOptimizationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return aiPriceOptimizationService(dioClient);
});

// List Provider
final aiPriceOptimizationListProvider = FutureProvider.autoDispose<List<AIPriceOptimization>>((ref) async {
  final service = ref.watch(aiPriceOptimizationServiceProvider);
  return service.getAIPriceOptimizations();
});

// Create Provider
final aiPriceOptimizationCreateProvider = FutureProvider.autoDispose<AIPriceOptimization>((ref) async {
  final service = ref.watch(aiPriceOptimizationServiceProvider);
  return service.createAIPriceOptimization(AIPriceOptimization());
});

// Update Provider  
final aiPriceOptimizationUpdateProvider = FutureProvider.autoDispose<AIPriceOptimization>((ref) async {
  final service = ref.watch(aiPriceOptimizationServiceProvider);
  final state = ref.watch(aiPriceOptimizationUpdateStateProvider);
  if (state['id'] != null && state['ai_price_optimization'] != null) {
    return service.updateAIPriceOptimization(state['id'], state['ai_price_optimization']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final aiPriceOptimizationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiPriceOptimizationServiceProvider);
  final state = ref.watch(aiPriceOptimizationDeleteStateProvider);
  if (state != null) {
    return service.deleteAIPriceOptimization(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final aiPriceOptimizationCreateStateProvider = StateProvider<AIPriceOptimization?>((ref) => null);

final aiPriceOptimizationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPriceOptimizationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final aiPriceOptimizationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiPriceOptimizationListProvider);
  final createAsync = ref.watch(aiPriceOptimizationCreateProvider);
  final updateAsync = ref.watch(aiPriceOptimizationUpdateProvider);
  final deleteAsync = ref.watch(aiPriceOptimizationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
