import 'dart:async'; 
import 'package:easy_localization/easy_localization.dart';
import 'dart:convert';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';
import 'notification_service.dart';

class RealtimeNotificationService {
  final DioClient _dioClient;
  final NotificationService _notificationService;
  WebSocketChannel? _channel;
  StreamController<Notification>? _notificationController;
  StreamController<Map<String, dynamic>>? _eventController;
  Timer? _reconnectTimer;
  bool _isConnected = false;
  String? _userId;
  String? _orgId;
  String? _role;
  
  // Event streams
  Stream<Notification> get notificationStream => 
      _notificationController?.stream ?? const Stream.empty();
      
  Stream<Map<String, dynamic>> get eventStream => 
      _eventController?.stream ?? const Stream.empty();
      
  bool get isConnected => _isConnected;

  RealtimeNotificationService(this._dioClient, this._notificationService);

  Future<void> connect({required String userId, required String orgId, String role = 'TENANT_GUEST'}) async {
    if (_isConnected) return;
    
    _userId = userId;
    _orgId = orgId;
    _role = role;
    _notificationController = StreamController<Notification>.broadcast();
    _eventController = StreamController<Map<String, dynamic>>.broadcast();
    
    await _connectWebSocket();
  }

  Future<void> _connectWebSocket() async {
    try {
      // Get WebSocket token
      final response = await _dioClient.get(ApiEndpoints.wsToken);
      final token = response.data['data']['token'];
      
      // Connect to WebSocket
      final wsUrl = '${ApiEndpoints.realtimeWs.replaceFirst('http', 'ws')}/connect?token=$token&userId=$_userId&orgId=$_orgId&role=$_role';
      _channel = WebSocketChannel.connect(Uri.parse(wsUrl));
      
      _isConnected = true;
      _eventController?.add({'type': 'connection', 'status': 'connected'});
      
      // Listen for messages
      _channel!.stream.listen(
        _handleWebSocketMessage,
        onError: _handleWebSocketError,
        onDone: _handleWebSocketDone,
      );
      
    } catch (e) {
      _handleWebSocketError(e);
    }
  }

  void _handleWebSocketMessage(dynamic message) {
    try {
      final data = json.decode(message);
      
      switch (data['type']) {
        case 'notification':
          final notification = Notification.fromJson(data['data']);
          _notificationController?.add(notification);
          _eventController?.add({'type': 'new_notification', 'data': notification});
          break;
          
        case 'notification_read':
          _eventController?.add({'type': 'notification_read', 'notificationId': data['notificationId']});
          break;
          
        case 'notification_deleted':
          _eventController?.add({'type': 'notification_deleted', 'notificationId': data['notificationId']});
          break;
          
        case 'unread_count':
          _eventController?.add({'type': 'unread_count', 'count': data['count']});
          break;
          
        case 'system_event':
          _eventController?.add({'type': 'system_event', 'event': data['event']});
          break;
          
        case 'chat_response':
          _eventController?.add({
            'type': 'chat_response', 
            'content': data['content'], 
            'origin': data['origin'],
            'timestamp': data['timestamp']
          });
          break;
          
        case 'typing_indicator':
          _eventController?.add({
            'type': 'typing_indicator', 
            'active': data['active'],
            'origin': data['origin']
          });
          break;
          
        default:
          _eventController?.add({'type': 'unknown', 'data': data});
      }
    } catch (e) {
      _eventController?.add({'type': 'error', 'message': 'Failed to parse WebSocket message: $e'});
    }
  }

  void _handleWebSocketError(dynamic error) {
    _isConnected = false;
    _eventController?.add({'type': 'error', 'message': 'WebSocket error: $error'});
    
    // Attempt to reconnect after 5 seconds
    _reconnectTimer = Timer(const Duration(seconds: 5), () {
      if (_userId != null && _orgId != null) {
        _connectWebSocket();
      }
    });
  }

  void _handleWebSocketDone() {
    _isConnected = false;
    _eventController?.add({'type': 'connection', 'status': 'disconnected'});
    
    // Attempt to reconnect after 3 seconds
    _reconnectTimer = Timer(const Duration(seconds: 3), () {
      if (_userId != null && _orgId != null) {
        _connectWebSocket();
      }
    });
  }

  Future<void> disconnect() async {
    _reconnectTimer?.cancel();
    _channel?.sink.close();
    _notificationController?.close();
    _eventController?.close();
    _isConnected = false;
  }

  Future<void> markAsRead(String notificationId) async {
    try {
      await _notificationService.updateNotification(notificationId, Notification(
        id: notificationId,
        orgId: _orgId!,
        title: '',
        body: '',
        status: NotificationStatus.READ,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
        org: Organization(
          id: _orgId!, 
          name: '', 
          type: OrgType.AGENCY, 
          region: Region.USA_NORTHEAST, 
          defaultCurrency: 'USD', 
          defaultLocale: 'en-US', 
          taxReportingEnabled: false, 
          complianceTracking: false, 
          createdAt: DateTime.now(), 
          updatedAt: DateTime.now()
        ),
      ));
      
      // Send WebSocket message
      if (_isConnected) {
        _channel?.sink.add(json.encode({
          'type': 'mark_read',
          'notificationId': notificationId,
        }));
      }
    } catch (e) {
      _eventController?.add({'type': 'error', 'message': 'Failed to mark notification as read: $e'});
    }
  }

  Future<void> sendChatMessage(String content) async {
    if (!_isConnected || _channel == null) {
      _eventController?.add({'type': 'error', 'message': 'mobile.leftovers.cannot_send_message_not_connected'.tr()});
      return;
    }
    
    _channel?.sink.add(json.encode({
      'type': 'chat_message',
      'content': content,
      'timestamp': DateTime.now().toIso8601String(),
    }));
  }

  Future<void> markAllAsRead() async {
    try {
      final response = await _dioClient.post('${ApiEndpoints.notifications}/mark-all-read');
      
      // Send WebSocket message
      if (_isConnected) {
        _channel?.sink.add(json.encode({
          'type': 'mark_all_read',
          'userId': _userId,
        }));
      }
      
      _eventController?.add({'type': 'all_marked_read', 'count': response.data['data']['count']});
    } catch (e) {
      _eventController?.add({'type': 'error', 'message': 'Failed to mark all notifications as read: $e'});
    }
  }

  Future<void> deleteNotification(String notificationId) async {
    try {
      await _notificationService.deleteNotification(notificationId);
      
      // Send WebSocket message
      if (_isConnected) {
        _channel?.sink.add(json.encode({
          'type': 'delete_notification',
          'notificationId': notificationId,
        }));
      }
    } catch (e) {
      _eventController?.add({'type': 'error', 'message': 'Failed to delete notification: $e'});
    }
  }

  Future<int> getUnreadCount() async {
    try {
      final response = await _dioClient.get('${ApiEndpoints.notifications}/unread-count');
      return response.data['data']['count'] as int;
    } catch (e) {
      _eventController?.add({'type': 'error', 'message': 'Failed to get unread count: $e'});
      return 0;
    }
  }

  Future<void> subscribeToNotificationTypes(List<String> types) async {
    try {
      if (_isConnected) {
        _channel?.sink.add(json.encode({
          'type': 'subscribe_types',
          'types': types,
        }));
      }
    } catch (e) {
      _eventController?.add({'type': 'error', 'message': 'Failed to subscribe to notification types: $e'});
    }
  }

  Future<void> unsubscribeFromNotificationTypes(List<String> types) async {
    try {
      if (_isConnected) {
        _channel?.sink.add(json.encode({
          'type': 'unsubscribe_types',
          'types': types,
        }));
      }
    } catch (e) {
      _eventController?.add({'type': 'error', 'message': 'Failed to unsubscribe from notification types: $e'});
    }
  }

  Future<void> sendNotification({
    required String userId,
    required String title,
    required String body,
    String? type,
    Map<String, dynamic>? data,
  }) async {
    try {
      await _dioClient.post('${ApiEndpoints.notifications}/send', data: {
        'userId': userId,
        'title': title,
        'body': body,
        if (type != null) 'type': type,
        if (data != null) 'data': data,
      });
    } catch (e) {
      _eventController?.add({'type': 'error', 'message': 'Failed to send notification: $e'});
    }
  }

  Future<void> broadcastNotification({
    required String orgId,
    required String title,
    required String body,
    String? type,
    Map<String, dynamic>? data,
  }) async {
    try {
      await _dioClient.post('${ApiEndpoints.notifications}/broadcast', data: {
        'orgId': orgId,
        'title': title,
        'body': body,
        if (type != null) 'type': type,
        if (data != null) 'data': data,
      });
    } catch (e) {
      _eventController?.add({'type': 'error', 'message': 'Failed to broadcast notification: $e'});
    }
  }

  void dispose() {
    disconnect();
  }
}
