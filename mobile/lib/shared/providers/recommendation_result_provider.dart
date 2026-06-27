import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/recommendation_result_service.dart';
import 'package:reservatior/shared/repositories/recommendation_result_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final recommendationResultServiceProvider = Provider<RecommendationResultService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return RecommendationResultService(dioClient);
});

final recommendationResultRepositoryProvider = Provider<RecommendationResultRepository>((ref) {
  final service = ref.watch(recommendationResultServiceProvider);
  return RecommendationResultRepositoryImpl(service);
});

final recommendationResultListProvider = FutureProvider.autoDispose<List<RecommendationResult>>((ref) async {
  final repository = ref.watch(recommendationResultRepositoryProvider);
  return repository.getAll();
});

final recommendationResultCreateProvider = StateProvider<RecommendationResult?>((ref) => null);
final recommendationResultUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final recommendationResultDeleteProvider = StateProvider<String?>((ref) => null);
final recommendationResultLoadingProvider = StateProvider<bool>((ref) => false);
