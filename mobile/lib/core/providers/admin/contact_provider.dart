import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/contact.dart';
import 'package:logging/logging.dart';

final _logger = Logger('ContactProvider');

final contactListProvider = FutureProvider<List<Contact>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/contact');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Contact.fromJson(e)).toList();
    }
    return [];
  } catch (e, stack) {
    _logger.severe('Error fetching contacts', e, stack);
    return [];
  }
});
