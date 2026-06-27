import 'package:reservatior/shared/repositories/user_activity_log_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetUserActivityLogByIdUseCase {
  final UserActivityLogRepository _repository;
  GetUserActivityLogByIdUseCase(this._repository);
  Future<UserActivityLog> execute(String id) => _repository.getById(id);
}

class GetUserActivityLogsUseCase {
  final UserActivityLogRepository _repository;
  GetUserActivityLogsUseCase(this._repository);
  Future<List<UserActivityLog>> execute({
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

class CreateUserActivityLogUseCase {
  final UserActivityLogRepository _repository;
  CreateUserActivityLogUseCase(this._repository);
  Future<UserActivityLog> execute(UserActivityLog item) => _repository.create(item);
}

class UpdateUserActivityLogUseCase {
  final UserActivityLogRepository _repository;
  UpdateUserActivityLogUseCase(this._repository);
  Future<UserActivityLog> execute(String id, UserActivityLog item) => _repository.update(id, item);
}

class DeleteUserActivityLogUseCase {
  final UserActivityLogRepository _repository;
  DeleteUserActivityLogUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
