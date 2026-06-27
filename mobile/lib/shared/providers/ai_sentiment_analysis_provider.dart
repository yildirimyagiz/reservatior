import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_sentiment_analysis_service.dart';
import 'package:reservatior/shared/repositories/ai_sentiment_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiSentimentAnalysisServiceProvider = Provider<AiSentimentAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiSentimentAnalysisService(dioClient);
});

final aiSentimentAnalysisRepositoryProvider = Provider<AiSentimentAnalysisRepository>((ref) {
  final service = ref.watch(aiSentimentAnalysisServiceProvider);
  return AiSentimentAnalysisRepositoryImpl(service);
});

final aiSentimentAnalysisListProvider = FutureProvider.autoDispose<List<AiSentimentAnalysis>>((ref) async {
  final repository = ref.watch(aiSentimentAnalysisRepositoryProvider);
  return repository.getAll();
});

final aiSentimentAnalysisCreateProvider = StateProvider<AiSentimentAnalysis?>((ref) => null);
final aiSentimentAnalysisUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiSentimentAnalysisDeleteProvider = StateProvider<String?>((ref) => null);
final aiSentimentAnalysisLoadingProvider = StateProvider<bool>((ref) => false);
