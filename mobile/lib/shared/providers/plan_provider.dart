import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/plan_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Plan Providers

final PlanServiceProvider = Provider<PlanService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PlanService(dioClient);
});

// List Provider
final planProvider = FutureProvider.autoDispose<List<Plan>>((ref) async {
  final service = ref.watch(PlanServiceProvider);
  return service.getPlans();
});

// Create Provider
final PlanCreateProvider = FutureProvider.autoDispose<Plan>((ref) async {
  final service = ref.watch(PlanServiceProvider);
  return service.createPlan(Plan());
});

// Update Provider  
final PlanUpdateProvider = FutureProvider.autoDispose<Plan>((ref) async {
  final service = ref.watch(PlanServiceProvider);
  final state = ref.watch(PlanUpdateStateProvider);
  if (state['id'] != null && state['plan'] != null) {
    return service.updatePlan(state['id'], state['plan']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PlanDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PlanServiceProvider);
  final state = ref.watch(PlanDeleteStateProvider);
  if (state != null) {
    return service.deletePlan(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PlanUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PlanDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PlanLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(planProvider);
  final createAsync = ref.watch(PlanCreateProvider);
  final updateAsync = ref.watch(PlanUpdateProvider);
  final deleteAsync = ref.watch(PlanDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
