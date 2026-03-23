import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/maintenance_block_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MaintenanceBlock Providers

final MaintenanceBlockServiceProvider = Provider<MaintenanceBlockService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MaintenanceBlockService(dioClient);
});

// List Provider
final maintenanceBlockProvider = FutureProvider.autoDispose<List<MaintenanceBlock>>((ref) async {
  final service = ref.watch(MaintenanceBlockServiceProvider);
  return service.getMaintenanceBlocks();
});

// Create Provider
final MaintenanceBlockCreateProvider = FutureProvider.autoDispose<MaintenanceBlock>((ref) async {
  final service = ref.watch(MaintenanceBlockServiceProvider);
  return service.createMaintenanceBlock(MaintenanceBlock());
});

// Update Provider  
final MaintenanceBlockUpdateProvider = FutureProvider.autoDispose<MaintenanceBlock>((ref) async {
  final service = ref.watch(MaintenanceBlockServiceProvider);
  final state = ref.watch(MaintenanceBlockUpdateStateProvider);
  if (state['id'] != null && state['maintenance_block'] != null) {
    return service.updateMaintenanceBlock(state['id'], state['maintenance_block']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MaintenanceBlockDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MaintenanceBlockServiceProvider);
  final state = ref.watch(MaintenanceBlockDeleteStateProvider);
  if (state != null) {
    return service.deleteMaintenanceBlock(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MaintenanceBlockUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MaintenanceBlockDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MaintenanceBlockLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(maintenanceBlockProvider);
  final createAsync = ref.watch(MaintenanceBlockCreateProvider);
  final updateAsync = ref.watch(MaintenanceBlockUpdateProvider);
  final deleteAsync = ref.watch(MaintenanceBlockDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
