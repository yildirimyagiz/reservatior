import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/aiPropertyDescriptionService.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// aiPropertyDescription Providers

final aiPropertyDescriptionServiceProvider = Provider<aiPropertyDescriptionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return aiPropertyDescriptionService(dioClient);
});

// List Provider
final aiPropertyDescriptionListProvider = FutureProvider.autoDispose<List<AIPropertyDescription>>((ref) async {
  final service = ref.watch(aiPropertyDescriptionServiceProvider);
  return service.getAIPropertyDescriptions();
});

// Create Provider
final aiPropertyDescriptionCreateProvider = FutureProvider.autoDispose<AIPropertyDescription>((ref) async {
  final service = ref.watch(aiPropertyDescriptionServiceProvider);
  return service.createAIPropertyDescription(AIPropertyDescription());
});

// Update Provider  
final aiPropertyDescriptionUpdateProvider = FutureProvider.autoDispose<AIPropertyDescription>((ref) async {
  final service = ref.watch(aiPropertyDescriptionServiceProvider);
  final state = ref.watch(aiPropertyDescriptionUpdateStateProvider);
  if (state['id'] != null && state['ai_property_description'] != null) {
    return service.updateAIPropertyDescription(state['id'], state['ai_property_description']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final aiPropertyDescriptionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiPropertyDescriptionServiceProvider);
  final state = ref.watch(aiPropertyDescriptionDeleteStateProvider);
  if (state != null) {
    return service.deleteAIPropertyDescription(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final aiPropertyDescriptionCreateStateProvider = StateProvider<AIPropertyDescription?>((ref) => null);

final aiPropertyDescriptionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPropertyDescriptionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final aiPropertyDescriptionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiPropertyDescriptionListProvider);
  final createAsync = ref.watch(aiPropertyDescriptionCreateProvider);
  final updateAsync = ref.watch(aiPropertyDescriptionUpdateProvider);
  final deleteAsync = ref.watch(aiPropertyDescriptionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
