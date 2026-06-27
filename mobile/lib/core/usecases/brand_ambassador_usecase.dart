import 'package:reservatior/shared/repositories/brand_ambassador_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetBrandAmbassadorByIdUseCase {
  final BrandAmbassadorRepository _repository;
  GetBrandAmbassadorByIdUseCase(this._repository);
  Future<BrandAmbassador> execute(String id) => _repository.getById(id);
}

class GetBrandAmbassadorsUseCase {
  final BrandAmbassadorRepository _repository;
  GetBrandAmbassadorsUseCase(this._repository);
  Future<List<BrandAmbassador>> execute({
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

class CreateBrandAmbassadorUseCase {
  final BrandAmbassadorRepository _repository;
  CreateBrandAmbassadorUseCase(this._repository);
  Future<BrandAmbassador> execute(BrandAmbassador item) => _repository.create(item);
}

class UpdateBrandAmbassadorUseCase {
  final BrandAmbassadorRepository _repository;
  UpdateBrandAmbassadorUseCase(this._repository);
  Future<BrandAmbassador> execute(String id, BrandAmbassador item) => _repository.update(id, item);
}

class DeleteBrandAmbassadorUseCase {
  final BrandAmbassadorRepository _repository;
  DeleteBrandAmbassadorUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
