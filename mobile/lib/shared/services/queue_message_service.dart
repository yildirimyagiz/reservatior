import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class QueueMessageService {
  final DioClient _dioClient;

  QueueMessageService(this._dioClient);

  // Get QueueMessage by ID
  Future<QueueMessage> getQueueMessageById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/queue_message/$id');
      return QueueMessage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all queue_messages
  Future<List<QueueMessage>> getQueueMessages({
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

      final response = await _dioClient.get('/api/v1/queue_message', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => QueueMessage.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create QueueMessage
  Future<QueueMessage> createQueueMessage(QueueMessage queueMessage) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/queue_message',
        data: queueMessage.toJson(),
      );
      return QueueMessage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update QueueMessage
  Future<QueueMessage> updateQueueMessage(String id, QueueMessage queueMessage) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/queue_message/$id',
        data: queueMessage.toJson(),
      );
      return QueueMessage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete QueueMessage
  Future<void> deleteQueueMessage(String id) async {
    try {
      await _dioClient.delete('/api/v1/queue_message/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
