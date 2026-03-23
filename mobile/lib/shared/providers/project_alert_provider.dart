import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/project_alert_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ProjectAlert Providers

final ProjectAlertServiceProvider = Provider<ProjectAlertService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProjectAlertService(dioClient);
});

// List Provider
final projectAlertProvider = FutureProvider.autoDispose<List<ProjectAlert>>((ref) async {
  final service = ref.watch(ProjectAlertServiceProvider);
  return service.getProjectAlerts();
});

// Create Provider
final ProjectAlertCreateProvider = FutureProvider.autoDispose<ProjectAlert>((ref) async {
  final service = ref.watch(ProjectAlertServiceProvider);
  return service.createProjectAlert(ProjectAlert());
});

// Update Provider  
final ProjectAlertUpdateProvider = FutureProvider.autoDispose<ProjectAlert>((ref) async {
  final service = ref.watch(ProjectAlertServiceProvider);
  final state = ref.watch(ProjectAlertUpdateStateProvider);
  if (state['id'] != null && state['project_alert'] != null) {
    return service.updateProjectAlert(state['id'], state['project_alert']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ProjectAlertDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ProjectAlertServiceProvider);
  final state = ref.watch(ProjectAlertDeleteStateProvider);
  if (state != null) {
    return service.deleteProjectAlert(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ProjectAlertUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ProjectAlertDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ProjectAlertLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(projectAlertProvider);
  final createAsync = ref.watch(ProjectAlertCreateProvider);
  final updateAsync = ref.watch(ProjectAlertUpdateProvider);
  final deleteAsync = ref.watch(ProjectAlertDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
