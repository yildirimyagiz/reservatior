import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/notification.dart';

final adminNotificationsProvider = FutureProvider<List<Notification>>((
  ref,
) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/notification');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Notification.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    print('Error fetching notifications: $e');
    return [];
  }
});
