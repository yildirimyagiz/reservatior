import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/solicitor_management_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// SolicitorManagement Providers

final SolicitorManagementServiceProvider = Provider<SolicitorManagementService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return SolicitorManagementService(dioClient);
});

// List Provider
final solicitorManagementProvider = FutureProvider.autoDispose<List<SolicitorManagement>>((ref) async {
  final service = ref.watch(SolicitorManagementServiceProvider);
  return service.getSolicitorManagements();
});

// Create Provider
final SolicitorManagementCreateProvider = FutureProvider.autoDispose<SolicitorManagement>((ref) async {
  final service = ref.watch(SolicitorManagementServiceProvider);
  return service.createSolicitorManagement(SolicitorManagement());
});

// Update Provider  
final SolicitorManagementUpdateProvider = FutureProvider.autoDispose<SolicitorManagement>((ref) async {
  final service = ref.watch(SolicitorManagementServiceProvider);
  final state = ref.watch(SolicitorManagementUpdateStateProvider);
  if (state['id'] != null && state['solicitor_management'] != null) {
    return service.updateSolicitorManagement(state['id'], state['solicitor_management']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final SolicitorManagementDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(SolicitorManagementServiceProvider);
  final state = ref.watch(SolicitorManagementDeleteStateProvider);
  if (state != null) {
    return service.deleteSolicitorManagement(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final SolicitorManagementUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final SolicitorManagementDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final SolicitorManagementLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(solicitorManagementProvider);
  final createAsync = ref.watch(SolicitorManagementCreateProvider);
  final updateAsync = ref.watch(SolicitorManagementUpdateProvider);
  final deleteAsync = ref.watch(SolicitorManagementDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
