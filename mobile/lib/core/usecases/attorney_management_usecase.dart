import 'package:reservatior/shared/repositories/attorney_management_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAttorneyManagementByIdUseCase {
  final AttorneyManagementRepository _repository;
  GetAttorneyManagementByIdUseCase(this._repository);
  Future<AttorneyManagement> execute(String id) => _repository.getById(id);
}

class GetAttorneyManagementsUseCase {
  final AttorneyManagementRepository _repository;
  GetAttorneyManagementsUseCase(this._repository);
  Future<List<AttorneyManagement>> execute({
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

class CreateAttorneyManagementUseCase {
  final AttorneyManagementRepository _repository;
  CreateAttorneyManagementUseCase(this._repository);
  Future<AttorneyManagement> execute(AttorneyManagement item) => _repository.create(item);
}

class UpdateAttorneyManagementUseCase {
  final AttorneyManagementRepository _repository;
  UpdateAttorneyManagementUseCase(this._repository);
  Future<AttorneyManagement> execute(String id, AttorneyManagement item) => _repository.update(id, item);
}

class DeleteAttorneyManagementUseCase {
  final AttorneyManagementRepository _repository;
  DeleteAttorneyManagementUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
