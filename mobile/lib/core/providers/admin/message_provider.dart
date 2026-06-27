import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/message.dart';

final adminMessagesProvider = FutureProvider<List<Message>>((ref) async {
  final dioClient = DioClient();
  try {
    final response = await dioClient.get('/api/v1/message');
    final data = response.data['data'] ?? response.data;
    if (data is List) {
      return data.map((e) => Message.fromJson(e)).toList();
    }
    return [];
  } catch (e) {
    print('Error fetching messages: $e');
    return [];
  }
});
