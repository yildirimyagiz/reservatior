import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tax_depreciation_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// TaxDepreciation Providers

final TaxDepreciationServiceProvider = Provider<TaxDepreciationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TaxDepreciationService(dioClient);
});

// List Provider
final taxDepreciationProvider = FutureProvider.autoDispose<List<TaxDepreciation>>((ref) async {
  final service = ref.watch(TaxDepreciationServiceProvider);
  return service.getTaxDepreciations();
});

// Create Provider
final TaxDepreciationCreateProvider = FutureProvider.autoDispose<TaxDepreciation>((ref) async {
  final service = ref.watch(TaxDepreciationServiceProvider);
  return service.createTaxDepreciation(TaxDepreciation());
});

// Update Provider  
final TaxDepreciationUpdateProvider = FutureProvider.autoDispose<TaxDepreciation>((ref) async {
  final service = ref.watch(TaxDepreciationServiceProvider);
  final state = ref.watch(TaxDepreciationUpdateStateProvider);
  if (state['id'] != null && state['tax_depreciation'] != null) {
    return service.updateTaxDepreciation(state['id'], state['tax_depreciation']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final TaxDepreciationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(TaxDepreciationServiceProvider);
  final state = ref.watch(TaxDepreciationDeleteStateProvider);
  if (state != null) {
    return service.deleteTaxDepreciation(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final TaxDepreciationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final TaxDepreciationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final TaxDepreciationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(taxDepreciationProvider);
  final createAsync = ref.watch(TaxDepreciationCreateProvider);
  final updateAsync = ref.watch(TaxDepreciationUpdateProvider);
  final deleteAsync = ref.watch(TaxDepreciationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
