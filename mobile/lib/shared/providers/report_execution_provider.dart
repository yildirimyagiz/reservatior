import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/report_execution_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ReportExecution Providers

final ReportExecutionServiceProvider = Provider<ReportExecutionService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReportExecutionService(dioClient);
});

// List Provider
final reportExecutionProvider = FutureProvider.autoDispose<List<ReportExecution>>((ref) async {
  final service = ref.watch(ReportExecutionServiceProvider);
  return service.getReportExecutions();
});

// Create Provider
final ReportExecutionCreateProvider = FutureProvider.autoDispose<ReportExecution>((ref) async {
  final service = ref.watch(ReportExecutionServiceProvider);
  return service.createReportExecution(ReportExecution());
});

// Update Provider  
final ReportExecutionUpdateProvider = FutureProvider.autoDispose<ReportExecution>((ref) async {
  final service = ref.watch(ReportExecutionServiceProvider);
  final state = ref.watch(ReportExecutionUpdateStateProvider);
  if (state['id'] != null && state['report_execution'] != null) {
    return service.updateReportExecution(state['id'], state['report_execution']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ReportExecutionDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ReportExecutionServiceProvider);
  final state = ref.watch(ReportExecutionDeleteStateProvider);
  if (state != null) {
    return service.deleteReportExecution(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ReportExecutionUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ReportExecutionDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ReportExecutionLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(reportExecutionProvider);
  final createAsync = ref.watch(ReportExecutionCreateProvider);
  final updateAsync = ref.watch(ReportExecutionUpdateProvider);
  final deleteAsync = ref.watch(ReportExecutionDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
