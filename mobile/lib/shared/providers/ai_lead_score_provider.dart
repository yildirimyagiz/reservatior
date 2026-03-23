import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_lead_score_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';


final aiLeadScoreServiceProvider = Provider<AILeadScoreService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AILeadScoreService(dioClient);
});

// List Provider
final aiLeadScoreListProvider = FutureProvider.autoDispose<List<AILeadScore>>((ref) async {
  final service = ref.watch(aiLeadScoreServiceProvider);
  
  // Watch for state changes
  ref.watch(aiLeadScoreCreateStateProvider);
  ref.watch(aiLeadScoreUpdateStateProvider);
  ref.watch(aiLeadScoreDeleteStateProvider);
  
  return service.getAILeadScores();
});

// State Providers
final aiLeadScoreCreateStateProvider = StateProvider<AILeadScore?>((ref) => null);
final aiLeadScoreUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiLeadScoreDeleteStateProvider = StateProvider<String?>((ref) => null);

// Action Providers
final aiLeadScoreCreateProvider = FutureProvider.autoDispose<AILeadScore?>((ref) async {
  final service = ref.watch(aiLeadScoreServiceProvider);
  final data = ref.watch(aiLeadScoreCreateStateProvider);
  if (data == null) return null;
  return service.createAILeadScore(data);
});

final aiLeadScoreUpdateProvider = FutureProvider.autoDispose<AILeadScore?>((ref) async {
  final service = ref.watch(aiLeadScoreServiceProvider);
  final state = ref.watch(aiLeadScoreUpdateStateProvider);
  if (state['id'] != null && state['ai_lead_score'] != null) {
    return service.updateAILeadScore(state['id'], state['ai_lead_score']);
  }
  return null;
});

final aiLeadScoreDeleteProvider = FutureProvider.autoDispose<bool>((ref) async {
  final service = ref.watch(aiLeadScoreServiceProvider);
  final id = ref.watch(aiLeadScoreDeleteStateProvider);
  if (id != null) {
    await service.deleteAILeadScore(id);
    return true;
  }
  return false;
});

// Loading Provider
final aiLeadScoreLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiLeadScoreListProvider);
  final createAsync = ref.watch(aiLeadScoreCreateProvider);
  final updateAsync = ref.watch(aiLeadScoreUpdateProvider);
  final deleteAsync = ref.watch(aiLeadScoreDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
