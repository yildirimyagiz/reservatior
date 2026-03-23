import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_investment_analysis_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';


final aiInvestmentAnalysisServiceProvider = Provider<AIInvestmentAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIInvestmentAnalysisService(dioClient);
});

// List Provider
final aiInvestmentAnalysisListProvider = FutureProvider.autoDispose<List<AIInvestmentAnalysis>>((ref) async {
  final service = ref.watch(aiInvestmentAnalysisServiceProvider);
  
  // Watch for state changes
  ref.watch(aiInvestmentAnalysisCreateStateProvider);
  ref.watch(aiInvestmentAnalysisUpdateStateProvider);
  ref.watch(aiInvestmentAnalysisDeleteStateProvider);
  
  return service.getAIInvestmentAnalysiss();
});

// State Providers
final aiInvestmentAnalysisCreateStateProvider = StateProvider<AIInvestmentAnalysis?>((ref) => null);
final aiInvestmentAnalysisUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiInvestmentAnalysisDeleteStateProvider = StateProvider<String?>((ref) => null);

// Action Providers
final aiInvestmentAnalysisCreateProvider = FutureProvider.autoDispose<AIInvestmentAnalysis?>((ref) async {
  final service = ref.watch(aiInvestmentAnalysisServiceProvider);
  final data = ref.watch(aiInvestmentAnalysisCreateStateProvider);
  if (data == null) return null;
  return service.createAIInvestmentAnalysis(data);
});

final aiInvestmentAnalysisUpdateProvider = FutureProvider.autoDispose<AIInvestmentAnalysis?>((ref) async {
  final service = ref.watch(aiInvestmentAnalysisServiceProvider);
  final state = ref.watch(aiInvestmentAnalysisUpdateStateProvider);
  if (state['id'] != null && state['ai_investment_analysis'] != null) {
    return service.updateAIInvestmentAnalysis(state['id'], state['ai_investment_analysis']);
  }
  return null;
});

final aiInvestmentAnalysisDeleteProvider = FutureProvider.autoDispose<bool>((ref) async {
  final service = ref.watch(aiInvestmentAnalysisServiceProvider);
  final id = ref.watch(aiInvestmentAnalysisDeleteStateProvider);
  if (id != null) {
    await service.deleteAIInvestmentAnalysis(id);
    return true;
  }
  return false;
});

// Loading Provider
final aiInvestmentAnalysisLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiInvestmentAnalysisListProvider);
  final createAsync = ref.watch(aiInvestmentAnalysisCreateProvider);
  final updateAsync = ref.watch(aiInvestmentAnalysisUpdateProvider);
  final deleteAsync = ref.watch(aiInvestmentAnalysisDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
