import '../../features/shared/services/user_preference_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for UserPreference

class GetUserPreferenceByIdUseCase {
  final UserPreferenceService _service;
  
  GetUserPreferenceByIdUseCase(this._service);
  
  Future<UserPreference> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetUserPreferencesUseCase {
  final UserPreferenceService _service;
  
  GetUserPreferencesUseCase(this._service);
  
  Future<List<UserPreference>> execute({
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

class CreateUserPreferenceUseCase {
  final UserPreferenceService _service;
  
  CreateUserPreferenceUseCase(this._service);
  
  Future<UserPreference> execute(UserPreference userPreference) async {
    // Add validation logic here
    return await _service.create(userPreference);
  }
}

class UpdateUserPreferenceUseCase {
  final UserPreferenceService _service;
  
  UpdateUserPreferenceUseCase(this._service);
  
  Future<UserPreference> execute(String id, UserPreference userPreference) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, userPreference);
  }
}

class DeleteUserPreferenceUseCase {
  final UserPreferenceService _service;
  
  DeleteUserPreferenceUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// UserPreference Use Case Container
class UserPreferenceUseCases {
  final GetUserPreferenceByIdUseCase getById;
  final GetUserPreferencesUseCase getAll;
  final CreateUserPreferenceUseCase create;
  final UpdateUserPreferenceUseCase update;
  final DeleteUserPreferenceUseCase delete;
  
  UserPreferenceUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory UserPreferenceUseCases.create(UserPreferenceService service) {
    return UserPreferenceUseCases(
      getById: GetUserPreferenceByIdUseCase(service),
      getAll: GetUserPreferencesUseCase(service),
      create: CreateUserPreferenceUseCase(service),
      update: UpdateUserPreferenceUseCase(service),
      delete: DeleteUserPreferenceUseCase(service),
    );
  }
}
