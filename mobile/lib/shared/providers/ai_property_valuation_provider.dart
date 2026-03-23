import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_property_valuation_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// aiPropertyValuation Providers

final aiPropertyValuationServiceProvider = Provider<AIPropertyValuationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIPropertyValuationService(dioClient);
});

// List Provider
final aiPropertyValuationListProvider = FutureProvider.autoDispose<List<AIPropertyValuation>>((ref) async {
  final service = ref.watch(aiPropertyValuationServiceProvider);
  return service.getAIPropertyValuations();
});

// Create Provider
final aiPropertyValuationCreateProvider = FutureProvider.autoDispose<AIPropertyValuation>((ref) async {
  final service = ref.watch(aiPropertyValuationServiceProvider);
  final state = ref.watch(aiPropertyValuationCreateStateProvider);
  if (state != null) {
    return service.createAIPropertyValuation(state);
  }
  throw Exception('No create data provided');
});

// Update Provider  
final aiPropertyValuationUpdateProvider = FutureProvider.autoDispose<AIPropertyValuation>((ref) async {
  final service = ref.watch(aiPropertyValuationServiceProvider);
  final state = ref.watch(aiPropertyValuationUpdateStateProvider);
  if (state['id'] != null && state['data'] != null) {
    return service.updateAIPropertyValuation(state['id'], state['data']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final aiPropertyValuationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiPropertyValuationServiceProvider);
  final state = ref.watch(aiPropertyValuationDeleteStateProvider);
  if (state != null) {
    return service.deleteAIPropertyValuation(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final aiPropertyValuationCreateStateProvider = StateProvider<AIPropertyValuation?>((ref) => null);
final aiPropertyValuationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPropertyValuationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final aiPropertyValuationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiPropertyValuationListProvider);
  final createAsync = ref.watch(aiPropertyValuationCreateProvider);
  final updateAsync = ref.watch(aiPropertyValuationUpdateProvider);
  final deleteAsync = ref.watch(aiPropertyValuationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
