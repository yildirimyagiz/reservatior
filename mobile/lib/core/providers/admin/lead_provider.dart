import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/lead.dart';

final adminLeadsProvider = FutureProvider<List<Lead>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/lead');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Lead.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
