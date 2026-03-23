import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/export_job_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ExportJob Providers

final ExportJobServiceProvider = Provider<ExportJobService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExportJobService(dioClient);
});

// List Provider
final exportJobProvider = FutureProvider.autoDispose<List<ExportJob>>((ref) async {
  final service = ref.watch(ExportJobServiceProvider);
  return service.getExportJobs();
});

// Create Provider
final ExportJobCreateProvider = FutureProvider.autoDispose<ExportJob>((ref) async {
  final service = ref.watch(ExportJobServiceProvider);
  return service.createExportJob(ExportJob());
});

// Update Provider  
final ExportJobUpdateProvider = FutureProvider.autoDispose<ExportJob>((ref) async {
  final service = ref.watch(ExportJobServiceProvider);
  final state = ref.watch(ExportJobUpdateStateProvider);
  if (state['id'] != null && state['export_job'] != null) {
    return service.updateExportJob(state['id'], state['export_job']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ExportJobDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ExportJobServiceProvider);
  final state = ref.watch(ExportJobDeleteStateProvider);
  if (state != null) {
    return service.deleteExportJob(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ExportJobUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ExportJobDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ExportJobLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(exportJobProvider);
  final createAsync = ref.watch(ExportJobCreateProvider);
  final updateAsync = ref.watch(ExportJobUpdateProvider);
  final deleteAsync = ref.watch(ExportJobDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
