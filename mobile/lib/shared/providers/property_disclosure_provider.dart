import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_disclosure_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyDisclosure Providers

final PropertyDisclosureServiceProvider = Provider<PropertyDisclosureService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyDisclosureService(dioClient);
});

// List Provider
final propertyDisclosureProvider = FutureProvider.autoDispose<List<PropertyDisclosure>>((ref) async {
  final service = ref.watch(PropertyDisclosureServiceProvider);
  return service.getPropertyDisclosures();
});

// Create Provider
final PropertyDisclosureCreateProvider = FutureProvider.autoDispose<PropertyDisclosure>((ref) async {
  final service = ref.watch(PropertyDisclosureServiceProvider);
  return service.createPropertyDisclosure(PropertyDisclosure());
});

// Update Provider  
final PropertyDisclosureUpdateProvider = FutureProvider.autoDispose<PropertyDisclosure>((ref) async {
  final service = ref.watch(PropertyDisclosureServiceProvider);
  final state = ref.watch(PropertyDisclosureUpdateStateProvider);
  if (state['id'] != null && state['property_disclosure'] != null) {
    return service.updatePropertyDisclosure(state['id'], state['property_disclosure']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyDisclosureDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyDisclosureServiceProvider);
  final state = ref.watch(PropertyDisclosureDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyDisclosure(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyDisclosureUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyDisclosureDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyDisclosureLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyDisclosureProvider);
  final createAsync = ref.watch(PropertyDisclosureCreateProvider);
  final updateAsync = ref.watch(PropertyDisclosureUpdateProvider);
  final deleteAsync = ref.watch(PropertyDisclosureDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
