import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/maintenance_work_order.dart';

final adminMaintenanceOrdersProvider =
    FutureProvider<List<MaintenanceWorkOrder>>((ref) async {
      final dioClient = DioClient();
      try {
        final response = await dioClient.get('/api/v1/maintenance-work-order');
        final data = response.data['data'] ?? response.data;
        if (data is List) {
          return data.map((e) => MaintenanceWorkOrder.fromJson(e)).toList();
        }
        return [];
      } catch (e) {
        return [];
      }
    });
