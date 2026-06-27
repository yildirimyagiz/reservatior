import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/agency.dart';
import 'package:logging/logging.dart';

final _logger = Logger('AgencyProvider');

final agencyListProvider = FutureProvider<List<Agency>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/agency');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Agency.fromJson(e)).toList();
    }
    return [];
  } catch (e, stack) {
    _logger.severe('Error fetching agencys', e, stack);
    return [];
  }
});
