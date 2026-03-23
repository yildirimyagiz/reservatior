import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class CalendarEventService {
  final DioClient _dioClient;

  CalendarEventService(this._dioClient);

  // Get CalendarEvent by ID
  Future<CalendarEvent> getCalendarEventById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/calendar_event/$id');
      return CalendarEvent.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all calendar_events
  Future<List<CalendarEvent>> getCalendarEvents({
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

      final response = await _dioClient.get('/api/v1/calendar_event', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => CalendarEvent.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create CalendarEvent
  Future<CalendarEvent> createCalendarEvent(CalendarEvent calendarEvent) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/calendar_event',
        data: calendarEvent.toJson(),
      );
      return CalendarEvent.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update CalendarEvent
  Future<CalendarEvent> updateCalendarEvent(String id, CalendarEvent calendarEvent) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/calendar_event/$id',
        data: calendarEvent.toJson(),
      );
      return CalendarEvent.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete CalendarEvent
  Future<void> deleteCalendarEvent(String id) async {
    try {
      await _dioClient.delete('/api/v1/calendar_event/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
