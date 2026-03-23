import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_model_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// aiModel Providers

final aiModelServiceProvider = Provider<aiModelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return aiModelService(dioClient);
});

// List Provider
final aiModelListProvider = FutureProvider.autoDispose<List<aiModel>>((ref) async {
  final service = ref.watch(aiModelServiceProvider);
  return service.getaiModels();
});

// Create Provider
final aiModelCreateProvider = FutureProvider.autoDispose<aiModel>((ref) async {
  final service = ref.watch(aiModelServiceProvider);
  return service.createaiModel(aiModel());
});

// Update Provider  
final aiModelUpdateProvider = FutureProvider.autoDispose<aiModel>((ref) async {
  final service = ref.watch(aiModelServiceProvider);
  final state = ref.watch(aiModelUpdateStateProvider);
  if (state['id'] != null && state['ai_model'] != null) {
    return service.updateaiModel(state['id'], state['ai_model']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final aiModelDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiModelServiceProvider);
  final state = ref.watch(aiModelDeleteStateProvider);
  if (state != null) {
    return service.deleteaiModel(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final aiModelCreateStateProvider = StateProvider<AIModel?>((ref) => null);
final aiModelUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiModelDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final aiModelLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiModelListProvider);
  final createAsync = ref.watch(aiModelCreateProvider);
  final updateAsync = ref.watch(aiModelUpdateProvider);
  final deleteAsync = ref.watch(aiModelDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});

// Loading Provider
final aiModelLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiModelListProvider);
  final createAsync = ref.watch(aiModelCreateProvider);
  final updateAsync = ref.watch(aiModelUpdateProvider);
  final deleteAsync = ref.watch(aiModelDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
