import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for OrgSubscription operations
/// Provides CRUD operations with proper error handling and type safety
class OrgSubscriptionRepository {
  final DioClient _dioClient;

  OrgSubscriptionRepository(this._dioClient);

  /// Get OrgSubscription by ID
  /// Returns [OrgSubscription] if found, throws [RepositoryException] otherwise
  Future<OrgSubscription> getOrgSubscriptionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/org_subscription/$id');
      if (response.statusCode == 200) {
        return OrgSubscription.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch org_subscription',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all org_subscriptions with pagination and filtering
  /// Returns list of [OrgSubscription] objects
  Future<List<OrgSubscription>> getorg_subscriptions({
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
      
      final response = await _dioClient.get('/api/v1/org_subscription', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => OrgSubscription.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch org_subscriptions',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new OrgSubscription
  /// Returns created [OrgSubscription] object
  Future<OrgSubscription> createOrgSubscription(OrgSubscription orgSubscription) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/org_subscription',
        data: orgSubscription.toJson(),
      );
      return OrgSubscription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update OrgSubscription
  Future<OrgSubscription> updateOrgSubscription(String id, OrgSubscription orgSubscription) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/org_subscription/$id',
        data: orgSubscription.toJson(),
      );
      return OrgSubscription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete OrgSubscription
  Future<void> deleteOrgSubscription(String id) async {
    try {
      await _dioClient.delete('/api/v1/org_subscription/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
