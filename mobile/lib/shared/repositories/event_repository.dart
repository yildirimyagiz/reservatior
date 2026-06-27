import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/event_service.dart';

abstract class EventRepository {
  Future<Event> getById(String id);
  Future<List<Event>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Event> create(Event item);
  Future<Event> update(String id, Event item);
  Future<void> delete(String id);
}

class EventRepositoryImpl implements EventRepository {
  final EventService _service;
  EventRepositoryImpl(this._service);

  @override
  Future<Event> getById(String id) => _service.getEventById(id);

  @override
  Future<List<Event>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getEvents(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Event> create(Event item) => _service.createEvent(item);

  @override
  Future<Event> update(String id, Event item) => _service.updateEvent(id, item);

  @override
  Future<void> delete(String id) => _service.deleteEvent(id);
}
