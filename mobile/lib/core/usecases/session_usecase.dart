import 'package:reservatior/shared/repositories/session_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSessionByIdUseCase {
  final SessionRepository _repository;
  GetSessionByIdUseCase(this._repository);
  Future<Session> execute(String id) => _repository.getById(id);
}

class GetSessionsUseCase {
  final SessionRepository _repository;
  GetSessionsUseCase(this._repository);
  Future<List<Session>> execute({
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

class CreateSessionUseCase {
  final SessionRepository _repository;
  CreateSessionUseCase(this._repository);
  Future<Session> execute(Session item) => _repository.create(item);
}

class UpdateSessionUseCase {
  final SessionRepository _repository;
  UpdateSessionUseCase(this._repository);
  Future<Session> execute(String id, Session item) => _repository.update(id, item);
}

class DeleteSessionUseCase {
  final SessionRepository _repository;
  DeleteSessionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
