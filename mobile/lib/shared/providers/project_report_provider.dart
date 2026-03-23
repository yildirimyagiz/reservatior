import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/project_report_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ProjectReport Providers

final ProjectReportServiceProvider = Provider<ProjectReportService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ProjectReportService(dioClient);
});

// List Provider
final projectReportProvider = FutureProvider.autoDispose<List<ProjectReport>>((ref) async {
  final service = ref.watch(ProjectReportServiceProvider);
  return service.getProjectReports();
});

// Create Provider
final ProjectReportCreateProvider = FutureProvider.autoDispose<ProjectReport>((ref) async {
  final service = ref.watch(ProjectReportServiceProvider);
  return service.createProjectReport(ProjectReport());
});

// Update Provider  
final ProjectReportUpdateProvider = FutureProvider.autoDispose<ProjectReport>((ref) async {
  final service = ref.watch(ProjectReportServiceProvider);
  final state = ref.watch(ProjectReportUpdateStateProvider);
  if (state['id'] != null && state['project_report'] != null) {
    return service.updateProjectReport(state['id'], state['project_report']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ProjectReportDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ProjectReportServiceProvider);
  final state = ref.watch(ProjectReportDeleteStateProvider);
  if (state != null) {
    return service.deleteProjectReport(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ProjectReportUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ProjectReportDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ProjectReportLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(projectReportProvider);
  final createAsync = ref.watch(ProjectReportCreateProvider);
  final updateAsync = ref.watch(ProjectReportUpdateProvider);
  final deleteAsync = ref.watch(ProjectReportDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
