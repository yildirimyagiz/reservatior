import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/report_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Report Providers

final ReportServiceProvider = Provider<ReportService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ReportService(dioClient);
});

// List Provider
final reportProvider = FutureProvider.autoDispose<List<Report>>((ref) async {
  final service = ref.watch(ReportServiceProvider);
  return service.getReports();
});

// Create Provider
final ReportCreateProvider = FutureProvider.autoDispose<Report>((ref) async {
  final service = ref.watch(ReportServiceProvider);
  return service.createReport(Report());
});

// Update Provider  
final ReportUpdateProvider = FutureProvider.autoDispose<Report>((ref) async {
  final service = ref.watch(ReportServiceProvider);
  final state = ref.watch(ReportUpdateStateProvider);
  if (state['id'] != null && state['report'] != null) {
    return service.updateReport(state['id'], state['report']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ReportDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ReportServiceProvider);
  final state = ref.watch(ReportDeleteStateProvider);
  if (state != null) {
    return service.deleteReport(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ReportUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ReportDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ReportLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(reportProvider);
  final createAsync = ref.watch(ReportCreateProvider);
  final updateAsync = ref.watch(ReportUpdateProvider);
  final deleteAsync = ref.watch(ReportDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
