import 'package:reservatior/shared/repositories/user_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetUserByIdUseCase {
  final UserRepository _repository;
  GetUserByIdUseCase(this._repository);
  Future<User> execute(String id) => _repository.getById(id);
}

class GetUsersUseCase {
  final UserRepository _repository;
  GetUsersUseCase(this._repository);
  Future<List<User>> execute({
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

class CreateUserUseCase {
  final UserRepository _repository;
  CreateUserUseCase(this._repository);
  Future<User> execute(User item) => _repository.create(item);
}

class UpdateUserUseCase {
  final UserRepository _repository;
  UpdateUserUseCase(this._repository);
  Future<User> execute(String id, User item) => _repository.update(id, item);
}

class DeleteUserUseCase {
  final UserRepository _repository;
  DeleteUserUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
