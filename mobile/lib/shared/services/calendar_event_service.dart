import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class CalendarEventService {
  final DioClient _dioClient;
  CalendarEventService(this._dioClient);

  Future<CalendarEvent> getCalendarEventById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.calendarEvents}/$id');
    return CalendarEvent.fromJson(response.data['data']);
  }

  Future<List<CalendarEvent>> getCalendarEvents({
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
    final response = await _dioClient.get(ApiEndpoints.calendarEvents, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => CalendarEvent.fromJson(json)).toList();
  }

  Future<CalendarEvent> createCalendarEvent(CalendarEvent item) async {
    final response = await _dioClient.post(ApiEndpoints.calendarEvents, data: item.toJson());
    return CalendarEvent.fromJson(response.data['data']);
  }

  Future<CalendarEvent> updateCalendarEvent(String id, CalendarEvent item) async {
    final response = await _dioClient.patch('${ApiEndpoints.calendarEvents}/$id', data: item.toJson());
    return CalendarEvent.fromJson(response.data['data']);
  }

  Future<void> deleteCalendarEvent(String id) async {
    await _dioClient.delete('${ApiEndpoints.calendarEvents}/$id');
  }
}
