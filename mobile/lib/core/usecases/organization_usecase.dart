import 'package:reservatior/shared/repositories/organization_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetOrganizationByIdUseCase {
  final OrganizationRepository _repository;
  GetOrganizationByIdUseCase(this._repository);
  Future<Organization> execute(String id) => _repository.getById(id);
}

class GetOrganizationsUseCase {
  final OrganizationRepository _repository;
  GetOrganizationsUseCase(this._repository);
  Future<List<Organization>> execute({
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

class CreateOrganizationUseCase {
  final OrganizationRepository _repository;
  CreateOrganizationUseCase(this._repository);
  Future<Organization> execute(Organization item) => _repository.create(item);
}

class UpdateOrganizationUseCase {
  final OrganizationRepository _repository;
  UpdateOrganizationUseCase(this._repository);
  Future<Organization> execute(String id, Organization item) => _repository.update(id, item);
}

class DeleteOrganizationUseCase {
  final OrganizationRepository _repository;
  DeleteOrganizationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
