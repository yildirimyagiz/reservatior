import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/tax1099_form_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Tax1099Form Providers

final Tax1099FormServiceProvider = Provider<Tax1099FormService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return Tax1099FormService(dioClient);
});

// List Provider
final tax1099FormProvider = FutureProvider.autoDispose<List<Tax1099Form>>((ref) async {
  final service = ref.watch(Tax1099FormServiceProvider);
  return service.getTax1099Forms();
});

// Create Provider
final Tax1099FormCreateProvider = FutureProvider.autoDispose<Tax1099Form>((ref) async {
  final service = ref.watch(Tax1099FormServiceProvider);
  return service.createTax1099Form(Tax1099Form());
});

// Update Provider  
final Tax1099FormUpdateProvider = FutureProvider.autoDispose<Tax1099Form>((ref) async {
  final service = ref.watch(Tax1099FormServiceProvider);
  final state = ref.watch(Tax1099FormUpdateStateProvider);
  if (state['id'] != null && state['tax1099_form'] != null) {
    return service.updateTax1099Form(state['id'], state['tax1099_form']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final Tax1099FormDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(Tax1099FormServiceProvider);
  final state = ref.watch(Tax1099FormDeleteStateProvider);
  if (state != null) {
    return service.deleteTax1099Form(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final Tax1099FormUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final Tax1099FormDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final Tax1099FormLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(tax1099FormProvider);
  final createAsync = ref.watch(Tax1099FormCreateProvider);
  final updateAsync = ref.watch(Tax1099FormUpdateProvider);
  final deleteAsync = ref.watch(Tax1099FormDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
