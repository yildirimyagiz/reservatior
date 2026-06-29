import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

/// A robust Telemetry Service for the Agent OS mobile app.
/// Implements offline queuing, event batching, and retry logic to ensure
/// behavioral data is never lost, even in areas with poor connectivity.
class TelemetryService {
  static final TelemetryService _instance = TelemetryService._internal();
  factory TelemetryService() => _instance;
  TelemetryService._internal();

  // In production, this would be backed by SharedPreferences or Hive for persistence.
  final List<Map<String, dynamic>> _offlineQueue = [];
  Timer? _flushTimer;
  bool _isFlushing = false;
  
  // Replace with your actual backend API URL
  final String _apiUrl = 'https://api.reservatior.com/api/v1/telemetry/event';

  void initialize() {
    // Start the periodic sync worker to flush offline events
    _flushTimer = Timer.periodic(const Duration(seconds: 15), (_) {
      _flushQueue();
    });
  }

  /// Log a domain event to feed the Decision Graph
  void logEvent({
    required String eventName,
    required String entityId,
    required String entityType,
    Map<String, dynamic>? payload,
  }) {
    final event = {
      'eventName': eventName,
      'entityId': entityId,
      'entityType': entityType,
      'source': 'MOBILE_APP',
      'payload': payload,
      'timestamp': DateTime.now().toIso8601String(),
    };

    _offlineQueue.add(event);
    
    // Attempt immediate flush if we have 5 or more events
    if (_offlineQueue.length >= 5) {
      _flushQueue();
    }
  }

  Future<void> _flushQueue() async {
    if (_isFlushing || _offlineQueue.isEmpty) return;
    _isFlushing = true;

    // Take a snapshot of the current queue
    final batch = List<Map<String, dynamic>>.from(_offlineQueue);

    try {
      // In a real implementation, you might have a bulk endpoint: POST /telemetry/batch
      // For now, we simulate firing them one by one.
      for (final event in batch) {
        final response = await http.post(
          Uri.parse(_apiUrl),
          headers: {'Content-Type': 'application/json'},
          body: jsonEncode(event),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          _offlineQueue.remove(event); // Remove successful event from original queue
        } else {
          throw Exception('Failed to send event: ${response.statusCode}');
        }
      }
      print('[Telemetry] Successfully flushed ${batch.length} events.');
    } catch (e) {
      print('[Telemetry] Flush failed, events remain in offline queue. Error: $e');
      // Events remain in _offlineQueue for the next retry interval.
    } finally {
      _isFlushing = false;
    }
  }

  void dispose() {
    _flushTimer?.cancel();
  }
}
