import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class EventService {
  final DioClient _dioClient;

  EventService(this._dioClient);

  // Get Event by ID
  Future<Event> getEventById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/event/$id');
      return Event.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all events
  Future<List<Event>> getEvents({
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

      final response = await _dioClient.get('/api/v1/event', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Event.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Event
  Future<Event> createEvent(Event event) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/event',
        data: event.toJson(),
      );
      return Event.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Event
  Future<Event> updateEvent(String id, Event event) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/event/$id',
        data: event.toJson(),
      );
      return Event.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Event
  Future<void> deleteEvent(String id) async {
    try {
      await _dioClient.delete('/api/v1/event/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
