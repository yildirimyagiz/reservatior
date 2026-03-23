import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_image_analysis_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';


final aiImageAnalysisServiceProvider = Provider<AIImageAnalysisService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIImageAnalysisService(dioClient);
});

// List Provider
final aiImageAnalysisListProvider = FutureProvider.autoDispose<List<AIImageAnalysis>>((ref) async {
  final service = ref.watch(aiImageAnalysisServiceProvider);
  
  // Watch for state changes
  ref.watch(aiImageAnalysisCreateStateProvider);
  ref.watch(aiImageAnalysisUpdateStateProvider);
  ref.watch(aiImageAnalysisDeleteStateProvider);
  
  return service.getAIImageAnalysiss();
});

// State Providers
final aiImageAnalysisCreateStateProvider = StateProvider<AIImageAnalysis?>((ref) => null);
final aiImageAnalysisUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiImageAnalysisDeleteStateProvider = StateProvider<String?>((ref) => null);

// Action Providers
final aiImageAnalysisCreateProvider = FutureProvider.autoDispose<AIImageAnalysis?>((ref) async {
  final service = ref.watch(aiImageAnalysisServiceProvider);
  final data = ref.watch(aiImageAnalysisCreateStateProvider);
  if (data == null) return null;
  return service.createAIImageAnalysis(data);
});

final aiImageAnalysisUpdateProvider = FutureProvider.autoDispose<AIImageAnalysis?>((ref) async {
  final service = ref.watch(aiImageAnalysisServiceProvider);
  final state = ref.watch(aiImageAnalysisUpdateStateProvider);
  if (state['id'] != null && state['ai_image_analysis'] != null) {
    return service.updateAIImageAnalysis(state['id'], state['ai_image_analysis']);
  }
  return null;
});

final aiImageAnalysisDeleteProvider = FutureProvider.autoDispose<bool>((ref) async {
  final service = ref.watch(aiImageAnalysisServiceProvider);
  final id = ref.watch(aiImageAnalysisDeleteStateProvider);
  if (id != null) {
    await service.deleteAIImageAnalysis(id);
    return true;
  }
  return false;
});

// Loading Provider
final aiImageAnalysisLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiImageAnalysisListProvider);
  final createAsync = ref.watch(aiImageAnalysisCreateProvider);
  final updateAsync = ref.watch(aiImageAnalysisUpdateProvider);
  final deleteAsync = ref.watch(aiImageAnalysisDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
