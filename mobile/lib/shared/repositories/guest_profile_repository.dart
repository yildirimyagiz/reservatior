import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for GuestProfile operations
/// Provides CRUD operations with proper error handling and type safety
class GuestProfileRepository {
  final DioClient _dioClient;

  GuestProfileRepository(this._dioClient);

  /// Get GuestProfile by ID
  /// Returns [GuestProfile] if found, throws [RepositoryException] otherwise
  Future<GuestProfile> getGuestProfileById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/guest_profile/$id');
      if (response.statusCode == 200) {
        return GuestProfile.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch guest_profile',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all guest_profiles with pagination and filtering
  /// Returns list of [GuestProfile] objects
  Future<List<GuestProfile>> getguest_profiles({
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
      
      final response = await _dioClient.get('/api/v1/guest_profile', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => GuestProfile.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch guest_profiles',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new GuestProfile
  /// Returns created [GuestProfile] object
  Future<GuestProfile> createGuestProfile(GuestProfile guestProfile) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/guest_profile',
        data: guestProfile.toJson(),
      );
      return GuestProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update GuestProfile
  Future<GuestProfile> updateGuestProfile(String id, GuestProfile guestProfile) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/guest_profile/$id',
        data: guestProfile.toJson(),
      );
      return GuestProfile.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete GuestProfile
  Future<void> deleteGuestProfile(String id) async {
    try {
      await _dioClient.delete('/api/v1/guest_profile/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
