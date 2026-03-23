import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Mention operations
/// Provides CRUD operations with proper error handling and type safety
class MentionRepository {
  final DioClient _dioClient;

  MentionRepository(this._dioClient);

  /// Get Mention by ID
  /// Returns [Mention] if found, throws [RepositoryException] otherwise
  Future<Mention> getMentionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mention/$id');
      if (response.statusCode == 200) {
        return Mention.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch mention',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all mentions with pagination and filtering
  /// Returns list of [Mention] objects
  Future<List<Mention>> getmentions({
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
      
      final response = await _dioClient.get('/api/v1/mention', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Mention.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch mentions',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Mention
  /// Returns created [Mention] object
  Future<Mention> createMention(Mention mention) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mention',
        data: mention.toJson(),
      );
      return Mention.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Mention
  Future<Mention> updateMention(String id, Mention mention) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mention/$id',
        data: mention.toJson(),
      );
      return Mention.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Mention
  Future<void> deleteMention(String id) async {
    try {
      await _dioClient.delete('/api/v1/mention/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
