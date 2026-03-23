import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/export_file_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ExportFile Providers

final ExportFileServiceProvider = Provider<ExportFileService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ExportFileService(dioClient);
});

// List Provider
final exportFileProvider = FutureProvider.autoDispose<List<ExportFile>>((ref) async {
  final service = ref.watch(ExportFileServiceProvider);
  return service.getExportFiles();
});

// Create Provider
final ExportFileCreateProvider = FutureProvider.autoDispose<ExportFile>((ref) async {
  final service = ref.watch(ExportFileServiceProvider);
  return service.createExportFile(ExportFile());
});

// Update Provider  
final ExportFileUpdateProvider = FutureProvider.autoDispose<ExportFile>((ref) async {
  final service = ref.watch(ExportFileServiceProvider);
  final state = ref.watch(ExportFileUpdateStateProvider);
  if (state['id'] != null && state['export_file'] != null) {
    return service.updateExportFile(state['id'], state['export_file']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ExportFileDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ExportFileServiceProvider);
  final state = ref.watch(ExportFileDeleteStateProvider);
  if (state != null) {
    return service.deleteExportFile(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ExportFileUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ExportFileDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ExportFileLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(exportFileProvider);
  final createAsync = ref.watch(ExportFileCreateProvider);
  final updateAsync = ref.watch(ExportFileUpdateProvider);
  final deleteAsync = ref.watch(ExportFileDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
