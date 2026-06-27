import 'package:reservatior/shared/repositories/user_financial_profile_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetUserFinancialProfileByIdUseCase {
  final UserFinancialProfileRepository _repository;
  GetUserFinancialProfileByIdUseCase(this._repository);
  Future<UserFinancialProfile> execute(String id) => _repository.getById(id);
}

class GetUserFinancialProfilesUseCase {
  final UserFinancialProfileRepository _repository;
  GetUserFinancialProfilesUseCase(this._repository);
  Future<List<UserFinancialProfile>> execute({
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

class CreateUserFinancialProfileUseCase {
  final UserFinancialProfileRepository _repository;
  CreateUserFinancialProfileUseCase(this._repository);
  Future<UserFinancialProfile> execute(UserFinancialProfile item) => _repository.create(item);
}

class UpdateUserFinancialProfileUseCase {
  final UserFinancialProfileRepository _repository;
  UpdateUserFinancialProfileUseCase(this._repository);
  Future<UserFinancialProfile> execute(String id, UserFinancialProfile item) => _repository.update(id, item);
}

class DeleteUserFinancialProfileUseCase {
  final UserFinancialProfileRepository _repository;
  DeleteUserFinancialProfileUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
