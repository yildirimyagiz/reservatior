import 'package:reservatior/shared/repositories/user_preference_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetUserPreferenceByIdUseCase {
  final UserPreferenceRepository _repository;
  GetUserPreferenceByIdUseCase(this._repository);
  Future<UserPreference> execute(String id) => _repository.getById(id);
}

class GetUserPreferencesUseCase {
  final UserPreferenceRepository _repository;
  GetUserPreferencesUseCase(this._repository);
  Future<List<UserPreference>> execute({
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

class CreateUserPreferenceUseCase {
  final UserPreferenceRepository _repository;
  CreateUserPreferenceUseCase(this._repository);
  Future<UserPreference> execute(UserPreference item) => _repository.create(item);
}

class UpdateUserPreferenceUseCase {
  final UserPreferenceRepository _repository;
  UpdateUserPreferenceUseCase(this._repository);
  Future<UserPreference> execute(String id, UserPreference item) => _repository.update(id, item);
}

class DeleteUserPreferenceUseCase {
  final UserPreferenceRepository _repository;
  DeleteUserPreferenceUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
