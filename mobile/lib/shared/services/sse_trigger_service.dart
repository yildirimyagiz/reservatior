import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:reservatior/core/network/api_endpoints.dart';

class SseEvent {
  final String event;
  final Map<String, dynamic> payload;
  final DateTime timestamp;

  SseEvent({
    required this.event,
    required this.payload,
    required this.timestamp,
  });

  @override
  String toString() => 'SseEvent(event: $event, payload: $payload)';
}

class SseTriggerService {
  final _storage = const FlutterSecureStorage();
  
  HttpClient? _client;
  HttpClientRequest? _request;
  HttpClientResponse? _response;
  StreamSubscription? _subscription;
  StreamController<SseEvent>? _controller;
  
  bool _isConnected = false;
  bool get isConnected => _isConnected;

  Stream<SseEvent> get eventStream {
    _controller = StreamController<SseEvent>.broadcast(
      onListen: _startConnection,
      onCancel: stopConnection,
    );
    return _controller!.stream;
  }

  Future<void> _startConnection() async {
    if (_isConnected) return;
    
    try {
      final token = await _storage.read(key: 'access_token');
      
      _client = HttpClient()
        ..connectionTimeout = const Duration(seconds: 15);
        
      final streamUrl = '${ApiEndpoints.baseUrl}/api/v1/system/trigger-stream';
      debugPrint('⚡ SSE Connecting to: $streamUrl');
      
      final uri = Uri.parse(streamUrl);
      _request = await _client!.getUrl(uri);
      
      // Set SSE headers
      _request!.headers.set('Accept', 'text/event-stream');
      _request!.headers.set('Cache-Control', 'no-cache');
      _request!.headers.set('Connection', 'keep-alive');
      if (token != null) {
        _request!.headers.set('Authorization', 'Bearer $token');
      }

      _response = await _request!.close();
      
      if (_response!.statusCode != 200) {
        final errorMsg = 'Failed to connect to SSE: ${_response!.statusCode}';
        debugPrint('❌ SSE Error: $errorMsg');
        _controller?.addError(Exception(errorMsg));
        _cleanup();
        _reconnect();
        return;
      }

      _isConnected = true;
      debugPrint('✅ SSE Stream Connected Successfully');

      _subscription = _response!
          .transform(utf8.decoder)
          .transform(const LineSplitter())
          .listen(
        _handleLine,
        onError: (e) {
          debugPrint('❌ SSE Stream Error: $e');
          _controller?.addError(e);
          _handleDisconnect();
        },
        onDone: () {
          debugPrint('ℹ️ SSE Stream Done (Disconnected by server)');
          _handleDisconnect();
        },
        cancelOnError: true,
      );

    } catch (e) {
      debugPrint('❌ SSE Exception: $e');
      _controller?.addError(e);
      _handleDisconnect();
    }
  }

  void _handleLine(String line) {
    if (line.isEmpty) return;
    
    if (line.startsWith('data:')) {
      final dataStr = line.substring(5).trim();
      try {
        final data = jsonDecode(dataStr);
        final event = data['event'] as String?;
        if (event == null || event == 'CONNECTED') return;

        final payload = data['payload'] as Map<String, dynamic>? ?? {};
        
        final sseEvent = SseEvent(
          event: event,
          payload: payload,
          timestamp: DateTime.now(),
        );
        
        debugPrint('⚡ SSE Event Received: $event');
        _controller?.add(sseEvent);
      } catch (e) {
        debugPrint('❌ SSE JSON Parsing Error: $e, line: $line');
      }
    }
  }

  void _handleDisconnect() {
    _cleanup();
    _reconnect();
  }

  void _reconnect() {
    // Attempt reconnect after 5 seconds if controller is active and not closed
    if (_controller != null && !_controller!.isClosed) {
      debugPrint('⚡ SSE Attempting Reconnection in 5 seconds...');
      Future.delayed(const Duration(seconds: 5), () {
        if (_controller != null && !_controller!.isClosed && !_isConnected) {
          _startConnection();
        }
      });
    }
  }

  void _cleanup() {
    _isConnected = false;
    _subscription?.cancel();
    _subscription = null;
    _request?.abort();
    _request = null;
    _client?.close(force: true);
    _client = null;
  }

  void stopConnection() {
    debugPrint('⚡ SSE Stopping Stream Connection');
    _cleanup();
    _controller?.close();
    _controller = null;
  }
}
