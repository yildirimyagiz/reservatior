import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_recommendation_service.dart';
import 'package:reservatior/shared/repositories/ai_recommendation_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiRecommendationServiceProvider = Provider<AiRecommendationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiRecommendationService(dioClient);
});

final aiRecommendationRepositoryProvider = Provider<AiRecommendationRepository>((ref) {
  final service = ref.watch(aiRecommendationServiceProvider);
  return AiRecommendationRepositoryImpl(service);
});

final aiRecommendationListProvider = FutureProvider.autoDispose<List<AiRecommendation>>((ref) async {
  final repository = ref.watch(aiRecommendationRepositoryProvider);
  return repository.getAll();
});

final aiRecommendationCreateProvider = StateProvider<AiRecommendation?>((ref) => null);
final aiRecommendationUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiRecommendationDeleteProvider = StateProvider<String?>((ref) => null);
final aiRecommendationLoadingProvider = StateProvider<bool>((ref) => false);
