import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_recommendation_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AIRecommendation Providers

final aiRecommendationServiceProvider = Provider<AIRecommendationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIRecommendationService(dioClient);
});

// List Provider
final aiRecommendationListProvider = FutureProvider.autoDispose<List<AIRecommendation>>((ref) async {
  final service = ref.watch(aiRecommendationServiceProvider);
  return service.getAIRecommendations();
});

// State Providers for create/update/delete
final aiRecommendationCreateStateProvider = StateProvider<AIRecommendation?>((ref) => null);
final aiRecommendationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiRecommendationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Create Provider
final aiRecommendationCreateProvider = FutureProvider.autoDispose<AIRecommendation?>((ref) async {
  final service = ref.watch(aiRecommendationServiceProvider);
  final state = ref.watch(aiRecommendationCreateStateProvider);
  if (state != null) {
    return service.createAIRecommendation(state);
  }
  return null;
});

// Update Provider  
final aiRecommendationUpdateProvider = FutureProvider.autoDispose<AIRecommendation?>((ref) async {
  final service = ref.watch(aiRecommendationServiceProvider);
  final state = ref.watch(aiRecommendationUpdateStateProvider);
  if (state['id'] != null && state['ai_recommendation'] != null) {
    return service.updateAIRecommendation(state['id'], state['ai_recommendation']);
  }
  return null;
});

// Delete Provider
final aiRecommendationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiRecommendationServiceProvider);
  final state = ref.watch(aiRecommendationDeleteStateProvider);
  if (state != null) {
    return service.deleteAIRecommendation(state);
  }
});

// Loading Provider
final aiRecommendationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiRecommendationListProvider);
  return listAsync.isLoading;
});
