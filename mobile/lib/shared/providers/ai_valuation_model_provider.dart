import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_valuation_model_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AIValuationModel Providers

final aiValuationModelServiceProvider = Provider<AIValuationModelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIValuationModelService(dioClient);
});

// List Provider
final aiValuationModelListProvider = FutureProvider.autoDispose<List<AIValuationModel>>((ref) async {
  final service = ref.watch(aiValuationModelServiceProvider);
  return service.getAIValuationModels();
});

// State Providers for create/update/delete
final aiValuationModelCreateStateProvider = StateProvider<AIValuationModel?>((ref) => null);
final aiValuationModelUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiValuationModelDeleteStateProvider = StateProvider<String?>((ref) => null);

// Create Provider
final aiValuationModelCreateProvider = FutureProvider.autoDispose<AIValuationModel?>((ref) async {
  final service = ref.watch(aiValuationModelServiceProvider);
  final state = ref.watch(aiValuationModelCreateStateProvider);
  if (state != null) {
    return service.createAIValuationModel(state);
  }
  return null;
});

// Update Provider  
final aiValuationModelUpdateProvider = FutureProvider.autoDispose<AIValuationModel?>((ref) async {
  final service = ref.watch(aiValuationModelServiceProvider);
  final state = ref.watch(aiValuationModelUpdateStateProvider);
  if (state['id'] != null && state['ai_valuation_model'] != null) {
    return service.updateAIValuationModel(state['id'], state['ai_valuation_model']);
  }
  return null;
});

// Delete Provider
final aiValuationModelDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiValuationModelServiceProvider);
  final state = ref.watch(aiValuationModelDeleteStateProvider);
  if (state != null) {
    return service.deleteAIValuationModel(state);
  }
});

// Loading Provider
final aiValuationModelLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiValuationModelListProvider);
  return listAsync.isLoading;
});
