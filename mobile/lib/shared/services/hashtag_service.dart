import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class HashtagService {
  final DioClient _dioClient;
  HashtagService(this._dioClient);

  Future<Hashtag> getHashtagById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.hashtags}/$id');
    return Hashtag.fromJson(response.data['data']);
  }

  Future<List<Hashtag>> getHashtags({
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
    final response = await _dioClient.get(ApiEndpoints.hashtags, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Hashtag.fromJson(json)).toList();
  }

  Future<Hashtag> createHashtag(Hashtag item) async {
    final response = await _dioClient.post(ApiEndpoints.hashtags, data: item.toJson());
    return Hashtag.fromJson(response.data['data']);
  }

  Future<Hashtag> updateHashtag(String id, Hashtag item) async {
    final response = await _dioClient.patch('${ApiEndpoints.hashtags}/$id', data: item.toJson());
    return Hashtag.fromJson(response.data['data']);
  }

  Future<void> deleteHashtag(String id) async {
    await _dioClient.delete('${ApiEndpoints.hashtags}/$id');
  }
}
