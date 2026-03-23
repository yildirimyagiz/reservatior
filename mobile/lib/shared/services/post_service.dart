import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class PostService {
  final DioClient _dioClient;

  PostService(this._dioClient);

  // Get Post by ID
  Future<Post> getPostById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/post/$id');
      return Post.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all posts
  Future<List<Post>> getPosts({
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

      final response = await _dioClient.get('/api/v1/post', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Post.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Post
  Future<Post> createPost(Post post) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/post',
        data: post.toJson(),
      );
      return Post.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Post
  Future<Post> updatePost(String id, Post post) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/post/$id',
        data: post.toJson(),
      );
      return Post.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Post
  Future<void> deletePost(String id) async {
    try {
      await _dioClient.delete('/api/v1/post/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
