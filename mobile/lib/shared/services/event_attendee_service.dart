import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class EventAttendeeService {
  final DioClient _dioClient;
  EventAttendeeService(this._dioClient);

  Future<EventAttendee> getEventAttendeeById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.eventAttendees}/$id');
    return EventAttendee.fromJson(response.data['data']);
  }

  Future<List<EventAttendee>> getEventAttendees({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.eventAttendees, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => EventAttendee.fromJson(json)).toList();
  }

  Future<EventAttendee> createEventAttendee(EventAttendee item) async {
    final response = await _dioClient.post(ApiEndpoints.eventAttendees, data: item.toJson());
    return EventAttendee.fromJson(response.data['data']);
  }

  Future<EventAttendee> updateEventAttendee(String id, EventAttendee item) async {
    final response = await _dioClient.patch('${ApiEndpoints.eventAttendees}/$id', data: item.toJson());
    return EventAttendee.fromJson(response.data['data']);
  }

  Future<void> deleteEventAttendee(String id) async {
    await _dioClient.delete('${ApiEndpoints.eventAttendees}/$id');
  }
}
