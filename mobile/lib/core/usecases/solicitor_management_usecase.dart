import 'package:reservatior/shared/repositories/solicitor_management_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetSolicitorManagementByIdUseCase {
  final SolicitorManagementRepository _repository;
  GetSolicitorManagementByIdUseCase(this._repository);
  Future<SolicitorManagement> execute(String id) => _repository.getById(id);
}

class GetSolicitorManagementsUseCase {
  final SolicitorManagementRepository _repository;
  GetSolicitorManagementsUseCase(this._repository);
  Future<List<SolicitorManagement>> execute({
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

class CreateSolicitorManagementUseCase {
  final SolicitorManagementRepository _repository;
  CreateSolicitorManagementUseCase(this._repository);
  Future<SolicitorManagement> execute(SolicitorManagement item) => _repository.create(item);
}

class UpdateSolicitorManagementUseCase {
  final SolicitorManagementRepository _repository;
  UpdateSolicitorManagementUseCase(this._repository);
  Future<SolicitorManagement> execute(String id, SolicitorManagement item) => _repository.update(id, item);
}

class DeleteSolicitorManagementUseCase {
  final SolicitorManagementRepository _repository;
  DeleteSolicitorManagementUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
