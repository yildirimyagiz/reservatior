import '../../features/shared/services/event_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Event

class GetEventByIdUseCase {
  final EventService _service;
  
  GetEventByIdUseCase(this._service);
  
  Future<Event> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetEventsUseCase {
  final EventService _service;
  
  GetEventsUseCase(this._service);
  
  Future<List<Event>> execute({
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

class CreateEventUseCase {
  final EventService _service;
  
  CreateEventUseCase(this._service);
  
  Future<Event> execute(Event event) async {
    // Add validation logic here
    return await _service.create(event);
  }
}

class UpdateEventUseCase {
  final EventService _service;
  
  UpdateEventUseCase(this._service);
  
  Future<Event> execute(String id, Event event) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, event);
  }
}

class DeleteEventUseCase {
  final EventService _service;
  
  DeleteEventUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Event Use Case Container
class EventUseCases {
  final GetEventByIdUseCase getById;
  final GetEventsUseCase getAll;
  final CreateEventUseCase create;
  final UpdateEventUseCase update;
  final DeleteEventUseCase delete;
  
  EventUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory EventUseCases.create(EventService service) {
    return EventUseCases(
      getById: GetEventByIdUseCase(service),
      getAll: GetEventsUseCase(service),
      create: CreateEventUseCase(service),
      update: UpdateEventUseCase(service),
      delete: DeleteEventUseCase(service),
    );
  }
}
