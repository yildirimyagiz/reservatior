import 'dart:async'; 
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'dart:math' as math;

import 'package:flutter_local_notifications/flutter_local_notifications.dart' as fln;
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart' as models;

class PushNotificationService {
  final DioClient _dioClient;
  final fln.FlutterLocalNotificationsPlugin _localNotifications;
  String? _deviceToken;
  StreamController<Map<String, dynamic>>? _messageController;
  
  // Message streams
  Stream<Map<String, dynamic>> get messageStream => 
      _messageController?.stream ?? const Stream.empty();

  PushNotificationService(this._dioClient)
      : _localNotifications = fln.FlutterLocalNotificationsPlugin();

  Future<void> initialize() async {
    _messageController = StreamController<Map<String, dynamic>>.broadcast();
    
    // Initialize local notifications
    await _initializeLocalNotifications();
    
    // Generate device token (mock for custom notification system)
    await _generateDeviceToken();
    
    // Setup message handlers
    _setupMessageHandlers();
  }

  Future<void> _generateDeviceToken() async {
    try {
      // Mock permission request
      print('Mock: User granted permission');

      // Mock device token
      _deviceToken = 'mock_device_token_${DateTime.now().millisecondsSinceEpoch}';

      
      if (_deviceToken != null) {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('device_token', _deviceToken!);
        print('FCM Token: $_deviceToken');
        
        // Save token to server
        await _saveDeviceTokenToServer(_deviceToken!);
      }
    } catch (e) {
      print('Error getting FCM token: $e');
    }
  }

  Future<void> _initializeLocalNotifications() async {
    const fln.AndroidInitializationSettings initializationSettingsAndroid =
        fln.AndroidInitializationSettings('@mipmap/ic_launcher');

    const fln.DarwinInitializationSettings initializationSettingsIOS =
        fln.DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );

    const fln.InitializationSettings initializationSettings = fln.InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    await _localNotifications.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create notification channels for Android
    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.android) {
      await _createNotificationChannels();
    }
  }

  Future<void> _createNotificationChannels() async {
    fln.AndroidNotificationChannel generalChannel = fln.AndroidNotificationChannel(
      'general_channel',
      'mobile.leftovers.general_notifications'.tr(),
      description: 'mobile.leftovers.general_app_notifications'.tr(),
      importance: fln.Importance.high,
    );

    fln.AndroidNotificationChannel messageChannel = fln.AndroidNotificationChannel(
      'message_channel',
      'Messages',
      description: 'mobile.leftovers.chat_and_communication_notifications'.tr(),
      importance: fln.Importance.high,
    );

    fln.AndroidNotificationChannel propertyChannel = fln.AndroidNotificationChannel(
      'property_channel',
      'mobile.leftovers.property_updates'.tr(),
      description: 'mobile.leftovers.property_related_notifications'.tr(),
      importance: fln.Importance.defaultImportance,
    );

    fln.AndroidNotificationChannel systemChannel = fln.AndroidNotificationChannel(
      'system_channel',
      'System',
      description: 'mobile.leftovers.system_and_maintenance_notifications'.tr(),
      importance: fln.Importance.low,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            fln.AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(generalChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            fln.AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(messageChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            fln.AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(propertyChannel);

    await _localNotifications
        .resolvePlatformSpecificImplementation<
            fln.AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(systemChannel);
  }

  Future<void> _saveDeviceTokenToServer(String token) async {
    try {
      await _dioClient.post('${ApiEndpoints.notifications}/device-token', data: {
        'token': token,
        'platform': kIsWeb ? 'web' : (defaultTargetPlatform == TargetPlatform.iOS ? 'ios' : 'android'),
        'version': kIsWeb ? 'web' : Platform.operatingSystemVersion,
      });
    } catch (e) {
      print('Failed to save device token to server: $e');
    }
  }

  void _setupMessageHandlers() {
    // For custom notification system, you would set up your own message handlers
    // This could be WebSocket connections, periodic polling, or your custom push service
    
    // Mock message handler for demonstration
    Timer.periodic(const Duration(minutes: 5), (timer) {
      _checkForNewNotifications();
    });
  }

  Future<void> _checkForNewNotifications() async {
    try {
      // Poll your server for new notifications
      final response = await _dioClient.get('${ApiEndpoints.notifications}/check');
      
      if (response.statusCode == 200 && response.data != null) {
        final notifications = response.data['notifications'] as List<dynamic>?;
        if (notifications != null && notifications.isNotEmpty) {
          for (final notification in notifications) {
            _handleIncomingNotification(notification as Map<String, dynamic>);
          }
        }
      }
    } catch (e) {
      print('Error checking for new notifications: $e');
    }
  }

  Future<void> _handleIncomingNotification(Map<String, dynamic> notificationData) async {
    try {
      print('Received notification: $notificationData');
      
      // Show local notification
      await _showLocalNotificationFromData(notificationData);
      
      // Send to stream for UI handling
      _messageController?.add(notificationData);
    } catch (e) {
      print('Error handling incoming notification: $e');
    }
  }

  Future<void> _showLocalNotificationFromData(Map<String, dynamic> data) async {
    try {
      final title = data['title'] as String? ?? 'Notification';
      final body = data['body'] as String? ?? '';
      
      fln.NotificationDetails notificationDetails = fln.NotificationDetails(
        android: fln.AndroidNotificationDetails(
          'general_channel',
          'mobile.leftovers.general_notifications'.tr(),
          channelDescription: 'mobile.leftovers.general_app_notifications'.tr(),
          importance: fln.Importance.high,
          priority: fln.Priority.high,
          showWhen: true,
          icon: '@mipmap/ic_launcher',
        ),
        iOS: fln.DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentSound: true,
        ),
      );

      await _localNotifications.show(
        DateTime.now().millisecondsSinceEpoch.remainder(100000),
        title,
        body,
        notificationDetails,
      );
    } catch (e) {
      print('Error showing local notification: $e');
    }
  }

  // Public methods for your custom notification system
  Future<void> showNotification(String title, String body, {Map<String, dynamic>? data}) async {
    await _showLocalNotificationFromData({
      'title': title,
      'body': body,
      if (data != null) ...data,
    });
  }

  Future<void> subscribeToTopic(String topic) async {
    try {
      // Subscribe to topic in your custom notification system
      await _dioClient.post('${ApiEndpoints.notifications}/subscribe', data: {
        'topic': topic,
        'deviceToken': _deviceToken,
      });
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Failed to subscribe to topic: $e');
    }
  }

  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      // Unsubscribe from topic in your custom notification system
      await _dioClient.post('${ApiEndpoints.notifications}/unsubscribe', data: {
        'topic': topic,
        'deviceToken': _deviceToken,
      });
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Failed to unsubscribe from topic: $e');
    }
  }

  void _onNotificationTapped(fln.NotificationResponse response) {
    print('Local notification tapped: ${response.payload}');
    
    if (response.payload != null) {
      try {
        final data = jsonDecode(response.payload!);
        _messageController?.add({
          'type': 'local_notification_tapped',
          'data': data,
        });
      } catch (e) {
        print('Failed to parse notification payload: $e');
      }
    }
  }

  Future<void> clearAllNotifications() async {
    try {
      await _localNotifications.cancelAll();
      // Generate new device token for fresh start
      await _generateDeviceToken();
    } catch (e) {
      print('Failed to clear all notifications: $e');
    }
  }

  Future<List<models.Notification>> getOfflineNotifications() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final offlineNotifications = prefs.getStringList('offline_notifications') ?? [];
      
      final notifications = <models.Notification>[];
      for (var jsonString in offlineNotifications) {
        try {
          final Map<String, dynamic> data = jsonDecode(jsonString);
          notifications.add(models.Notification.fromJson(data));
        } catch (e) {
          print('Error parsing offline notification: $e');
        }
      }
      return notifications;
    } catch (e) {
      print('Failed to get offline notifications: $e');
      return [];
    }
  }

  void dispose() {
    _messageController?.close();
  }
}
