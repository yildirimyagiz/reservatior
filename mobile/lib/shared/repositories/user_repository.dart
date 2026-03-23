import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for User operations
/// Provides CRUD operations with proper error handling and type safety
class UserRepository {
  final DioClient _dioClient;

  UserRepository(this._dioClient);

  /// Get User by ID
  /// Returns [User] if found, throws [RepositoryException] otherwise
  Future<User> getUserById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/user/$id');
      if (response.statusCode == 200) {
        return User.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch user',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all users with pagination and filtering
  /// Returns list of [User] objects
  Future<List<User>> getusers({
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
      
      final response = await _dioClient.get('/api/v1/user', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => User.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch users',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new User
  /// Returns created [User] object
  Future<User> createUser(User user) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/user',
        data: user.toJson(),
      );
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update User
  Future<User> updateUser(String id, User user) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/user/$id',
        data: user.toJson(),
      );
      return User.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete User
  Future<void> deleteUser(String id) async {
    try {
      await _dioClient.delete('/api/v1/user/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
