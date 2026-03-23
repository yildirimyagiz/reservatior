import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/attorney_management_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AttorneyManagement Providers

final attorneyManagementServiceProvider = Provider<AttorneyManagementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AttorneyManagementService(dioClient);
});

// State Providers
final attorneyManagementCreateStateProvider = StateProvider<AttorneyManagement?>((ref) => null);
final attorneyManagementUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final attorneyManagementDeleteStateProvider = StateProvider<String?>((ref) => null);

// List Provider
final attorneyManagementListProvider = FutureProvider.autoDispose<List<AttorneyManagement>>((ref) async {
  final service = ref.watch(attorneyManagementServiceProvider);
  return service.getAttorneyManagements();
});

// Create Provider
final attorneyManagementCreateProvider = FutureProvider.autoDispose<AttorneyManagement?>((ref) async {
  final service = ref.watch(attorneyManagementServiceProvider);
  final state = ref.watch(attorneyManagementCreateStateProvider);
  if (state != null) {
    return service.createAttorneyManagement(state);
  }
  return null;
});

// Update Provider  
final attorneyManagementUpdateProvider = FutureProvider.autoDispose<AttorneyManagement?>((ref) async {
  final service = ref.watch(attorneyManagementServiceProvider);
  final state = ref.watch(attorneyManagementUpdateStateProvider);
  if (state['id'] != null && state['attorney_management'] != null) {
    return service.updateAttorneyManagement(state['id'], state['attorney_management']);
  }
  return null;
});

// Delete Provider
final attorneyManagementDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(attorneyManagementServiceProvider);
  final state = ref.watch(attorneyManagementDeleteStateProvider);
  if (state != null) {
    return service.deleteAttorneyManagement(state);
  }
});
// Loading Provider
final attorneyManagementLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(attorneyManagementListProvider);
  final createAsync = ref.watch(attorneyManagementCreateProvider);
  final updateAsync = ref.watch(attorneyManagementUpdateProvider);
  final deleteAsync = ref.watch(attorneyManagementDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
