import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/project_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Project Providers

final ProjectServiceProvider = Provider<ProjectService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProjectService(dioClient);
});

// List Provider
final projectProvider = FutureProvider.autoDispose<List<Project>>((ref) async {
  final service = ref.watch(ProjectServiceProvider);
  return service.getProjects();
});

// Create Provider
final ProjectCreateProvider = FutureProvider.autoDispose<Project>((ref) async {
  final service = ref.watch(ProjectServiceProvider);
  return service.createProject(Project());
});

// Update Provider  
final ProjectUpdateProvider = FutureProvider.autoDispose<Project>((ref) async {
  final service = ref.watch(ProjectServiceProvider);
  final state = ref.watch(ProjectUpdateStateProvider);
  if (state['id'] != null && state['project'] != null) {
    return service.updateProject(state['id'], state['project']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ProjectDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ProjectServiceProvider);
  final state = ref.watch(ProjectDeleteStateProvider);
  if (state != null) {
    return service.deleteProject(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ProjectUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ProjectDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ProjectLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(projectProvider);
  final createAsync = ref.watch(ProjectCreateProvider);
  final updateAsync = ref.watch(ProjectUpdateProvider);
  final deleteAsync = ref.watch(ProjectDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
