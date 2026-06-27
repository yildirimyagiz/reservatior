import 'package:reservatior/shared/repositories/facility_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetFacilityByIdUseCase {
  final FacilityRepository _repository;
  GetFacilityByIdUseCase(this._repository);
  Future<Facility> execute(String id) => _repository.getById(id);
}

class GetFacilitysUseCase {
  final FacilityRepository _repository;
  GetFacilitysUseCase(this._repository);
  Future<List<Facility>> execute({
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

class CreateFacilityUseCase {
  final FacilityRepository _repository;
  CreateFacilityUseCase(this._repository);
  Future<Facility> execute(Facility item) => _repository.create(item);
}

class UpdateFacilityUseCase {
  final FacilityRepository _repository;
  UpdateFacilityUseCase(this._repository);
  Future<Facility> execute(String id, Facility item) => _repository.update(id, item);
}

class DeleteFacilityUseCase {
  final FacilityRepository _repository;
  DeleteFacilityUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
