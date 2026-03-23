import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/compliance_record_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// ComplianceRecord Providers

final ComplianceRecordServiceProvider = Provider<ComplianceRecordService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ComplianceRecordService(dioClient);
});

// List Provider
final complianceRecordProvider = FutureProvider.autoDispose<List<ComplianceRecord>>((ref) async {
  final service = ref.watch(ComplianceRecordServiceProvider);
  return service.getComplianceRecords();
});

// Create Provider
final ComplianceRecordCreateProvider = FutureProvider.autoDispose<ComplianceRecord>((ref) async {
  final service = ref.watch(ComplianceRecordServiceProvider);
  return service.createComplianceRecord(ComplianceRecord());
});

// Update Provider  
final ComplianceRecordUpdateProvider = FutureProvider.autoDispose<ComplianceRecord>((ref) async {
  final service = ref.watch(ComplianceRecordServiceProvider);
  final state = ref.watch(ComplianceRecordUpdateStateProvider);
  if (state['id'] != null && state['compliance_record'] != null) {
    return service.updateComplianceRecord(state['id'], state['compliance_record']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ComplianceRecordDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ComplianceRecordServiceProvider);
  final state = ref.watch(ComplianceRecordDeleteStateProvider);
  if (state != null) {
    return service.deleteComplianceRecord(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ComplianceRecordUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ComplianceRecordDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ComplianceRecordLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(complianceRecordProvider);
  final createAsync = ref.watch(ComplianceRecordCreateProvider);
  final updateAsync = ref.watch(ComplianceRecordUpdateProvider);
  final deleteAsync = ref.watch(ComplianceRecordDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
