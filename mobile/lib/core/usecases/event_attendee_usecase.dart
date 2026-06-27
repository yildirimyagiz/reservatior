import 'package:reservatior/shared/repositories/event_attendee_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetEventAttendeeByIdUseCase {
  final EventAttendeeRepository _repository;
  GetEventAttendeeByIdUseCase(this._repository);
  Future<EventAttendee> execute(String id) => _repository.getById(id);
}

class GetEventAttendeesUseCase {
  final EventAttendeeRepository _repository;
  GetEventAttendeesUseCase(this._repository);
  Future<List<EventAttendee>> execute({
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

class CreateEventAttendeeUseCase {
  final EventAttendeeRepository _repository;
  CreateEventAttendeeUseCase(this._repository);
  Future<EventAttendee> execute(EventAttendee item) => _repository.create(item);
}

class UpdateEventAttendeeUseCase {
  final EventAttendeeRepository _repository;
  UpdateEventAttendeeUseCase(this._repository);
  Future<EventAttendee> execute(String id, EventAttendee item) => _repository.update(id, item);
}

class DeleteEventAttendeeUseCase {
  final EventAttendeeRepository _repository;
  DeleteEventAttendeeUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
