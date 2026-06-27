import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/property.dart';

final adminPropertiesProvider = FutureProvider<List<Property>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/property');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Property.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
