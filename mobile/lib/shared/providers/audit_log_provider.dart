import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/audit_log_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// AuditLog Providers

final auditLogServiceProvider = Provider<AuditLogService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuditLogService(dioClient);
});

// List Provider
final auditLogListProvider = FutureProvider.autoDispose<List<AuditLog>>((ref) async {
  final service = ref.watch(auditLogServiceProvider);
  return service.getAuditLogs();
});

// Create Provider
final auditLogCreateProvider = FutureProvider.autoDispose<AuditLog>((ref) async {
  final service = ref.watch(auditLogServiceProvider);
  return service.createAuditLog(AuditLog());
});

// Update Provider  
final auditLogUpdateProvider = FutureProvider.autoDispose<AuditLog>((ref) async {
  final service = ref.watch(auditLogServiceProvider);
  final state = ref.watch(auditLogUpdateStateProvider);
  if (state['id'] != null && state['audit_log'] != null) {
    return service.updateAuditLog(state['id'], state['audit_log']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final auditLogDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(auditLogServiceProvider);
  final state = ref.watch(auditLogDeleteStateProvider);
  if (state != null) {
    return service.deleteAuditLog(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final auditLogCreateStateProvider = StateProvider<AuditLog?>((ref) => null);
final auditLogUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final auditLogDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final auditLogLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(auditLogListProvider);
  final createAsync = ref.watch(auditLogCreateProvider);
  final updateAsync = ref.watch(auditLogUpdateProvider);
  final deleteAsync = ref.watch(auditLogDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
