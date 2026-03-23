import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIChatMessageService {
  final DioClient _dioClient;

  AIChatMessageService(this._dioClient);

  // Get AIChatMessage by ID
  Future<AIChatMessage> getAIChatMessageById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_chat_message/$id');
      return AIChatMessage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_chat_messages
  Future<List<AIChatMessage>> getAIChatMessages({
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

      final response = await _dioClient.get('/api/v1/ai_chat_message', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIChatMessage.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIChatMessage
  Future<AIChatMessage> createAIChatMessage(AIChatMessage aIChatMessage) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_chat_message',
        data: aIChatMessage.toJson(),
      );
      return AIChatMessage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIChatMessage
  Future<AIChatMessage> updateAIChatMessage(String id, AIChatMessage aIChatMessage) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_chat_message/$id',
        data: aIChatMessage.toJson(),
      );
      return AIChatMessage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIChatMessage
  Future<void> deleteAIChatMessage(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_chat_message/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
