import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/compliance_record_service.dart';
import 'package:reservatior/shared/repositories/compliance_record_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final complianceRecordServiceProvider = Provider<ComplianceRecordService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ComplianceRecordService(dioClient);
});

final complianceRecordRepositoryProvider = Provider<ComplianceRecordRepository>((ref) {
  final service = ref.watch(complianceRecordServiceProvider);
  return ComplianceRecordRepositoryImpl(service);
});

final complianceRecordListProvider = FutureProvider.autoDispose<List<ComplianceRecord>>((ref) async {
  final repository = ref.watch(complianceRecordRepositoryProvider);
  return repository.getAll();
});

final complianceRecordCreateProvider = StateProvider<ComplianceRecord?>((ref) => null);
final complianceRecordUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final complianceRecordDeleteProvider = StateProvider<String?>((ref) => null);
final complianceRecordLoadingProvider = StateProvider<bool>((ref) => false);
