import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ai_investment_analysis_service.dart';
import 'package:reservatior/shared/repositories/ai_investment_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final aiInvestmentAnalysisServiceProvider = Provider<AiInvestmentAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiInvestmentAnalysisService(dioClient);
});

final aiInvestmentAnalysisRepositoryProvider = Provider<AiInvestmentAnalysisRepository>((ref) {
  final service = ref.watch(aiInvestmentAnalysisServiceProvider);
  return AiInvestmentAnalysisRepositoryImpl(service);
});

final aiInvestmentAnalysisListProvider = FutureProvider.autoDispose<List<AiInvestmentAnalysis>>((ref) async {
  final repository = ref.watch(aiInvestmentAnalysisRepositoryProvider);
  return repository.getAll();
});

final aiInvestmentAnalysisCreateProvider = StateProvider<AiInvestmentAnalysis?>((ref) => null);
final aiInvestmentAnalysisUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiInvestmentAnalysisDeleteProvider = StateProvider<String?>((ref) => null);
final aiInvestmentAnalysisLoadingProvider = StateProvider<bool>((ref) => false);
