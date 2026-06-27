import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/system_metrics.dart';

final adminSystemMetricsProvider = FutureProvider<List<SystemMetrics>>((
  ref,
) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/system-metrics');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => SystemMetrics.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
