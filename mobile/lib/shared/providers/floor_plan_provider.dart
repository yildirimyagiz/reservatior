import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/floor_plan_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// FloorPlan Providers

final FloorPlanServiceProvider = Provider<FloorPlanService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FloorPlanService(dioClient);
});

// List Provider
final floorPlanProvider = FutureProvider.autoDispose<List<FloorPlan>>((ref) async {
  final service = ref.watch(FloorPlanServiceProvider);
  return service.getFloorPlans();
});

// Create Provider
final FloorPlanCreateProvider = FutureProvider.autoDispose<FloorPlan>((ref) async {
  final service = ref.watch(FloorPlanServiceProvider);
  return service.createFloorPlan(FloorPlan());
});

// Update Provider  
final FloorPlanUpdateProvider = FutureProvider.autoDispose<FloorPlan>((ref) async {
  final service = ref.watch(FloorPlanServiceProvider);
  final state = ref.watch(FloorPlanUpdateStateProvider);
  if (state['id'] != null && state['floor_plan'] != null) {
    return service.updateFloorPlan(state['id'], state['floor_plan']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final FloorPlanDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(FloorPlanServiceProvider);
  final state = ref.watch(FloorPlanDeleteStateProvider);
  if (state != null) {
    return service.deleteFloorPlan(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final FloorPlanUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final FloorPlanDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final FloorPlanLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(floorPlanProvider);
  final createAsync = ref.watch(FloorPlanCreateProvider);
  final updateAsync = ref.watch(FloorPlanUpdateProvider);
  final deleteAsync = ref.watch(FloorPlanDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
