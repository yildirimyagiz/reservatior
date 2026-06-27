import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class TagService {
  final DioClient _dioClient;
  TagService(this._dioClient);

  Future<Tag> getTagById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.tags}/$id');
    return Tag.fromJson(response.data['data']);
  }

  Future<List<Tag>> getTags({
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
    final response = await _dioClient.get(ApiEndpoints.tags, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Tag.fromJson(json)).toList();
  }

  Future<Tag> createTag(Tag item) async {
    final response = await _dioClient.post(ApiEndpoints.tags, data: item.toJson());
    return Tag.fromJson(response.data['data']);
  }

  Future<Tag> updateTag(String id, Tag item) async {
    final response = await _dioClient.patch('${ApiEndpoints.tags}/$id', data: item.toJson());
    return Tag.fromJson(response.data['data']);
  }

  Future<void> deleteTag(String id) async {
    await _dioClient.delete('${ApiEndpoints.tags}/$id');
  }
}
