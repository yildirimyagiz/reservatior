import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/maintenance_work_order_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// MaintenanceWorkOrder Providers

final MaintenanceWorkOrderServiceProvider = Provider<MaintenanceWorkOrderService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MaintenanceWorkOrderService(dioClient);
});

// List Provider
final maintenanceWorkOrderProvider = FutureProvider.autoDispose<List<MaintenanceWorkOrder>>((ref) async {
  final service = ref.watch(MaintenanceWorkOrderServiceProvider);
  return service.getMaintenanceWorkOrders();
});

// Create Provider
final MaintenanceWorkOrderCreateProvider = FutureProvider.autoDispose<MaintenanceWorkOrder>((ref) async {
  final service = ref.watch(MaintenanceWorkOrderServiceProvider);
  return service.createMaintenanceWorkOrder(MaintenanceWorkOrder());
});

// Update Provider  
final MaintenanceWorkOrderUpdateProvider = FutureProvider.autoDispose<MaintenanceWorkOrder>((ref) async {
  final service = ref.watch(MaintenanceWorkOrderServiceProvider);
  final state = ref.watch(MaintenanceWorkOrderUpdateStateProvider);
  if (state['id'] != null && state['maintenance_work_order'] != null) {
    return service.updateMaintenanceWorkOrder(state['id'], state['maintenance_work_order']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final MaintenanceWorkOrderDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(MaintenanceWorkOrderServiceProvider);
  final state = ref.watch(MaintenanceWorkOrderDeleteStateProvider);
  if (state != null) {
    return service.deleteMaintenanceWorkOrder(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final MaintenanceWorkOrderUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final MaintenanceWorkOrderDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final MaintenanceWorkOrderLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(maintenanceWorkOrderProvider);
  final createAsync = ref.watch(MaintenanceWorkOrderCreateProvider);
  final updateAsync = ref.watch(MaintenanceWorkOrderUpdateProvider);
  final deleteAsync = ref.watch(MaintenanceWorkOrderDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
