import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_lead_scoring_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';


final aiLeadScoringServiceProvider = Provider<AILeadScoringService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AILeadScoringService(dioClient);
});

// List Provider
final aiLeadScoringListProvider = FutureProvider.autoDispose<List<AILeadScoring>>((ref) async {
  final service = ref.watch(aiLeadScoringServiceProvider);
  
  // Watch for state changes
  ref.watch(aiLeadScoringCreateStateProvider);
  ref.watch(aiLeadScoringUpdateStateProvider);
  ref.watch(aiLeadScoringDeleteStateProvider);
  
  return service.getAILeadScorings();
});

// State Providers
final aiLeadScoringCreateStateProvider = StateProvider<AILeadScoring?>((ref) => null);
final aiLeadScoringUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiLeadScoringDeleteStateProvider = StateProvider<String?>((ref) => null);

// Action Providers
final aiLeadScoringCreateProvider = FutureProvider.autoDispose<AILeadScoring?>((ref) async {
  final service = ref.watch(aiLeadScoringServiceProvider);
  final data = ref.watch(aiLeadScoringCreateStateProvider);
  if (data == null) return null;
  return service.createAILeadScoring(data);
});

final aiLeadScoringUpdateProvider = FutureProvider.autoDispose<AILeadScoring?>((ref) async {
  final service = ref.watch(aiLeadScoringServiceProvider);
  final state = ref.watch(aiLeadScoringUpdateStateProvider);
  if (state['id'] != null && state['ai_lead_scoring'] != null) {
    return service.updateAILeadScoring(state['id'], state['ai_lead_scoring']);
  }
  return null;
});

final aiLeadScoringDeleteProvider = FutureProvider.autoDispose<bool>((ref) async {
  final service = ref.watch(aiLeadScoringServiceProvider);
  final id = ref.watch(aiLeadScoringDeleteStateProvider);
  if (id != null) {
    await service.deleteAILeadScoring(id);
    return true;
  }
  return false;
});

// Loading Provider
final aiLeadScoringLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiLeadScoringListProvider);
  final createAsync = ref.watch(aiLeadScoringCreateProvider);
  final updateAsync = ref.watch(aiLeadScoringUpdateProvider);
  final deleteAsync = ref.watch(aiLeadScoringDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
