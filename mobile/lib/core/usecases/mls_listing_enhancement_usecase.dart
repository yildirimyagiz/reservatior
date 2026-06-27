import 'package:reservatior/shared/repositories/mls_listing_enhancement_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMlsListingEnhancementByIdUseCase {
  final MlsListingEnhancementRepository _repository;
  GetMlsListingEnhancementByIdUseCase(this._repository);
  Future<MlsListingEnhancement> execute(String id) => _repository.getById(id);
}

class GetMlsListingEnhancementsUseCase {
  final MlsListingEnhancementRepository _repository;
  GetMlsListingEnhancementsUseCase(this._repository);
  Future<List<MlsListingEnhancement>> execute({
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

class CreateMlsListingEnhancementUseCase {
  final MlsListingEnhancementRepository _repository;
  CreateMlsListingEnhancementUseCase(this._repository);
  Future<MlsListingEnhancement> execute(MlsListingEnhancement item) => _repository.create(item);
}

class UpdateMlsListingEnhancementUseCase {
  final MlsListingEnhancementRepository _repository;
  UpdateMlsListingEnhancementUseCase(this._repository);
  Future<MlsListingEnhancement> execute(String id, MlsListingEnhancement item) => _repository.update(id, item);
}

class DeleteMlsListingEnhancementUseCase {
  final MlsListingEnhancementRepository _repository;
  DeleteMlsListingEnhancementUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
