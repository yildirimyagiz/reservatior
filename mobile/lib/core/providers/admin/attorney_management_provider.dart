import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/attorney_management.dart';

final adminAttorneysProvider = FutureProvider<List<AttorneyManagement>>((
  ref,
) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/attorney-management');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => AttorneyManagement.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
