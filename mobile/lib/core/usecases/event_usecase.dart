import 'package:reservatior/shared/repositories/event_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetEventByIdUseCase {
  final EventRepository _repository;
  GetEventByIdUseCase(this._repository);
  Future<Event> execute(String id) => _repository.getById(id);
}

class GetEventsUseCase {
  final EventRepository _repository;
  GetEventsUseCase(this._repository);
  Future<List<Event>> execute({
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

class CreateEventUseCase {
  final EventRepository _repository;
  CreateEventUseCase(this._repository);
  Future<Event> execute(Event item) => _repository.create(item);
}

class UpdateEventUseCase {
  final EventRepository _repository;
  UpdateEventUseCase(this._repository);
  Future<Event> execute(String id, Event item) => _repository.update(id, item);
}

class DeleteEventUseCase {
  final EventRepository _repository;
  DeleteEventUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
