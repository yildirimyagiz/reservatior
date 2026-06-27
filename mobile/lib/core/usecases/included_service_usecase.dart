import 'package:reservatior/shared/repositories/included_service_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetIncludedServiceByIdUseCase {
  final IncludedServiceRepository _repository;
  GetIncludedServiceByIdUseCase(this._repository);
  Future<IncludedService> execute(String id) => _repository.getById(id);
}

class GetIncludedServicesUseCase {
  final IncludedServiceRepository _repository;
  GetIncludedServicesUseCase(this._repository);
  Future<List<IncludedService>> execute({
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

class CreateIncludedServiceUseCase {
  final IncludedServiceRepository _repository;
  CreateIncludedServiceUseCase(this._repository);
  Future<IncludedService> execute(IncludedService item) => _repository.create(item);
}

class UpdateIncludedServiceUseCase {
  final IncludedServiceRepository _repository;
  UpdateIncludedServiceUseCase(this._repository);
  Future<IncludedService> execute(String id, IncludedService item) => _repository.update(id, item);
}

class DeleteIncludedServiceUseCase {
  final IncludedServiceRepository _repository;
  DeleteIncludedServiceUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
