import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/event_attendee_service.dart';

abstract class EventAttendeeRepository {
  Future<EventAttendee> getById(String id);
  Future<List<EventAttendee>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<EventAttendee> create(EventAttendee item);
  Future<EventAttendee> update(String id, EventAttendee item);
  Future<void> delete(String id);
}

class EventAttendeeRepositoryImpl implements EventAttendeeRepository {
  final EventAttendeeService _service;
  EventAttendeeRepositoryImpl(this._service);

  @override
  Future<EventAttendee> getById(String id) => _service.getEventAttendeeById(id);

  @override
  Future<List<EventAttendee>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getEventAttendees(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<EventAttendee> create(EventAttendee item) => _service.createEventAttendee(item);

  @override
  Future<EventAttendee> update(String id, EventAttendee item) => _service.updateEventAttendee(id, item);

  @override
  Future<void> delete(String id) => _service.deleteEventAttendee(id);
}
