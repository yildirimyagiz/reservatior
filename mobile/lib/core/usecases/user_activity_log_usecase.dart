import '../../features/shared/services/user_activity_log_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for UserActivityLog

class GetUserActivityLogByIdUseCase {
  final UserActivityLogService _service;
  
  GetUserActivityLogByIdUseCase(this._service);
  
  Future<UserActivityLog> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetUserActivityLogsUseCase {
  final UserActivityLogService _service;
  
  GetUserActivityLogsUseCase(this._service);
  
  Future<List<UserActivityLog>> execute({
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

class CreateUserActivityLogUseCase {
  final UserActivityLogService _service;
  
  CreateUserActivityLogUseCase(this._service);
  
  Future<UserActivityLog> execute(UserActivityLog userActivityLog) async {
    // Add validation logic here
    return await _service.create(userActivityLog);
  }
}

class UpdateUserActivityLogUseCase {
  final UserActivityLogService _service;
  
  UpdateUserActivityLogUseCase(this._service);
  
  Future<UserActivityLog> execute(String id, UserActivityLog userActivityLog) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, userActivityLog);
  }
}

class DeleteUserActivityLogUseCase {
  final UserActivityLogService _service;
  
  DeleteUserActivityLogUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// UserActivityLog Use Case Container
class UserActivityLogUseCases {
  final GetUserActivityLogByIdUseCase getById;
  final GetUserActivityLogsUseCase getAll;
  final CreateUserActivityLogUseCase create;
  final UpdateUserActivityLogUseCase update;
  final DeleteUserActivityLogUseCase delete;
  
  UserActivityLogUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory UserActivityLogUseCases.create(UserActivityLogService service) {
    return UserActivityLogUseCases(
      getById: GetUserActivityLogByIdUseCase(service),
      getAll: GetUserActivityLogsUseCase(service),
      create: CreateUserActivityLogUseCase(service),
      update: UpdateUserActivityLogUseCase(service),
      delete: DeleteUserActivityLogUseCase(service),
    );
  }
}
