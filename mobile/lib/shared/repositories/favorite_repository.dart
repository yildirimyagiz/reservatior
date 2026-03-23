import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Favorite operations
/// Provides CRUD operations with proper error handling and type safety
class FavoriteRepository {
  final DioClient _dioClient;

  FavoriteRepository(this._dioClient);

  /// Get Favorite by ID
  /// Returns [Favorite] if found, throws [RepositoryException] otherwise
  Future<Favorite> getFavoriteById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/favorite/$id');
      if (response.statusCode == 200) {
        return Favorite.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch favorite',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all favorites with pagination and filtering
  /// Returns list of [Favorite] objects
  Future<List<Favorite>> getfavorites({
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
      
      final response = await _dioClient.get('/api/v1/favorite', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Favorite.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch favorites',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Favorite
  /// Returns created [Favorite] object
  Future<Favorite> createFavorite(Favorite favorite) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/favorite',
        data: favorite.toJson(),
      );
      return Favorite.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Favorite
  Future<Favorite> updateFavorite(String id, Favorite favorite) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/favorite/$id',
        data: favorite.toJson(),
      );
      return Favorite.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Favorite
  Future<void> deleteFavorite(String id) async {
    try {
      await _dioClient.delete('/api/v1/favorite/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
