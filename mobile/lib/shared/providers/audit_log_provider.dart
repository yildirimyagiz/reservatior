import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/audit_log_service.dart';
import 'package:reservatior/shared/repositories/audit_log_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final auditLogServiceProvider = Provider<AuditLogService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AuditLogService(dioClient);
});

final auditLogRepositoryProvider = Provider<AuditLogRepository>((ref) {
  final service = ref.watch(auditLogServiceProvider);
  return AuditLogRepositoryImpl(service);
});

final auditLogListProvider = FutureProvider.autoDispose<List<AuditLog>>((ref) async {
  final repository = ref.watch(auditLogRepositoryProvider);
  return repository.getAll();
});

final auditLogCreateProvider = StateProvider<AuditLog?>((ref) => null);
final auditLogUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final auditLogDeleteProvider = StateProvider<String?>((ref) => null);
final auditLogLoadingProvider = StateProvider<bool>((ref) => false);
