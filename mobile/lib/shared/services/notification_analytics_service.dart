import 'package:reservatior/core/network/dio_client.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class NotificationAnalyticsService {
  final DioClient _dioClient;
  
  NotificationAnalyticsService(this._dioClient);

  Future<Map<String, dynamic>> getNotificationAnalytics({
    String? orgId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
        if (userId != null) 'userId': userId,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/analytics',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error getting notification analytics: $e');
      return _getEmptyAnalytics();
    }
  }

  Future<Map<String, dynamic>> getEngagementMetrics({
    String? orgId,
    String? userId,
    int? days,
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
        if (userId != null) 'userId': userId,
        if (days != null) 'days': days,
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/engagement',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error getting engagement metrics: $e');
      return _getEmptyEngagementMetrics();
    }
  }

  Future<Map<String, dynamic>> getTypeAnalytics({
    String? orgId,
    String? userId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
        if (userId != null) 'userId': userId,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/type-analytics',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error getting type analytics: $e');
      return _getEmptyTypeAnalytics();
    }
  }

  Future<Map<String, dynamic>> getTimeBasedAnalytics({
    String? orgId,
    String? userId,
    String period = 'daily', // hourly, daily, weekly, monthly
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
        if (userId != null) 'userId': userId,
        'period': period,
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/time-analytics',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error getting time-based analytics: $e');
      return _getEmptyTimeAnalytics();
    }
  }

  Future<Map<String, dynamic>> getUserBehaviorAnalytics({
    String? orgId,
    String? userId,
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
        if (userId != null) 'userId': userId,
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/user-behavior',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error getting user behavior analytics: $e');
      return _getEmptyUserBehaviorAnalytics();
    }
  }

  Future<Map<String, dynamic>> getPerformanceMetrics({
    String? orgId,
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/performance',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error getting performance metrics: $e');
      return _getEmptyPerformanceMetrics();
    }
  }

  Future<Map<String, dynamic>> getDeliveryAnalytics({
    String? orgId,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/delivery-analytics',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error getting delivery analytics: $e');
      return _getEmptyDeliveryAnalytics();
    }
  }

  Future<Map<String, dynamic>> generateReport({
    String? orgId,
    String? userId,
    String reportType = 'summary', // summary, detailed, engagement, performance
    DateTime? startDate,
    DateTime? endDate,
    String format = 'json', // json, csv, pdf
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
        if (userId != null) 'userId': userId,
        'reportType': reportType,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
        'format': format,
      };
      
      final response = await _dioClient.post(
        '${ApiEndpoints.notifications}/generate-report',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error generating report: $e');
      return {'error': 'mobile.leftovers.failed_to_generate_report'.tr()};
    }
  }

  Future<List<Map<String, dynamic>>> getTopNotifications({
    String? orgId,
    String? userId,
    String metric = 'views', // views, clicks, engagement
    int limit = 10,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
        if (userId != null) 'userId': userId,
        'metric': metric,
        'limit': limit,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/top-notifications',
        queryParameters: queryParams,
      );
      
      final data = response.data['data'] as List;
      return data.cast<Map<String, dynamic>>();
    } catch (e) {
      print('Error getting top notifications: $e');
      return [];
    }
  }

  Future<Map<String, dynamic>> getRealtimeMetrics({
    String? orgId,
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/realtime-metrics',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error getting realtime metrics: $e');
      return _getEmptyRealtimeMetrics();
    }
  }

  Future<Map<String, dynamic>> getComparativeAnalytics({
    String? orgId,
    DateTime? currentPeriodStart,
    DateTime? currentPeriodEnd,
    DateTime? previousPeriodStart,
    DateTime? previousPeriodEnd,
  }) async {
    try {
      final queryParams = {
        if (orgId != null) 'orgId': orgId,
        if (currentPeriodStart != null) 'currentPeriodStart': currentPeriodStart.toIso8601String(),
        if (currentPeriodEnd != null) 'currentPeriodEnd': currentPeriodEnd.toIso8601String(),
        if (previousPeriodStart != null) 'previousPeriodStart': previousPeriodStart.toIso8601String(),
        if (previousPeriodEnd != null) 'previousPeriodEnd': previousPeriodEnd.toIso8601String(),
      };
      
      final response = await _dioClient.get(
        '${ApiEndpoints.notifications}/comparative-analytics',
        queryParameters: queryParams,
      );
      
      return response.data['data'] as Map<String, dynamic>;
    } catch (e) {
      print('Error getting comparative analytics: $e');
      return _getEmptyComparativeAnalytics();
    }
  }

  // Helper methods for empty analytics data
  Map<String, dynamic> _getEmptyAnalytics() {
    return {
      'totalNotifications': 0,
      'unreadCount': 0,
      'readCount': 0,
      'engagementRate': 0.0,
      'averageReadTime': 0.0,
      'topNotificationTypes': <String, int>{},
      'dailyStats': <Map<String, dynamic>>[],
    };
  }

  Map<String, dynamic> _getEmptyEngagementMetrics() {
    return {
      'totalClicks': 0,
      'totalViews': 0,
      'clickThroughRate': 0.0,
      'averageEngagementTime': 0.0,
      'bounceRate': 0.0,
      'conversionRate': 0.0,
    };
  }

  Map<String, dynamic> _getEmptyTypeAnalytics() {
    return {
      'message': {'sent': 0, 'read': 0, 'clicked': 0},
      'property': {'sent': 0, 'read': 0, 'clicked': 0},
      'booking': {'sent': 0, 'read': 0, 'clicked': 0},
      'payment': {'sent': 0, 'read': 0, 'clicked': 0},
      'document': {'sent': 0, 'read': 0, 'clicked': 0},
      'system': {'sent': 0, 'read': 0, 'clicked': 0},
      'alert': {'sent': 0, 'read': 0, 'clicked': 0},
      'task': {'sent': 0, 'read': 0, 'clicked': 0},
    };
  }

  Map<String, dynamic> _getEmptyTimeAnalytics() {
    return {
      'hourlyData': <Map<String, dynamic>>[],
      'dailyData': <Map<String, dynamic>>[],
      'weeklyData': <Map<String, dynamic>>[],
      'monthlyData': <Map<String, dynamic>>[],
      'peakHours': <int>[],
      'peakDays': <String>[],
    };
  }

  Map<String, dynamic> _getEmptyUserBehaviorAnalytics() {
    return {
      'averageNotificationsPerUser': 0.0,
      'mostActiveUsers': <Map<String, dynamic>>[],
      'userSegments': <Map<String, dynamic>>{},
      'retentionRate': 0.0,
      'churnRate': 0.0,
    };
  }

  Map<String, dynamic> _getEmptyPerformanceMetrics() {
    return {
      'deliveryRate': 0.0,
      'failureRate': 0.0,
      'averageDeliveryTime': 0.0,
      'serverResponseTime': 0.0,
      'apiSuccessRate': 0.0,
      'errorRate': 0.0,
    };
  }

  Map<String, dynamic> _getEmptyDeliveryAnalytics() {
    return {
      'pushDelivered': 0,
      'pushFailed': 0,
      'emailDelivered': 0,
      'emailFailed': 0,
      'smsDelivered': 0,
      'smsFailed': 0,
      'inAppDelivered': 0,
      'inAppFailed': 0,
    };
  }

  Map<String, dynamic> _getEmptyRealtimeMetrics() {
    return {
      'activeUsers': 0,
      'notificationsInQueue': 0,
      'currentDeliveryRate': 0.0,
      'averageResponseTime': 0.0,
      'systemLoad': 0.0,
    };
  }

  Map<String, dynamic> _getEmptyComparativeAnalytics() {
    return {
      'currentPeriod': _getEmptyAnalytics(),
      'previousPeriod': _getEmptyAnalytics(),
      'growth': {
        'totalNotifications': 0.0,
        'engagementRate': 0.0,
        'readRate': 0.0,
      },
      'trends': <Map<String, dynamic>>[],
    };
  }
}
