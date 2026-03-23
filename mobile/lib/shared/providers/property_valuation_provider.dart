import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_valuation_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyValuation Providers

final PropertyValuationServiceProvider = Provider<PropertyValuationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyValuationService(dioClient);
});

// List Provider
final propertyValuationProvider = FutureProvider.autoDispose<List<PropertyValuation>>((ref) async {
  final service = ref.watch(PropertyValuationServiceProvider);
  return service.getPropertyValuations();
});

// Create Provider
final PropertyValuationCreateProvider = FutureProvider.autoDispose<PropertyValuation>((ref) async {
  final service = ref.watch(PropertyValuationServiceProvider);
  return service.createPropertyValuation(PropertyValuation());
});

// Update Provider  
final PropertyValuationUpdateProvider = FutureProvider.autoDispose<PropertyValuation>((ref) async {
  final service = ref.watch(PropertyValuationServiceProvider);
  final state = ref.watch(PropertyValuationUpdateStateProvider);
  if (state['id'] != null && state['property_valuation'] != null) {
    return service.updatePropertyValuation(state['id'], state['property_valuation']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyValuationDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyValuationServiceProvider);
  final state = ref.watch(PropertyValuationDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyValuation(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyValuationUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyValuationDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyValuationLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyValuationProvider);
  final createAsync = ref.watch(PropertyValuationCreateProvider);
  final updateAsync = ref.watch(PropertyValuationUpdateProvider);
  final deleteAsync = ref.watch(PropertyValuationDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
