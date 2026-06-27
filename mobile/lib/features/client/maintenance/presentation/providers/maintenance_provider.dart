import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/features/client/maintenance/data/models/maintenance_model.dart';
import 'package:reservatior/features/client/maintenance/data/services/maintenance_service.dart';

final maintenanceServiceProvider = Provider((ref) {
  return MaintenanceService(DioClient());
});

final maintenanceProvider = StateNotifierProvider<MaintenanceNotifier, AsyncValue<List<MaintenanceModel>>>((ref) {
  return MaintenanceNotifier(ref.watch(maintenanceServiceProvider));
});

class MaintenanceNotifier extends StateNotifier<AsyncValue<List<MaintenanceModel>>> {
  final MaintenanceService _service;

  MaintenanceNotifier(this._service) : super(const AsyncValue.loading()) {
    fetchWorkOrders();
  }

  Future<void> fetchWorkOrders() async {
    state = const AsyncValue.loading();
    try {
      final orders = await _service.getWorkOrders();
      state = AsyncValue.data(orders);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createWorkOrder(String title, String description, String priority, String category) async {
    try {
      await _service.createWorkOrder(title, description, priority, category);
      await fetchWorkOrders();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteWorkOrder(String id) async {
    try {
      await _service.deleteWorkOrder(id);
      await fetchWorkOrders();
    } catch (e) {
      rethrow;
    }
  }
}
