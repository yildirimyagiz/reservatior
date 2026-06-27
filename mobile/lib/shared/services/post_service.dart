import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PostService {
  final DioClient _dioClient;
  PostService(this._dioClient);

  Future<Post> getPostById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.posts}/$id');
    return Post.fromJson(response.data['data']);
  }

  Future<List<Post>> getPosts({
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
    final response = await _dioClient.get(ApiEndpoints.posts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Post.fromJson(json)).toList();
  }

  Future<Post> createPost(Post item) async {
    final response = await _dioClient.post(ApiEndpoints.posts, data: item.toJson());
    return Post.fromJson(response.data['data']);
  }

  Future<Post> updatePost(String id, Post item) async {
    final response = await _dioClient.patch('${ApiEndpoints.posts}/$id', data: item.toJson());
    return Post.fromJson(response.data['data']);
  }

  Future<void> deletePost(String id) async {
    await _dioClient.delete('${ApiEndpoints.posts}/$id');
  }
}
