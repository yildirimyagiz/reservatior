import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/recommendation_result_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// RecommendationResult Providers

final RecommendationResultServiceProvider = Provider<RecommendationResultService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RecommendationResultService(dioClient);
});

// List Provider
final recommendationResultProvider = FutureProvider.autoDispose<List<RecommendationResult>>((ref) async {
  final service = ref.watch(RecommendationResultServiceProvider);
  return service.getRecommendationResults();
});

// Create Provider
final RecommendationResultCreateProvider = FutureProvider.autoDispose<RecommendationResult>((ref) async {
  final service = ref.watch(RecommendationResultServiceProvider);
  return service.createRecommendationResult(RecommendationResult());
});

// Update Provider  
final RecommendationResultUpdateProvider = FutureProvider.autoDispose<RecommendationResult>((ref) async {
  final service = ref.watch(RecommendationResultServiceProvider);
  final state = ref.watch(RecommendationResultUpdateStateProvider);
  if (state['id'] != null && state['recommendation_result'] != null) {
    return service.updateRecommendationResult(state['id'], state['recommendation_result']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final RecommendationResultDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(RecommendationResultServiceProvider);
  final state = ref.watch(RecommendationResultDeleteStateProvider);
  if (state != null) {
    return service.deleteRecommendationResult(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final RecommendationResultUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final RecommendationResultDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final RecommendationResultLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(recommendationResultProvider);
  final createAsync = ref.watch(RecommendationResultCreateProvider);
  final updateAsync = ref.watch(RecommendationResultUpdateProvider);
  final deleteAsync = ref.watch(RecommendationResultDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
