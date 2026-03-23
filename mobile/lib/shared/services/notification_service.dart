import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class NotificationService {
  final DioClient _dioClient;

  NotificationService(this._dioClient);

  // Get Notification by ID
  Future<Notification> getNotificationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/notification/$id');
      return Notification.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all notifications
  Future<List<Notification>> getNotifications({
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

      final response = await _dioClient.get('/api/v1/notification', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Notification.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Notification
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
    return Exception('API Error: ${e.message}');
  }
}
