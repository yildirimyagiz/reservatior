import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class EventAttendeeService {
  final DioClient _dioClient;

  EventAttendeeService(this._dioClient);

  // Get EventAttendee by ID
  Future<EventAttendee> getEventAttendeeById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/event_attendee/$id');
      return EventAttendee.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all event_attendees
  Future<List<EventAttendee>> getEventAttendees({
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

      final response = await _dioClient.get('/api/v1/event_attendee', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => EventAttendee.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create EventAttendee
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
    return Exception('API Error: ${e.message}');
  }
}
