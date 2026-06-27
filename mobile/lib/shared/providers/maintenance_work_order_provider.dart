import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/maintenance_work_order_service.dart';
import 'package:reservatior/shared/repositories/maintenance_work_order_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final maintenanceWorkOrderServiceProvider = Provider<MaintenanceWorkOrderService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MaintenanceWorkOrderService(dioClient);
});

final maintenanceWorkOrderRepositoryProvider = Provider<MaintenanceWorkOrderRepository>((ref) {
  final service = ref.watch(maintenanceWorkOrderServiceProvider);
  return MaintenanceWorkOrderRepositoryImpl(service);
});

final maintenanceWorkOrderListProvider = FutureProvider.autoDispose<List<MaintenanceWorkOrder>>((ref) async {
  final repository = ref.watch(maintenanceWorkOrderRepositoryProvider);
  return repository.getAll();
});

final maintenanceWorkOrderCreateProvider = StateProvider<MaintenanceWorkOrder?>((ref) => null);
final maintenanceWorkOrderUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final maintenanceWorkOrderDeleteProvider = StateProvider<String?>((ref) => null);
final maintenanceWorkOrderLoadingProvider = StateProvider<bool>((ref) => false);
