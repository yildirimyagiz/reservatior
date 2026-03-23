import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/m_l_model_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MLModel Providers

final MLModelServiceProvider = Provider<MLModelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MLModelService(dioClient);
});

// List Provider
final mLModelProvider = FutureProvider.autoDispose<List<MLModel>>((ref) async {
  final service = ref.watch(MLModelServiceProvider);
  return service.getMLModels();
});

// Create Provider
final MLModelCreateProvider = FutureProvider.autoDispose<MLModel>((ref) async {
  final service = ref.watch(MLModelServiceProvider);
  return service.createMLModel(MLModel());
});

// Update Provider  
final MLModelUpdateProvider = FutureProvider.autoDispose<MLModel>((ref) async {
  final service = ref.watch(MLModelServiceProvider);
  final state = ref.watch(MLModelUpdateStateProvider);
  if (state['id'] != null && state['m_l_model'] != null) {
    return service.updateMLModel(state['id'], state['m_l_model']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MLModelDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MLModelServiceProvider);
  final state = ref.watch(MLModelDeleteStateProvider);
  if (state != null) {
    return service.deleteMLModel(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MLModelUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MLModelDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MLModelLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(mLModelProvider);
  final createAsync = ref.watch(MLModelCreateProvider);
  final updateAsync = ref.watch(MLModelUpdateProvider);
  final deleteAsync = ref.watch(MLModelDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
