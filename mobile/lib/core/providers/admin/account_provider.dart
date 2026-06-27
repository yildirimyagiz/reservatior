import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/user.dart';

final adminAccountsProvider = FutureProvider<List<User>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/account');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => User.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    print('Error fetching users: $e');
    return [];
  }
});
