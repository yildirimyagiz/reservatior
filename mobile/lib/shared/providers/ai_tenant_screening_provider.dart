import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ai_tenant_screening_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AITenantScreening Providers

final aiTenantScreeningServiceProvider = Provider<AITenantScreeningService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AITenantScreeningService(dioClient);
});

// List Provider
final aiTenantScreeningListProvider = FutureProvider.autoDispose<List<AITenantScreening>>((ref) async {
  final service = ref.watch(aiTenantScreeningServiceProvider);
  return service.getAITenantScreenings();
});

// State Providers for create/update/delete
final aiTenantScreeningCreateStateProvider = StateProvider<AITenantScreening?>((ref) => null);
final aiTenantScreeningUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final aiTenantScreeningDeleteStateProvider = StateProvider<String?>((ref) => null);

// Create Provider
final aiTenantScreeningCreateProvider = FutureProvider.autoDispose<AITenantScreening?>((ref) async {
  final service = ref.watch(aiTenantScreeningServiceProvider);
  final state = ref.watch(aiTenantScreeningCreateStateProvider);
  if (state != null) {
    return service.createAITenantScreening(state);
  }
  return null;
});

// Update Provider  
final aiTenantScreeningUpdateProvider = FutureProvider.autoDispose<AITenantScreening?>((ref) async {
  final service = ref.watch(aiTenantScreeningServiceProvider);
  final state = ref.watch(aiTenantScreeningUpdateStateProvider);
  if (state['id'] != null && state['ai_tenant_screening'] != null) {
    return service.updateAITenantScreening(state['id'], state['ai_tenant_screening']);
  }
  return null;
});

// Delete Provider
final aiTenantScreeningDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(aiTenantScreeningServiceProvider);
  final state = ref.watch(aiTenantScreeningDeleteStateProvider);
  if (state != null) {
    return service.deleteAITenantScreening(state);
  }
});

// Loading Provider
final aiTenantScreeningLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(aiTenantScreeningListProvider);
  return listAsync.isLoading;
});
