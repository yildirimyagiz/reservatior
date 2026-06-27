import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiChatMessageService {
  final DioClient _dioClient;
  AiChatMessageService(this._dioClient);

  Future<AiChatMessage> getAiChatMessageById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiChatMessages}/$id');
    return AiChatMessage.fromJson(response.data['data']);
  }

  Future<List<AiChatMessage>> getAiChatMessages({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.aiChatMessages, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiChatMessage.fromJson(json)).toList();
  }

  Future<AiChatMessage> createAiChatMessage(AiChatMessage item) async {
    final response = await _dioClient.post(ApiEndpoints.aiChatMessages, data: item.toJson());
    return AiChatMessage.fromJson(response.data['data']);
  }

  Future<AiChatMessage> updateAiChatMessage(String id, AiChatMessage item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiChatMessages}/$id', data: item.toJson());
    return AiChatMessage.fromJson(response.data['data']);
  }

  Future<void> deleteAiChatMessage(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiChatMessages}/$id');
  }
}
