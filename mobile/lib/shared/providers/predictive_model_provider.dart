import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/predictive_model_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PredictiveModel Providers

final PredictiveModelServiceProvider = Provider<PredictiveModelService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PredictiveModelService(dioClient);
});

// List Provider
final predictiveModelProvider = FutureProvider.autoDispose<List<PredictiveModel>>((ref) async {
  final service = ref.watch(PredictiveModelServiceProvider);
  return service.getPredictiveModels();
});

// Create Provider
final PredictiveModelCreateProvider = FutureProvider.autoDispose<PredictiveModel>((ref) async {
  final service = ref.watch(PredictiveModelServiceProvider);
  return service.createPredictiveModel(PredictiveModel());
});

// Update Provider  
final PredictiveModelUpdateProvider = FutureProvider.autoDispose<PredictiveModel>((ref) async {
  final service = ref.watch(PredictiveModelServiceProvider);
  final state = ref.watch(PredictiveModelUpdateStateProvider);
  if (state['id'] != null && state['predictive_model'] != null) {
    return service.updatePredictiveModel(state['id'], state['predictive_model']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PredictiveModelDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PredictiveModelServiceProvider);
  final state = ref.watch(PredictiveModelDeleteStateProvider);
  if (state != null) {
    return service.deletePredictiveModel(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PredictiveModelUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PredictiveModelDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PredictiveModelLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(predictiveModelProvider);
  final createAsync = ref.watch(PredictiveModelCreateProvider);
  final updateAsync = ref.watch(PredictiveModelUpdateProvider);
  final deleteAsync = ref.watch(PredictiveModelDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
