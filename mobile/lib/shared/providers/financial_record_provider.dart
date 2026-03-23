import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/financial_record_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// FinancialRecord Providers

final FinancialRecordServiceProvider = Provider<FinancialRecordService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return FinancialRecordService(dioClient);
});

// List Provider
final financialRecordProvider = FutureProvider.autoDispose<List<FinancialRecord>>((ref) async {
  final service = ref.watch(FinancialRecordServiceProvider);
  return service.getFinancialRecords();
});

// Create Provider
final FinancialRecordCreateProvider = FutureProvider.autoDispose<FinancialRecord>((ref) async {
  final service = ref.watch(FinancialRecordServiceProvider);
  return service.createFinancialRecord(FinancialRecord());
});

// Update Provider  
final FinancialRecordUpdateProvider = FutureProvider.autoDispose<FinancialRecord>((ref) async {
  final service = ref.watch(FinancialRecordServiceProvider);
  final state = ref.watch(FinancialRecordUpdateStateProvider);
  if (state['id'] != null && state['financial_record'] != null) {
    return service.updateFinancialRecord(state['id'], state['financial_record']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final FinancialRecordDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(FinancialRecordServiceProvider);
  final state = ref.watch(FinancialRecordDeleteStateProvider);
  if (state != null) {
    return service.deleteFinancialRecord(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final FinancialRecordUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final FinancialRecordDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final FinancialRecordLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(financialRecordProvider);
  final createAsync = ref.watch(FinancialRecordCreateProvider);
  final updateAsync = ref.watch(FinancialRecordUpdateProvider);
  final deleteAsync = ref.watch(FinancialRecordDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
