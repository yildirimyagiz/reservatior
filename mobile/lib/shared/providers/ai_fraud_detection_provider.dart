import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_fraud_detection_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';


final aiFraudDetectionServiceProvider = Provider<AIFraudDetectionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AIFraudDetectionService(dioClient);
});

// List Provider
final aiFraudDetectionListProvider = FutureProvider.autoDispose<List<AIFraudDetection>>((ref) async {
  final service = ref.watch(aiFraudDetectionServiceProvider);
  
  // Watch for state changes to trigger refresh
  ref.watch(aiFraudDetectionCreateStateProvider);
  ref.watch(aiFraudDetectionUpdateStateProvider);
  ref.watch(aiFraudDetectionDeleteStateProvider);
  
  return service.getAIFraudDetections();
});

// State Providers for Side Effects
final aiFraudDetectionCreateStateProvider = StateProvider<AIFraudDetection?>((ref) => null);
final aiFraudDetectionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiFraudDetectionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Action Providers
final aiFraudDetectionCreateProvider = FutureProvider.autoDispose<AIFraudDetection?>((ref) async {
  final service = ref.watch(aiFraudDetectionServiceProvider);
  final newDetection = ref.watch(aiFraudDetectionCreateStateProvider);
  
  if (newDetection == null) return null;
  
  return service.createAIFraudDetection(newDetection);
});

final aiFraudDetectionUpdateProvider = FutureProvider.autoDispose<AIFraudDetection?>((ref) async {
  final service = ref.watch(aiFraudDetectionServiceProvider);
  final state = ref.watch(aiFraudDetectionUpdateStateProvider);
  
  if (state['id'] != null && state['aiFraudDetection'] != null) {
    return service.updateAIFraudDetection(state['id'], state['aiFraudDetection']);
  }
  return null;
});

final aiFraudDetectionDeleteProvider = FutureProvider.autoDispose<bool>((ref) async {
  final service = ref.watch(aiFraudDetectionServiceProvider);
  final id = ref.watch(aiFraudDetectionDeleteStateProvider);
  
  if (id != null) {
    await service.deleteAIFraudDetection(id);
    return true;
  }
  return false;
});

// Loading Provider
final aiFraudDetectionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiFraudDetectionListProvider);
  final createAsync = ref.watch(aiFraudDetectionCreateProvider);
  final updateAsync = ref.watch(aiFraudDetectionUpdateProvider);
  final deleteAsync = ref.watch(aiFraudDetectionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
