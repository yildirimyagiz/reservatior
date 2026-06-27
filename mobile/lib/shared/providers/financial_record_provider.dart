import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/financial_record_service.dart';
import 'package:reservatior/shared/repositories/financial_record_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final financialRecordServiceProvider = Provider<FinancialRecordService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FinancialRecordService(dioClient);
});

final financialRecordRepositoryProvider = Provider<FinancialRecordRepository>((ref) {
  final service = ref.watch(financialRecordServiceProvider);
  return FinancialRecordRepositoryImpl(service);
});

final financialRecordListProvider = FutureProvider.autoDispose<List<FinancialRecord>>((ref) async {
  final repository = ref.watch(financialRecordRepositoryProvider);
  return repository.getAll();
});

final financialRecordCreateProvider = StateProvider<FinancialRecord?>((ref) => null);
final financialRecordUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final financialRecordDeleteProvider = StateProvider<String?>((ref) => null);
final financialRecordLoadingProvider = StateProvider<bool>((ref) => false);
