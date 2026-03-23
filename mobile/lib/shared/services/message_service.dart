import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MessageService {
  final DioClient _dioClient;

  MessageService(this._dioClient);

  // Get Message by ID
  Future<Message> getMessageById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/message/$id');
      return Message.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all messages
  Future<List<Message>> getMessages({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/message', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Message.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Message
  Future<Message> createMessage(Message message) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/message',
        data: message.toJson(),
      );
      return Message.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Message
  Future<Message> updateMessage(String id, Message message) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/message/$id',
        data: message.toJson(),
      );
      return Message.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Message
  Future<void> deleteMessage(String id) async {
    try {
      await _dioClient.delete('/api/v1/message/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
