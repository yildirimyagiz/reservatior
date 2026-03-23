import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Post operations
/// Provides CRUD operations with proper error handling and type safety
class PostRepository {
  final DioClient _dioClient;

  PostRepository(this._dioClient);

  /// Get Post by ID
  /// Returns [Post] if found, throws [RepositoryException] otherwise
  Future<Post> getPostById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/post/$id');
      if (response.statusCode == 200) {
        return Post.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch post',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all posts with pagination and filtering
  /// Returns list of [Post] objects
  Future<List<Post>> getposts({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/post', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Post.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch posts',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Post
  /// Returns created [Post] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
