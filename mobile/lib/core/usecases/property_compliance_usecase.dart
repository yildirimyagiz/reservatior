import 'package:reservatior/shared/repositories/property_compliance_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyComplianceByIdUseCase {
  final PropertyComplianceRepository _repository;
  GetPropertyComplianceByIdUseCase(this._repository);
  Future<PropertyCompliance> execute(String id) => _repository.getById(id);
}

class GetPropertyCompliancesUseCase {
  final PropertyComplianceRepository _repository;
  GetPropertyCompliancesUseCase(this._repository);
  Future<List<PropertyCompliance>> execute({
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

class CreatePropertyComplianceUseCase {
  final PropertyComplianceRepository _repository;
  CreatePropertyComplianceUseCase(this._repository);
  Future<PropertyCompliance> execute(PropertyCompliance item) => _repository.create(item);
}

class UpdatePropertyComplianceUseCase {
  final PropertyComplianceRepository _repository;
  UpdatePropertyComplianceUseCase(this._repository);
  Future<PropertyCompliance> execute(String id, PropertyCompliance item) => _repository.update(id, item);
}

class DeletePropertyComplianceUseCase {
  final PropertyComplianceRepository _repository;
  DeletePropertyComplianceUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
