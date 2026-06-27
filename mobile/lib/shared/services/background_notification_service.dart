import 'dart:async';
import 'dart:isolate';
import 'dart:ui' as ui;
import 'dart:convert';
import 'dart:math' as math;
import 'package:flutter/widgets.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart' as models;

class BackgroundNotificationService {
  final DioClient _dioClient;
  static const String _isolateName = 'notification_isolate';
  late final ReceivePort _receivePort;
  Timer? _syncTimer;
  bool _isRunning = false;
  
  BackgroundNotificationService(this._dioClient);

  Future<void> initialize() async {
    if (_isRunning) return;
    
    try {
      // Initialize receive port for background processing
      _receivePort = ReceivePort();
      
      // Register isolate for background processing
      ui.IsolateNameServer.registerPortWithName(_receivePort.sendPort, _isolateName);
      
      // Start background sync timer
      _startBackgroundSync();
      
      // Listen for background messages
      _receivePort.listen(_handleBackgroundMessage);
      
      _isRunning = true;
      print('Background notification service initialized');
    } catch (e) {
      print('Failed to initialize background notification service: $e');
    }
  }

  void _startBackgroundSync() {
    // Sync notifications every 5 minutes when app is in background
    _syncTimer = Timer.periodic(const Duration(minutes: 5), (timer) async {
      await _syncOfflineNotifications();
    });
  }

  Future<void> _handleBackgroundMessage(dynamic message) async {
    try {
      if (message is Map<String, dynamic>) {
        switch (message['type']) {
          case 'notification_received':
            await _handleBackgroundNotification(message['data']);
            break;
          case 'sync_request':
            await _syncOfflineNotifications();
            break;
          case 'clear_offline':
            await _clearOfflineNotifications();
            break;
        }
      }
    } catch (e) {
      print('Error handling background message: $e');
    }
  }

  Future<void> _handleBackgroundNotification(Map<String, dynamic> notificationData) async {
    try {
      // Save notification to offline storage
      await _saveNotificationOffline(notificationData);
      
      // Show local notification if app is in background
      await _showLocalNotification(notificationData);
      
      // Update unread count
      await _updateUnreadCount();
    } catch (e) {
      print('Error handling background notification: $e');
    }
  }

  Future<void> _saveNotificationOffline(Map<String, dynamic> notificationData) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offlineNotifications = prefs.getStringList('offline_notifications') ?? [];
      
      // Add new notification to offline list
      offlineNotifications.add(jsonEncode(notificationData));
      
      // Keep only last 100 notifications
      if (offlineNotifications.length > 100) {
        offlineNotifications.removeRange(0, offlineNotifications.length - 100);
      }
      
      await prefs.setStringList('offline_notifications', offlineNotifications);
    } catch (e) {
      print('Error saving notification offline: $e');
    }
  }

  Future<void> _showLocalNotification(Map<String, dynamic> notificationData) async {
    try {
      // This would integrate with local notification plugin
      // For now, just log the notification
      print('Local notification: ${notificationData['title']} - ${notificationData['body']}');
      
      // In a real implementation, you would use:
      // await FlutterLocalNotificationsPlugin().show(...)
    } catch (e) {
      print('Error showing local notification: $e');
    }
  }

  Future<void> showLocalNotification(String title, String body) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentCount = prefs.getInt('unread_count') ?? 0;
      await prefs.setInt('unread_count', math.max(0, currentCount - 1));
    } catch (e) {
      print('Error marking notification as read offline: $e');
    }
  }

  Future<void> _updateUnreadCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final currentCount = prefs.getInt('unread_count') ?? 0;
      await prefs.setInt('unread_count', currentCount + 1);
    } catch (e) {
      print('Error updating unread count: $e');
    }
  }

  Future<void> _syncOfflineNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offlineNotifications = prefs.getStringList('offline_notifications') ?? [];
      
      if (offlineNotifications.isEmpty) return;
      
      // Try to sync with server
      for (final notificationJson in offlineNotifications) {
        try {
          final notificationData = jsonDecode(notificationJson);
          await _syncNotificationWithServer(notificationData);
        } catch (e) {
          print('Error syncing notification: $e');
        }
      }
      
      // Clear synced notifications
      await _clearOfflineNotifications();
    } catch (e) {
      print('Error syncing offline notifications: $e');
    }
  }

  Future<void> _syncNotificationWithServer(Map<String, dynamic> notificationData) async {
    try {
      // Mark notification as read on server if it was read offline
      if (notificationData['read_offline'] == true) {
        await _dioClient.patch(
          '${ApiEndpoints.notifications}/${notificationData['id']}/read',
        );
      }
      
      // Update notification status if needed
      if (notificationData['status_updated'] == true) {
        await _dioClient.patch(
          '${ApiEndpoints.notifications}/${notificationData['id']}',
          data: {
            'status': notificationData['status'],
          },
        );
      }
    } catch (e) {
      print('Error syncing notification with server: $e');
    }
  }

  Future<void> _clearOfflineNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove('offline_notifications');
    } catch (e) {
      print('Error clearing offline notifications: $e');
    }
  }

  Future<List<models.Notification>> getOfflineNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offlineNotifications = prefs.getStringList('offline_notifications') ?? [];
      
      final notifications = <models.Notification>[];
      for (final notificationJson in offlineNotifications) {
        try {
          final notificationData = jsonDecode(notificationJson);
          notifications.add(models.Notification.fromJson(notificationData));
        } catch (e) {
          print('Error parsing offline notification: $e');
        }
      }
      
      return notifications;
    } catch (e) {
      print('Error getting offline notifications: $e');
      return [];
    }
  }

  Future<void> markNotificationAsReadOffline(String notificationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offlineNotifications = prefs.getStringList('offline_notifications') ?? [];
      
      final updatedNotifications = <String>[];
      for (final notificationJson in offlineNotifications) {
        try {
          final notificationData = jsonDecode(notificationJson);
          if (notificationData['id'] == notificationId) {
            notificationData['read_offline'] = true;
            notificationData['status_updated'] = true;
            notificationData['status'] = 'READ';
          }
          updatedNotifications.add(jsonEncode(notificationData));
        } catch (e) {
          print('Error updating offline notification: $e');
          updatedNotifications.add(notificationJson);
        }
      }
      
      await prefs.setStringList('offline_notifications', updatedNotifications);
      
      // Update unread count
      final currentCount = prefs.getInt('unread_count') ?? 0;
      await prefs.setInt('unread_count', math.max(0, currentCount - 1));
    } catch (e) {
      print('Error marking notification as read offline: $e');
    }
  }

  Future<void> deleteNotificationOffline(String notificationId) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offlineNotifications = prefs.getStringList('offline_notifications') ?? [];
      
      final updatedNotifications = offlineNotifications.where((notificationJson) {
        try {
          final notificationData = jsonDecode(notificationJson);
          return notificationData['id'] != notificationId;
        } catch (e) {
          return true; // Keep malformed notifications
        }
      }).toList();
      
      // In a real implementation, you would initialize notifications here:
      // await FlutterLocalNotificationsPlugin().initialize(...)
      
      await prefs.setStringList('offline_notifications', updatedNotifications);
    } catch (e) {
      print('Error deleting notification offline: $e');
    }
  }

  Future<int> getOfflineUnreadCount() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      return prefs.getInt('unread_count') ?? 0;
    } catch (e) {
      print('Error getting offline unread count: $e');
      return 0;
    }
  }

  Future<void> handleAppLifecycleChange(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.paused:
        // App going to background
        await _prepareForBackground();
        break;
      case AppLifecycleState.resumed:
        // App coming to foreground
        await _handleForegroundResume();
        break;
      case AppLifecycleState.detached:
        // App being terminated
        await _handleAppTermination();
        break;
      default:
        break;
    }
  }

  Future<void> _prepareForBackground() async {
    try {
      // Sync any pending notifications
      await _syncOfflineNotifications();
      
      // Start background processing
      if (_syncTimer != null) {
        _syncTimer!.cancel();
      }
      _startBackgroundSync();
    } catch (e) {
      print('Error preparing for background: $e');
    }
  }

  Future<void> _handleForegroundResume() async {
    try {
      // Stop background sync timer
      _syncTimer?.cancel();
      
      // Sync offline notifications with server
      await _syncOfflineNotifications();
      
      // Refresh notification list
      // This would trigger a refresh in the UI
    } catch (e) {
      print('Error handling foreground resume: $e');
    }
  }

  Future<void> _handleAppTermination() async {
    try {
      // Sync all offline notifications before termination
      await _syncOfflineNotifications();
      
      // Clean up resources
      _syncTimer?.cancel();
      _receivePort.close();
    } catch (e) {
      print('Error handling app termination: $e');
    }
  }

  Future<void> dispose() async {
    try {
      _syncTimer?.cancel();
      _receivePort.close();
      _isRunning = false;
      print('Background notification service disposed');
    } catch (e) {
      print('Error disposing background notification service: $e');
    }
  }

  bool get isRunning => _isRunning;
}

// Background isolate entry point
@pragma('vm:entry-point')
void backgroundNotificationIsolate(SendPort sendPort) {
  final receivePort = ReceivePort();
  sendPort.send(receivePort.sendPort);
  
  receivePort.listen((message) {
    if (message is Map<String, dynamic>) {
      switch (message['type']) {
        case 'process_notification':
          // Process notification in background
          _processNotificationInBackground(message['data']);
          break;
        case 'sync_data':
          // Sync data in background
          _syncDataInBackground(message['data']);
          break;
      }
    }
  });
}

void _processNotificationInBackground(Map<String, dynamic> data) {
  // Process notification data in background isolate
  print('Processing notification in background: ${data['title']}');
}

void _syncDataInBackground(Map<String, dynamic> data) {
  // Sync data in background isolate
  print('Syncing data in background');
}
