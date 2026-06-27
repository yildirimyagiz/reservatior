import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/tenant.dart';
import 'package:logging/logging.dart';

final _logger = Logger('TenantProvider');

final tenantListProvider = FutureProvider<List<Tenant>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/tenant');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Tenant.fromJson(e)).toList();
    }
    return [];
  } catch (e, stack) {
    _logger.severe('Error fetching tenants', e, stack);
    return [];
  }
});
