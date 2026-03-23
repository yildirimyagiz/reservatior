import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/project_analytics_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ProjectAnalytics Providers

final ProjectAnalyticsServiceProvider = Provider<ProjectAnalyticsService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProjectAnalyticsService(dioClient);
});

// List Provider
final projectAnalyticsProvider = FutureProvider.autoDispose<List<ProjectAnalytics>>((ref) async {
  final service = ref.watch(ProjectAnalyticsServiceProvider);
  return service.getProjectAnalyticss();
});

// Create Provider
final ProjectAnalyticsCreateProvider = FutureProvider.autoDispose<ProjectAnalytics>((ref) async {
  final service = ref.watch(ProjectAnalyticsServiceProvider);
  return service.createProjectAnalytics(ProjectAnalytics());
});

// Update Provider  
final ProjectAnalyticsUpdateProvider = FutureProvider.autoDispose<ProjectAnalytics>((ref) async {
  final service = ref.watch(ProjectAnalyticsServiceProvider);
  final state = ref.watch(ProjectAnalyticsUpdateStateProvider);
  if (state['id'] != null && state['project_analytics'] != null) {
    return service.updateProjectAnalytics(state['id'], state['project_analytics']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ProjectAnalyticsDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ProjectAnalyticsServiceProvider);
  final state = ref.watch(ProjectAnalyticsDeleteStateProvider);
  if (state != null) {
    return service.deleteProjectAnalytics(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ProjectAnalyticsUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ProjectAnalyticsDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ProjectAnalyticsLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(projectAnalyticsProvider);
  final createAsync = ref.watch(ProjectAnalyticsCreateProvider);
  final updateAsync = ref.watch(ProjectAnalyticsUpdateProvider);
  final deleteAsync = ref.watch(ProjectAnalyticsDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
