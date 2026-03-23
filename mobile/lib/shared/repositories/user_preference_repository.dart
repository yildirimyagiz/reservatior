import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for UserPreference operations
/// Provides CRUD operations with proper error handling and type safety
class UserPreferenceRepository {
  final DioClient _dioClient;

  UserPreferenceRepository(this._dioClient);

  /// Get UserPreference by ID
  /// Returns [UserPreference] if found, throws [RepositoryException] otherwise
  Future<UserPreference> getUserPreferenceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/user_preference/$id');
      if (response.statusCode == 200) {
        return UserPreference.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch user_preference',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all user_preferences with pagination and filtering
  /// Returns list of [UserPreference] objects
  Future<List<UserPreference>> getuser_preferences({
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
      
      final response = await _dioClient.get('/api/v1/user_preference', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => UserPreference.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch user_preferences',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new UserPreference
  /// Returns created [UserPreference] object
  Future<UserPreference> createUserPreference(UserPreference userPreference) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/user_preference',
        data: userPreference.toJson(),
      );
      return UserPreference.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update UserPreference
  Future<UserPreference> updateUserPreference(String id, UserPreference userPreference) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/user_preference/$id',
        data: userPreference.toJson(),
      );
      return UserPreference.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete UserPreference
  Future<void> deleteUserPreference(String id) async {
    try {
      await _dioClient.delete('/api/v1/user_preference/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
