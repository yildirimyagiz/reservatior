import 'package:reservatior/shared/repositories/calendar_event_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetCalendarEventByIdUseCase {
  final CalendarEventRepository _repository;
  GetCalendarEventByIdUseCase(this._repository);
  Future<CalendarEvent> execute(String id) => _repository.getById(id);
}

class GetCalendarEventsUseCase {
  final CalendarEventRepository _repository;
  GetCalendarEventsUseCase(this._repository);
  Future<List<CalendarEvent>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateCalendarEventUseCase {
  final CalendarEventRepository _repository;
  CreateCalendarEventUseCase(this._repository);
  Future<CalendarEvent> execute(CalendarEvent item) => _repository.create(item);
}

class UpdateCalendarEventUseCase {
  final CalendarEventRepository _repository;
  UpdateCalendarEventUseCase(this._repository);
  Future<CalendarEvent> execute(String id, CalendarEvent item) => _repository.update(id, item);
}

class DeleteCalendarEventUseCase {
  final CalendarEventRepository _repository;
  DeleteCalendarEventUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
