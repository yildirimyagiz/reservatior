import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_sentiment_analysis_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AISentimentAnalysis Providers

final aiSentimentAnalysisServiceProvider = Provider<AISentimentAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AISentimentAnalysisService(dioClient);
});

// List Provider
final aiSentimentAnalysisListProvider = FutureProvider.autoDispose<List<AISentimentAnalysis>>((ref) async {
  final service = ref.watch(aiSentimentAnalysisServiceProvider);
  return service.getAISentimentAnalysiss();
});

// State Providers for create/update/delete
final aiSentimentAnalysisCreateStateProvider = StateProvider<AISentimentAnalysis?>((ref) => null);
final aiSentimentAnalysisUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiSentimentAnalysisDeleteStateProvider = StateProvider<String?>((ref) => null);

// Create Provider
final aiSentimentAnalysisCreateProvider = FutureProvider.autoDispose<AISentimentAnalysis?>((ref) async {
  final service = ref.watch(aiSentimentAnalysisServiceProvider);
  final state = ref.watch(aiSentimentAnalysisCreateStateProvider);
  if (state != null) {
    return service.createAISentimentAnalysis(state);
  }
  return null;
});

// Update Provider  
final aiSentimentAnalysisUpdateProvider = FutureProvider.autoDispose<AISentimentAnalysis?>((ref) async {
  final service = ref.watch(aiSentimentAnalysisServiceProvider);
  final state = ref.watch(aiSentimentAnalysisUpdateStateProvider);
  if (state['id'] != null && state['ai_sentiment_analysis'] != null) {
    return service.updateAISentimentAnalysis(state['id'], state['ai_sentiment_analysis']);
  }
  return null;
});

// Delete Provider
final aiSentimentAnalysisDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiSentimentAnalysisServiceProvider);
  final state = ref.watch(aiSentimentAnalysisDeleteStateProvider);
  if (state != null) {
    return service.deleteAISentimentAnalysis(state);
  }
});

// Loading Provider
final aiSentimentAnalysisLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiSentimentAnalysisListProvider);
  return listAsync.isLoading;
});
