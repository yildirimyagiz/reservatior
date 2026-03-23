import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Notification operations
/// Provides CRUD operations with proper error handling and type safety
class NotificationRepository {
  final DioClient _dioClient;

  NotificationRepository(this._dioClient);

  /// Get Notification by ID
  /// Returns [Notification] if found, throws [RepositoryException] otherwise
  Future<Notification> getNotificationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/notification/$id');
      if (response.statusCode == 200) {
        return Notification.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch notification',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all notifications with pagination and filtering
  /// Returns list of [Notification] objects
  Future<List<Notification>> getnotifications({
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
      
      final response = await _dioClient.get('/api/v1/notification', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Notification.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch notifications',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Notification
  /// Returns created [Notification] object
  Future<Notification> createNotification(Notification notification) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/notification',
        data: notification.toJson(),
      );
      return Notification.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Notification
  Future<Notification> updateNotification(String id, Notification notification) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/notification/$id',
        data: notification.toJson(),
      );
      return Notification.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Notification
  Future<void> deleteNotification(String id) async {
    try {
      await _dioClient.delete('/api/v1/notification/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
