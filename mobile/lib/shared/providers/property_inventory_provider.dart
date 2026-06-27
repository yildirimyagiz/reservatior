import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_inventory_service.dart';
import 'package:reservatior/shared/repositories/property_inventory_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final propertyInventoryServiceProvider = Provider<PropertyInventoryService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyInventoryService(dioClient);
});

final propertyInventoryRepositoryProvider = Provider<PropertyInventoryRepository>((ref) {
  final service = ref.watch(propertyInventoryServiceProvider);
  return PropertyInventoryRepositoryImpl(service);
});

final propertyInventoryListProvider = FutureProvider.autoDispose.family<List<PropertyInventory>, String>((ref, propertyId) async {
  final repository = ref.watch(propertyInventoryRepositoryProvider);
  return repository.getAll(filters: {'propertyId': propertyId});
});

final propertyInventoryCreateProvider = StateProvider<PropertyInventory?>((ref) => null);
final propertyInventoryUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final propertyInventoryDeleteProvider = StateProvider<String?>((ref) => null);
final propertyInventoryLoadingProvider = StateProvider<bool>((ref) => false);
