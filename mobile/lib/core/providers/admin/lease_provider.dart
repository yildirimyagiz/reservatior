import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/lease.dart';
import 'package:logging/logging.dart';

final _logger = Logger('LeaseProvider');

final leaseListProvider = FutureProvider<List<Lease>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/lease');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Lease.fromJson(e)).toList();
    }
    return [];
  } catch (e, stack) {
    _logger.severe('Error fetching leases', e, stack);
    return [];
  }
});
