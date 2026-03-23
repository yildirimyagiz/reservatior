import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for EventAttendee operations
/// Provides CRUD operations with proper error handling and type safety
class EventAttendeeRepository {
  final DioClient _dioClient;

  EventAttendeeRepository(this._dioClient);

  /// Get EventAttendee by ID
  /// Returns [EventAttendee] if found, throws [RepositoryException] otherwise
  Future<EventAttendee> getEventAttendeeById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/event_attendee/$id');
      if (response.statusCode == 200) {
        return EventAttendee.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch event_attendee',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all event_attendees with pagination and filtering
  /// Returns list of [EventAttendee] objects
  Future<List<EventAttendee>> getevent_attendees({
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
      
      final response = await _dioClient.get('/api/v1/event_attendee', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => EventAttendee.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch event_attendees',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new EventAttendee
  /// Returns created [EventAttendee] object
  Future<EventAttendee> createEventAttendee(EventAttendee eventAttendee) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/event_attendee',
        data: eventAttendee.toJson(),
      );
      return EventAttendee.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update EventAttendee
  Future<EventAttendee> updateEventAttendee(String id, EventAttendee eventAttendee) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/event_attendee/$id',
        data: eventAttendee.toJson(),
      );
      return EventAttendee.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete EventAttendee
  Future<void> deleteEventAttendee(String id) async {
    try {
      await _dioClient.delete('/api/v1/event_attendee/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
