import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/calendar_event_service.dart';

abstract class CalendarEventRepository {
  Future<CalendarEvent> getById(String id);
  Future<List<CalendarEvent>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<CalendarEvent> create(CalendarEvent item);
  Future<CalendarEvent> update(String id, CalendarEvent item);
  Future<void> delete(String id);
}

class CalendarEventRepositoryImpl implements CalendarEventRepository {
  final CalendarEventService _service;
  CalendarEventRepositoryImpl(this._service);

  @override
  Future<CalendarEvent> getById(String id) => _service.getCalendarEventById(id);

  @override
  Future<List<CalendarEvent>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getCalendarEvents(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<CalendarEvent> create(CalendarEvent item) => _service.createCalendarEvent(item);

  @override
  Future<CalendarEvent> update(String id, CalendarEvent item) => _service.updateCalendarEvent(id, item);

  @override
  Future<void> delete(String id) => _service.deleteCalendarEvent(id);
}
