import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/audit_log.dart';

final adminAuditLogsProvider = FutureProvider<List<AuditLog>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/audit-log');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => AuditLog.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
