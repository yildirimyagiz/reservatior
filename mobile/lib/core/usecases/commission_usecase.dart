import 'package:reservatior/shared/repositories/commission_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetCommissionByIdUseCase {
  final CommissionRepository _repository;
  GetCommissionByIdUseCase(this._repository);
  Future<Commission> execute(String id) => _repository.getById(id);
}

class GetCommissionsUseCase {
  final CommissionRepository _repository;
  GetCommissionsUseCase(this._repository);
  Future<List<Commission>> execute({
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

class CreateCommissionUseCase {
  final CommissionRepository _repository;
  CreateCommissionUseCase(this._repository);
  Future<Commission> execute(Commission item) => _repository.create(item);
}

class UpdateCommissionUseCase {
  final CommissionRepository _repository;
  UpdateCommissionUseCase(this._repository);
  Future<Commission> execute(String id, Commission item) => _repository.update(id, item);
}

class DeleteCommissionUseCase {
  final CommissionRepository _repository;
  DeleteCommissionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
