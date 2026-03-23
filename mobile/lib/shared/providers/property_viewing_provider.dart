import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_viewing_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyViewing Providers

final PropertyViewingServiceProvider = Provider<PropertyViewingService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyViewingService(dioClient);
});

// List Provider
final propertyViewingProvider = FutureProvider.autoDispose<List<PropertyViewing>>((ref) async {
  final service = ref.watch(PropertyViewingServiceProvider);
  return service.getPropertyViewings();
});

// Create Provider
final PropertyViewingCreateProvider = FutureProvider.autoDispose<PropertyViewing>((ref) async {
  final service = ref.watch(PropertyViewingServiceProvider);
  return service.createPropertyViewing(PropertyViewing());
});

// Update Provider  
final PropertyViewingUpdateProvider = FutureProvider.autoDispose<PropertyViewing>((ref) async {
  final service = ref.watch(PropertyViewingServiceProvider);
  final state = ref.watch(PropertyViewingUpdateStateProvider);
  if (state['id'] != null && state['property_viewing'] != null) {
    return service.updatePropertyViewing(state['id'], state['property_viewing']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyViewingDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyViewingServiceProvider);
  final state = ref.watch(PropertyViewingDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyViewing(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyViewingUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyViewingDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyViewingLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyViewingProvider);
  final createAsync = ref.watch(PropertyViewingCreateProvider);
  final updateAsync = ref.watch(PropertyViewingUpdateProvider);
  final deleteAsync = ref.watch(PropertyViewingDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
