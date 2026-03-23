import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tax_record_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// TaxRecord Providers

final TaxRecordServiceProvider = Provider<TaxRecordService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TaxRecordService(dioClient);
});

// List Provider
final taxRecordProvider = FutureProvider.autoDispose<List<TaxRecord>>((ref) async {
  final service = ref.watch(TaxRecordServiceProvider);
  return service.getTaxRecords();
});

// Create Provider
final TaxRecordCreateProvider = FutureProvider.autoDispose<TaxRecord>((ref) async {
  final service = ref.watch(TaxRecordServiceProvider);
  return service.createTaxRecord(TaxRecord());
});

// Update Provider  
final TaxRecordUpdateProvider = FutureProvider.autoDispose<TaxRecord>((ref) async {
  final service = ref.watch(TaxRecordServiceProvider);
  final state = ref.watch(TaxRecordUpdateStateProvider);
  if (state['id'] != null && state['tax_record'] != null) {
    return service.updateTaxRecord(state['id'], state['tax_record']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final TaxRecordDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(TaxRecordServiceProvider);
  final state = ref.watch(TaxRecordDeleteStateProvider);
  if (state != null) {
    return service.deleteTaxRecord(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final TaxRecordUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final TaxRecordDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final TaxRecordLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(taxRecordProvider);
  final createAsync = ref.watch(TaxRecordCreateProvider);
  final updateAsync = ref.watch(TaxRecordUpdateProvider);
  final deleteAsync = ref.watch(TaxRecordDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
