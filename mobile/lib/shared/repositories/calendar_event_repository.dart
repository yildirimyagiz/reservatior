import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for CalendarEvent operations
/// Provides CRUD operations with proper error handling and type safety
class CalendarEventRepository {
  final DioClient _dioClient;

  CalendarEventRepository(this._dioClient);

  /// Get CalendarEvent by ID
  /// Returns [CalendarEvent] if found, throws [RepositoryException] otherwise
  Future<CalendarEvent> getCalendarEventById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/calendar_event/$id');
      if (response.statusCode == 200) {
        return CalendarEvent.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch calendar_event',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all calendar_events with pagination and filtering
  /// Returns list of [CalendarEvent] objects
  Future<List<CalendarEvent>> getcalendar_events({
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
      
      final response = await _dioClient.get('/api/v1/calendar_event', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => CalendarEvent.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch calendar_events',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new CalendarEvent
  /// Returns created [CalendarEvent] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
