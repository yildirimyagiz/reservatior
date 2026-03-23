import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/commission_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Commission Providers

final CommissionServiceProvider = Provider<CommissionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return CommissionService(dioClient);
});

// List Provider
final commissionProvider = FutureProvider.autoDispose<List<Commission>>((ref) async {
  final service = ref.watch(CommissionServiceProvider);
  return service.getCommissions();
});

// Create Provider
final CommissionCreateProvider = FutureProvider.autoDispose<Commission>((ref) async {
  final service = ref.watch(CommissionServiceProvider);
  return service.createCommission(Commission());
});

// Update Provider  
final CommissionUpdateProvider = FutureProvider.autoDispose<Commission>((ref) async {
  final service = ref.watch(CommissionServiceProvider);
  final state = ref.watch(CommissionUpdateStateProvider);
  if (state['id'] != null && state['commission'] != null) {
    return service.updateCommission(state['id'], state['commission']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final CommissionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(CommissionServiceProvider);
  final state = ref.watch(CommissionDeleteStateProvider);
  if (state != null) {
    return service.deleteCommission(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final CommissionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final CommissionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final CommissionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(commissionProvider);
  final createAsync = ref.watch(CommissionCreateProvider);
  final updateAsync = ref.watch(CommissionUpdateProvider);
  final deleteAsync = ref.watch(CommissionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
