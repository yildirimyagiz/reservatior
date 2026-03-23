import '../../features/shared/services/user_financial_profile_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for UserFinancialProfile

class GetUserFinancialProfileByIdUseCase {
  final UserFinancialProfileService _service;
  
  GetUserFinancialProfileByIdUseCase(this._service);
  
  Future<UserFinancialProfile> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetUserFinancialProfilesUseCase {
  final UserFinancialProfileService _service;
  
  GetUserFinancialProfilesUseCase(this._service);
  
  Future<List<UserFinancialProfile>> execute({
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

class CreateUserFinancialProfileUseCase {
  final UserFinancialProfileService _service;
  
  CreateUserFinancialProfileUseCase(this._service);
  
  Future<UserFinancialProfile> execute(UserFinancialProfile userFinancialProfile) async {
    // Add validation logic here
    return await _service.create(userFinancialProfile);
  }
}

class UpdateUserFinancialProfileUseCase {
  final UserFinancialProfileService _service;
  
  UpdateUserFinancialProfileUseCase(this._service);
  
  Future<UserFinancialProfile> execute(String id, UserFinancialProfile userFinancialProfile) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, userFinancialProfile);
  }
}

class DeleteUserFinancialProfileUseCase {
  final UserFinancialProfileService _service;
  
  DeleteUserFinancialProfileUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// UserFinancialProfile Use Case Container
class UserFinancialProfileUseCases {
  final GetUserFinancialProfileByIdUseCase getById;
  final GetUserFinancialProfilesUseCase getAll;
  final CreateUserFinancialProfileUseCase create;
  final UpdateUserFinancialProfileUseCase update;
  final DeleteUserFinancialProfileUseCase delete;
  
  UserFinancialProfileUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory UserFinancialProfileUseCases.create(UserFinancialProfileService service) {
    return UserFinancialProfileUseCases(
      getById: GetUserFinancialProfileByIdUseCase(service),
      getAll: GetUserFinancialProfilesUseCase(service),
      create: CreateUserFinancialProfileUseCase(service),
      update: UpdateUserFinancialProfileUseCase(service),
      delete: DeleteUserFinancialProfileUseCase(service),
    );
  }
}
