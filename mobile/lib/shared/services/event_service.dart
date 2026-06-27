import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class EventService {
  final DioClient _dioClient;
  EventService(this._dioClient);

  Future<Event> getEventById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.events}/$id');
    return Event.fromJson(response.data['data']);
  }

  Future<List<Event>> getEvents({
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
    final response = await _dioClient.get(ApiEndpoints.events, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Event.fromJson(json)).toList();
  }

  Future<Event> createEvent(Event item) async {
    final response = await _dioClient.post(ApiEndpoints.events, data: item.toJson());
    return Event.fromJson(response.data['data']);
  }

  Future<Event> updateEvent(String id, Event item) async {
    final response = await _dioClient.patch('${ApiEndpoints.events}/$id', data: item.toJson());
    return Event.fromJson(response.data['data']);
  }

  Future<void> deleteEvent(String id) async {
    await _dioClient.delete('${ApiEndpoints.events}/$id');
  }
}
