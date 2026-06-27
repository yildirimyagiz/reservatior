import 'package:reservatior/shared/repositories/maintenance_block_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMaintenanceBlockByIdUseCase {
  final MaintenanceBlockRepository _repository;
  GetMaintenanceBlockByIdUseCase(this._repository);
  Future<MaintenanceBlock> execute(String id) => _repository.getById(id);
}

class GetMaintenanceBlocksUseCase {
  final MaintenanceBlockRepository _repository;
  GetMaintenanceBlocksUseCase(this._repository);
  Future<List<MaintenanceBlock>> execute({
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

class CreateMaintenanceBlockUseCase {
  final MaintenanceBlockRepository _repository;
  CreateMaintenanceBlockUseCase(this._repository);
  Future<MaintenanceBlock> execute(MaintenanceBlock item) => _repository.create(item);
}

class UpdateMaintenanceBlockUseCase {
  final MaintenanceBlockRepository _repository;
  UpdateMaintenanceBlockUseCase(this._repository);
  Future<MaintenanceBlock> execute(String id, MaintenanceBlock item) => _repository.update(id, item);
}

class DeleteMaintenanceBlockUseCase {
  final MaintenanceBlockRepository _repository;
  DeleteMaintenanceBlockUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
