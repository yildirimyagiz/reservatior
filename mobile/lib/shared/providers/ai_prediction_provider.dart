import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_prediction_service.dart';
import 'package:reservatior/shared/repositories/ai_prediction_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiPredictionServiceProvider = Provider<AiPredictionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiPredictionService(dioClient);
});

final aiPredictionRepositoryProvider = Provider<AiPredictionRepository>((ref) {
  final service = ref.watch(aiPredictionServiceProvider);
  return AiPredictionRepositoryImpl(service);
});

final aiPredictionListProvider = FutureProvider.autoDispose<List<AiPrediction>>((ref) async {
  final repository = ref.watch(aiPredictionRepositoryProvider);
  return repository.getAll();
});

final aiPredictionCreateProvider = StateProvider<AiPrediction?>((ref) => null);
final aiPredictionUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPredictionDeleteProvider = StateProvider<String?>((ref) => null);
final aiPredictionLoadingProvider = StateProvider<bool>((ref) => false);
