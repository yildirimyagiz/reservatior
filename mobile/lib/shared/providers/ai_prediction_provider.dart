import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/aiPredictionService.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// aiPrediction Providers

final aiPredictionServiceProvider = Provider<aiPredictionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return aiPredictionService(dioClient);
});

// List Provider
final aiPredictionListProvider = FutureProvider.autoDispose<List<AIPrediction>>((ref) async {
  final service = ref.watch(aiPredictionServiceProvider);
  return service.getAIPredictions();
});

// Create Provider
final aiPredictionCreateProvider = FutureProvider.autoDispose<AIPrediction>((ref) async {
  final service = ref.watch(aiPredictionServiceProvider);
  return service.createAIPrediction(AIPrediction());
});

// Update Provider  
final aiPredictionUpdateProvider = FutureProvider.autoDispose<AIPrediction>((ref) async {
  final service = ref.watch(aiPredictionServiceProvider);
  final state = ref.watch(aiPredictionUpdateStateProvider);
  if (state['id'] != null && state['ai_prediction'] != null) {
    return service.updateAIPrediction(state['id'], state['ai_prediction']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final aiPredictionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiPredictionServiceProvider);
  final state = ref.watch(aiPredictionDeleteStateProvider);
  if (state != null) {
    return service.deleteAIPrediction(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final aiPredictionCreateStateProvider = StateProvider<AIPrediction?>((ref) => null);

final aiPredictionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPredictionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final aiPredictionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiPredictionListProvider);
  final createAsync = ref.watch(aiPredictionCreateProvider);
  final updateAsync = ref.watch(aiPredictionUpdateProvider);
  final deleteAsync = ref.watch(aiPredictionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
