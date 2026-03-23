import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/property_inventory_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// PropertyInventory Providers

final PropertyInventoryServiceProvider = Provider<PropertyInventoryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyInventoryService(dioClient);
});

// List Provider
final propertyInventoryProvider = FutureProvider.autoDispose<List<PropertyInventory>>((ref) async {
  final service = ref.watch(PropertyInventoryServiceProvider);
  return service.getPropertyInventorys();
});

// Create Provider
final PropertyInventoryCreateProvider = FutureProvider.autoDispose<PropertyInventory>((ref) async {
  final service = ref.watch(PropertyInventoryServiceProvider);
  return service.createPropertyInventory(PropertyInventory());
});

// Update Provider  
final PropertyInventoryUpdateProvider = FutureProvider.autoDispose<PropertyInventory>((ref) async {
  final service = ref.watch(PropertyInventoryServiceProvider);
  final state = ref.watch(PropertyInventoryUpdateStateProvider);
  if (state['id'] != null && state['property_inventory'] != null) {
    return service.updatePropertyInventory(state['id'], state['property_inventory']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final PropertyInventoryDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(PropertyInventoryServiceProvider);
  final state = ref.watch(PropertyInventoryDeleteStateProvider);
  if (state != null) {
    return service.deletePropertyInventory(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final PropertyInventoryUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final PropertyInventoryDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final PropertyInventoryLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(propertyInventoryProvider);
  final createAsync = ref.watch(PropertyInventoryCreateProvider);
  final updateAsync = ref.watch(PropertyInventoryUpdateProvider);
  final deleteAsync = ref.watch(PropertyInventoryDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
