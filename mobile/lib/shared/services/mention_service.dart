import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MentionService {
  final DioClient _dioClient;
  MentionService(this._dioClient);

  Future<Mention> getMentionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mentions}/$id');
    return Mention.fromJson(response.data['data']);
  }

  Future<List<Mention>> getMentions({
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
    final response = await _dioClient.get(ApiEndpoints.mentions, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Mention.fromJson(json)).toList();
  }

  Future<Mention> createMention(Mention item) async {
    final response = await _dioClient.post(ApiEndpoints.mentions, data: item.toJson());
    return Mention.fromJson(response.data['data']);
  }

  Future<Mention> updateMention(String id, Mention item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mentions}/$id', data: item.toJson());
    return Mention.fromJson(response.data['data']);
  }

  Future<void> deleteMention(String id) async {
    await _dioClient.delete('${ApiEndpoints.mentions}/$id');
  }
}
