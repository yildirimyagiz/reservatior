import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_market_analysis_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';


final aiMarketAnalysisServiceProvider = Provider<AIMarketAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIMarketAnalysisService(dioClient);
});

// List Provider
final aiMarketAnalysisListProvider = FutureProvider.autoDispose<List<AIMarketAnalysis>>((ref) async {
  final service = ref.watch(aiMarketAnalysisServiceProvider);
  
  // Watch for state changes
  ref.watch(aiMarketAnalysisCreateStateProvider);
  ref.watch(aiMarketAnalysisUpdateStateProvider);
  ref.watch(aiMarketAnalysisDeleteStateProvider);
  
  return service.getAIMarketAnalysiss();
});

// State Providers
final aiMarketAnalysisCreateStateProvider = StateProvider<AIMarketAnalysis?>((ref) => null);
final aiMarketAnalysisUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiMarketAnalysisDeleteStateProvider = StateProvider<String?>((ref) => null);

// Action Providers
final aiMarketAnalysisCreateProvider = FutureProvider.autoDispose<AIMarketAnalysis?>((ref) async {
  final service = ref.watch(aiMarketAnalysisServiceProvider);
  final data = ref.watch(aiMarketAnalysisCreateStateProvider);
  if (data == null) return null;
  return service.createAIMarketAnalysis(data);
});

final aiMarketAnalysisUpdateProvider = FutureProvider.autoDispose<AIMarketAnalysis?>((ref) async {
  final service = ref.watch(aiMarketAnalysisServiceProvider);
  final state = ref.watch(aiMarketAnalysisUpdateStateProvider);
  if (state['id'] != null && state['ai_market_analysis'] != null) {
    return service.updateAIMarketAnalysis(state['id'], state['ai_market_analysis']);
  }
  return null;
});

final aiMarketAnalysisDeleteProvider = FutureProvider.autoDispose<bool>((ref) async {
  final service = ref.watch(aiMarketAnalysisServiceProvider);
  final id = ref.watch(aiMarketAnalysisDeleteStateProvider);
  if (id != null) {
    await service.deleteAIMarketAnalysis(id);
    return true;
  }
  return false;
});
