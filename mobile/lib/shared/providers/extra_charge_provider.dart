import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/extra_charge_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ExtraCharge Providers

final ExtraChargeServiceProvider = Provider<ExtraChargeService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExtraChargeService(dioClient);
});

// List Provider
final extraChargeProvider = FutureProvider.autoDispose<List<ExtraCharge>>((ref) async {
  final service = ref.watch(ExtraChargeServiceProvider);
  return service.getExtraCharges();
});

// Create Provider
final ExtraChargeCreateProvider = FutureProvider.autoDispose<ExtraCharge>((ref) async {
  final service = ref.watch(ExtraChargeServiceProvider);
  return service.createExtraCharge(ExtraCharge());
});

// Update Provider  
final ExtraChargeUpdateProvider = FutureProvider.autoDispose<ExtraCharge>((ref) async {
  final service = ref.watch(ExtraChargeServiceProvider);
  final state = ref.watch(ExtraChargeUpdateStateProvider);
  if (state['id'] != null && state['extra_charge'] != null) {
    return service.updateExtraCharge(state['id'], state['extra_charge']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ExtraChargeDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ExtraChargeServiceProvider);
  final state = ref.watch(ExtraChargeDeleteStateProvider);
  if (state != null) {
    return service.deleteExtraCharge(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ExtraChargeUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ExtraChargeDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ExtraChargeLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(extraChargeProvider);
  final createAsync = ref.watch(ExtraChargeCreateProvider);
  final updateAsync = ref.watch(ExtraChargeUpdateProvider);
  final deleteAsync = ref.watch(ExtraChargeDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
