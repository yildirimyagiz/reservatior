import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class NotificationService {
  final DioClient _dioClient;
  NotificationService(this._dioClient);

  Future<Notification> getNotificationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.notifications}/$id');
    return Notification.fromJson(response.data['data']);
  }

  Future<List<Notification>> getNotifications({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.notifications, queryParameters: queryParams);
    
    print('🔔 Notification Response: ${response.data}');
    
    final data = response.data['data'] as List;
    print('🔔 Notification Parsed ${data.length} items');
    return data.map((json) => Notification.fromJson(json)).toList();
  }

  Future<Notification> createNotification(Notification item) async {
    final response = await _dioClient.post(ApiEndpoints.notifications, data: item.toJson());
    return Notification.fromJson(response.data['data']);
  }

  Future<Notification> updateNotification(String id, Notification item) async {
    final response = await _dioClient.patch('${ApiEndpoints.notifications}/$id', data: item.toJson());
    return Notification.fromJson(response.data['data']);
  }

  Future<void> deleteNotification(String id) async {
    await _dioClient.delete('${ApiEndpoints.notifications}/$id');
  }
}
