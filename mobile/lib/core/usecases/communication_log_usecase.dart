import 'package:reservatior/shared/repositories/communication_log_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetCommunicationLogByIdUseCase {
  final CommunicationLogRepository _repository;
  GetCommunicationLogByIdUseCase(this._repository);
  Future<CommunicationLog> execute(String id) => _repository.getById(id);
}

class GetCommunicationLogsUseCase {
  final CommunicationLogRepository _repository;
  GetCommunicationLogsUseCase(this._repository);
  Future<List<CommunicationLog>> execute({
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

class CreateCommunicationLogUseCase {
  final CommunicationLogRepository _repository;
  CreateCommunicationLogUseCase(this._repository);
  Future<CommunicationLog> execute(CommunicationLog item) => _repository.create(item);
}

class UpdateCommunicationLogUseCase {
  final CommunicationLogRepository _repository;
  UpdateCommunicationLogUseCase(this._repository);
  Future<CommunicationLog> execute(String id, CommunicationLog item) => _repository.update(id, item);
}

class DeleteCommunicationLogUseCase {
  final CommunicationLogRepository _repository;
  DeleteCommunicationLogUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
