import '../../features/shared/services/calendar_event_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for CalendarEvent

class GetCalendarEventByIdUseCase {
  final CalendarEventService _service;
  
  GetCalendarEventByIdUseCase(this._service);
  
  Future<CalendarEvent> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetCalendarEventsUseCase {
  final CalendarEventService _service;
  
  GetCalendarEventsUseCase(this._service);
  
  Future<List<CalendarEvent>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateCalendarEventUseCase {
  final CalendarEventService _service;
  
  CreateCalendarEventUseCase(this._service);
  
  Future<CalendarEvent> execute(CalendarEvent calendarEvent) async {
    // Add validation logic here
    return await _service.create(calendarEvent);
  }
}

class UpdateCalendarEventUseCase {
  final CalendarEventService _service;
  
  UpdateCalendarEventUseCase(this._service);
  
  Future<CalendarEvent> execute(String id, CalendarEvent calendarEvent) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, calendarEvent);
  }
}

class DeleteCalendarEventUseCase {
  final CalendarEventService _service;
  
  DeleteCalendarEventUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// CalendarEvent Use Case Container
class CalendarEventUseCases {
  final GetCalendarEventByIdUseCase getById;
  final GetCalendarEventsUseCase getAll;
  final CreateCalendarEventUseCase create;
  final UpdateCalendarEventUseCase update;
  final DeleteCalendarEventUseCase delete;
  
  CalendarEventUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory CalendarEventUseCases.create(CalendarEventService service) {
    return CalendarEventUseCases(
      getById: GetCalendarEventByIdUseCase(service),
      getAll: GetCalendarEventsUseCase(service),
      create: CreateCalendarEventUseCase(service),
      update: UpdateCalendarEventUseCase(service),
      delete: DeleteCalendarEventUseCase(service),
    );
  }
}
