import 'package:reservatior/shared/repositories/property_promotion_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyPromotionByIdUseCase {
  final PropertyPromotionRepository _repository;
  GetPropertyPromotionByIdUseCase(this._repository);
  Future<PropertyPromotion> execute(String id) => _repository.getById(id);
}

class GetPropertyPromotionsUseCase {
  final PropertyPromotionRepository _repository;
  GetPropertyPromotionsUseCase(this._repository);
  Future<List<PropertyPromotion>> execute({
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

class CreatePropertyPromotionUseCase {
  final PropertyPromotionRepository _repository;
  CreatePropertyPromotionUseCase(this._repository);
  Future<PropertyPromotion> execute(PropertyPromotion item) => _repository.create(item);
}

class UpdatePropertyPromotionUseCase {
  final PropertyPromotionRepository _repository;
  UpdatePropertyPromotionUseCase(this._repository);
  Future<PropertyPromotion> execute(String id, PropertyPromotion item) => _repository.update(id, item);
}

class DeletePropertyPromotionUseCase {
  final PropertyPromotionRepository _repository;
  DeletePropertyPromotionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
