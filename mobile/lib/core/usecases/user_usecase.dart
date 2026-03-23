import '../../features/shared/services/user_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for User

class GetUserByIdUseCase {
  final UserService _service;
  
  GetUserByIdUseCase(this._service);
  
  Future<User> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetUsersUseCase {
  final UserService _service;
  
  GetUsersUseCase(this._service);
  
  Future<List<User>> execute({
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

class CreateUserUseCase {
  final UserService _service;
  
  CreateUserUseCase(this._service);
  
  Future<User> execute(User user) async {
    // Add validation logic here
    return await _service.create(user);
  }
}

class UpdateUserUseCase {
  final UserService _service;
  
  UpdateUserUseCase(this._service);
  
  Future<User> execute(String id, User user) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, user);
  }
}

class DeleteUserUseCase {
  final UserService _service;
  
  DeleteUserUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// User Use Case Container
class UserUseCases {
  final GetUserByIdUseCase getById;
  final GetUsersUseCase getAll;
  final CreateUserUseCase create;
  final UpdateUserUseCase update;
  final DeleteUserUseCase delete;
  
  UserUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory UserUseCases.create(UserService service) {
    return UserUseCases(
      getById: GetUserByIdUseCase(service),
      getAll: GetUsersUseCase(service),
      create: CreateUserUseCase(service),
      update: UpdateUserUseCase(service),
      delete: DeleteUserUseCase(service),
    );
  }
}
