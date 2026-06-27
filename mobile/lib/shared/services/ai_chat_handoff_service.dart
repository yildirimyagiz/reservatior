import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiChatHandoffService {
  final DioClient _dioClient;
  AiChatHandoffService(this._dioClient);

  Future<AiChatHandoff> getAiChatHandoffById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiChatHandoffs}/$id');
    return AiChatHandoff.fromJson(response.data['data']);
  }

  Future<List<AiChatHandoff>> getAiChatHandoffs({
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
    final response = await _dioClient.get(ApiEndpoints.aiChatHandoffs, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiChatHandoff.fromJson(json)).toList();
  }

  Future<AiChatHandoff> createAiChatHandoff(AiChatHandoff item) async {
    final response = await _dioClient.post(ApiEndpoints.aiChatHandoffs, data: item.toJson());
    return AiChatHandoff.fromJson(response.data['data']);
  }

  Future<AiChatHandoff> updateAiChatHandoff(String id, AiChatHandoff item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiChatHandoffs}/$id', data: item.toJson());
    return AiChatHandoff.fromJson(response.data['data']);
  }

  Future<void> deleteAiChatHandoff(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiChatHandoffs}/$id');
  }
}
