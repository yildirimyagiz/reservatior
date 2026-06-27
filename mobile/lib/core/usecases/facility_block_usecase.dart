import 'package:reservatior/shared/repositories/facility_block_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetFacilityBlockByIdUseCase {
  final FacilityBlockRepository _repository;
  GetFacilityBlockByIdUseCase(this._repository);
  Future<FacilityBlock> execute(String id) => _repository.getById(id);
}

class GetFacilityBlocksUseCase {
  final FacilityBlockRepository _repository;
  GetFacilityBlocksUseCase(this._repository);
  Future<List<FacilityBlock>> execute({
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

class CreateFacilityBlockUseCase {
  final FacilityBlockRepository _repository;
  CreateFacilityBlockUseCase(this._repository);
  Future<FacilityBlock> execute(FacilityBlock item) => _repository.create(item);
}

class UpdateFacilityBlockUseCase {
  final FacilityBlockRepository _repository;
  UpdateFacilityBlockUseCase(this._repository);
  Future<FacilityBlock> execute(String id, FacilityBlock item) => _repository.update(id, item);
}

class DeleteFacilityBlockUseCase {
  final FacilityBlockRepository _repository;
  DeleteFacilityBlockUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
