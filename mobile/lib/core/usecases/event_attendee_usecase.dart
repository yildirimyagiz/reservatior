import '../../features/shared/services/event_attendee_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for EventAttendee

class GetEventAttendeeByIdUseCase {
  final EventAttendeeService _service;
  
  GetEventAttendeeByIdUseCase(this._service);
  
  Future<EventAttendee> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetEventAttendeesUseCase {
  final EventAttendeeService _service;
  
  GetEventAttendeesUseCase(this._service);
  
  Future<List<EventAttendee>> execute({
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

class CreateEventAttendeeUseCase {
  final EventAttendeeService _service;
  
  CreateEventAttendeeUseCase(this._service);
  
  Future<EventAttendee> execute(EventAttendee eventAttendee) async {
    // Add validation logic here
    return await _service.create(eventAttendee);
  }
}

class UpdateEventAttendeeUseCase {
  final EventAttendeeService _service;
  
  UpdateEventAttendeeUseCase(this._service);
  
  Future<EventAttendee> execute(String id, EventAttendee eventAttendee) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, eventAttendee);
  }
}

class DeleteEventAttendeeUseCase {
  final EventAttendeeService _service;
  
  DeleteEventAttendeeUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// EventAttendee Use Case Container
class EventAttendeeUseCases {
  final GetEventAttendeeByIdUseCase getById;
  final GetEventAttendeesUseCase getAll;
  final CreateEventAttendeeUseCase create;
  final UpdateEventAttendeeUseCase update;
  final DeleteEventAttendeeUseCase delete;
  
  EventAttendeeUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory EventAttendeeUseCases.create(EventAttendeeService service) {
    return EventAttendeeUseCases(
      getById: GetEventAttendeeByIdUseCase(service),
      getAll: GetEventAttendeesUseCase(service),
      create: CreateEventAttendeeUseCase(service),
      update: UpdateEventAttendeeUseCase(service),
      delete: DeleteEventAttendeeUseCase(service),
    );
  }
}
