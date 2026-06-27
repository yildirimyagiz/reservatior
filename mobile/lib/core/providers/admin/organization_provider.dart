import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/organization.dart';

final adminOrganizationsProvider = FutureProvider<List<Organization>>((
  ref,
) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/organization');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Organization.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    return [];
  }
});
