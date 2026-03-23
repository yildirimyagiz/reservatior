import '../../features/shared/services/session_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Session

class GetSessionByIdUseCase {
  final SessionService _service;
  
  GetSessionByIdUseCase(this._service);
  
  Future<Session> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetSessionsUseCase {
  final SessionService _service;
  
  GetSessionsUseCase(this._service);
  
  Future<List<Session>> execute({
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

class CreateSessionUseCase {
  final SessionService _service;
  
  CreateSessionUseCase(this._service);
  
  Future<Session> execute(Session session) async {
    // Add validation logic here
    return await _service.create(session);
  }
}

class UpdateSessionUseCase {
  final SessionService _service;
  
  UpdateSessionUseCase(this._service);
  
  Future<Session> execute(String id, Session session) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, session);
  }
}

class DeleteSessionUseCase {
  final SessionService _service;
  
  DeleteSessionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Session Use Case Container
class SessionUseCases {
  final GetSessionByIdUseCase getById;
  final GetSessionsUseCase getAll;
  final CreateSessionUseCase create;
  final UpdateSessionUseCase update;
  final DeleteSessionUseCase delete;
  
  SessionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory SessionUseCases.create(SessionService service) {
    return SessionUseCases(
      getById: GetSessionByIdUseCase(service),
      getAll: GetSessionsUseCase(service),
      create: CreateSessionUseCase(service),
      update: UpdateSessionUseCase(service),
      delete: DeleteSessionUseCase(service),
    );
  }
}
