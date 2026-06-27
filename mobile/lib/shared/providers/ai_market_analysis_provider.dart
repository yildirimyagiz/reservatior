import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_market_analysis_service.dart';
import 'package:reservatior/shared/repositories/ai_market_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiMarketAnalysisServiceProvider = Provider<AiMarketAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiMarketAnalysisService(dioClient);
});

final aiMarketAnalysisRepositoryProvider = Provider<AiMarketAnalysisRepository>((ref) {
  final service = ref.watch(aiMarketAnalysisServiceProvider);
  return AiMarketAnalysisRepositoryImpl(service);
});

final aiMarketAnalysisListProvider = FutureProvider.autoDispose<List<AiMarketAnalysis>>((ref) async {
  final repository = ref.watch(aiMarketAnalysisRepositoryProvider);
  return repository.getAll();
});

final aiMarketAnalysisCreateProvider = StateProvider<AiMarketAnalysis?>((ref) => null);
final aiMarketAnalysisUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiMarketAnalysisDeleteProvider = StateProvider<String?>((ref) => null);
final aiMarketAnalysisLoadingProvider = StateProvider<bool>((ref) => false);
