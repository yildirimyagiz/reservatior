import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_model_deployment_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// aiModelDeployment Providers

final aiModelDeploymentServiceProvider = Provider<aiModelDeploymentService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return aiModelDeploymentService(dioClient);
});

// List Provider
final aiModelDeploymentListProvider = FutureProvider.autoDispose<List<aiModelDeployment>>((ref) async {
  final service = ref.watch(aiModelDeploymentServiceProvider);
  return service.getaiModelDeployments();
});

// Create Provider
final aiModelDeploymentCreateProvider = FutureProvider.autoDispose<aiModelDeployment>((ref) async {
  final service = ref.watch(aiModelDeploymentServiceProvider);
  return service.createaiModelDeployment(aiModelDeployment());
});

// Update Provider  
final aiModelDeploymentUpdateProvider = FutureProvider.autoDispose<aiModelDeployment>((ref) async {
  final service = ref.watch(aiModelDeploymentServiceProvider);
  final state = ref.watch(aiModelDeploymentUpdateStateProvider);
  if (state['id'] != null && state['ai_model_deployment'] != null) {
    return service.updateaiModelDeployment(state['id'], state['ai_model_deployment']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final aiModelDeploymentDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiModelDeploymentServiceProvider);
  final state = ref.watch(aiModelDeploymentDeleteStateProvider);
  if (state != null) {
    return service.deleteaiModelDeployment(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final aiModelDeploymentCreateStateProvider = StateProvider<AIModelDeployment?>((ref) => null);
final aiModelDeploymentUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiModelDeploymentDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final aiModelDeploymentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiModelDeploymentListProvider);
  final createAsync = ref.watch(aiModelDeploymentCreateProvider);
  final updateAsync = ref.watch(aiModelDeploymentUpdateProvider);
  final deleteAsync = ref.watch(aiModelDeploymentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});

// Loading Provider
final aiModelDeploymentLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiModelDeploymentListProvider);
  final createAsync = ref.watch(aiModelDeploymentCreateProvider);
  final updateAsync = ref.watch(aiModelDeploymentUpdateProvider);
  final deleteAsync = ref.watch(aiModelDeploymentDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
