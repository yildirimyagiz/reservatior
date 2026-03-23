import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/aiPredictiveMaintenanceService.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// aiPredictiveMaintenance Providers

final aiPredictiveMaintenanceServiceProvider = Provider<aiPredictiveMaintenanceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return aiPredictiveMaintenanceService(dioClient);
});

// List Provider
final aiPredictiveMaintenanceListProvider = FutureProvider.autoDispose<List<AIPredictiveMaintenance>>((ref) async {
  final service = ref.watch(aiPredictiveMaintenanceServiceProvider);
  return service.getAIPredictiveMaintenances();
});

// Create Provider
final aiPredictiveMaintenanceCreateProvider = FutureProvider.autoDispose<AIPredictiveMaintenance>((ref) async {
  final service = ref.watch(aiPredictiveMaintenanceServiceProvider);
  return service.createAIPredictiveMaintenance(AIPredictiveMaintenance());
});

// Update Provider  
final aiPredictiveMaintenanceUpdateProvider = FutureProvider.autoDispose<AIPredictiveMaintenance>((ref) async {
  final service = ref.watch(aiPredictiveMaintenanceServiceProvider);
  final state = ref.watch(aiPredictiveMaintenanceUpdateStateProvider);
  if (state['id'] != null && state['ai_predictive_maintenance'] != null) {
    return service.updateAIPredictiveMaintenance(state['id'], state['ai_predictive_maintenance']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final aiPredictiveMaintenanceDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiPredictiveMaintenanceServiceProvider);
  final state = ref.watch(aiPredictiveMaintenanceDeleteStateProvider);
  if (state != null) {
    return service.deleteAIPredictiveMaintenance(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final aiPredictiveMaintenanceCreateStateProvider = StateProvider<AIPredictiveMaintenance?>((ref) => null);

final aiPredictiveMaintenanceUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiPredictiveMaintenanceDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final aiPredictiveMaintenanceLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiPredictiveMaintenanceListProvider);
  final createAsync = ref.watch(aiPredictiveMaintenanceCreateProvider);
  final updateAsync = ref.watch(aiPredictiveMaintenanceUpdateProvider);
  final deleteAsync = ref.watch(aiPredictiveMaintenanceDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
