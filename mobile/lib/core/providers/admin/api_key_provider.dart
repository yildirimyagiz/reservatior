import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/api_key.dart';

final adminApiKeysProvider = FutureProvider<List<ApiKey>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/api-key');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => ApiKey.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
