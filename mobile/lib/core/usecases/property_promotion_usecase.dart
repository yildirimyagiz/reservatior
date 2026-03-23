import '../../features/shared/services/property_promotion_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyPromotion

class GetPropertyPromotionByIdUseCase {
  final PropertyPromotionService _service;
  
  GetPropertyPromotionByIdUseCase(this._service);
  
  Future<PropertyPromotion> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyPromotionsUseCase {
  final PropertyPromotionService _service;
  
  GetPropertyPromotionsUseCase(this._service);
  
  Future<List<PropertyPromotion>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreatePropertyPromotionUseCase {
  final PropertyPromotionService _service;
  
  CreatePropertyPromotionUseCase(this._service);
  
  Future<PropertyPromotion> execute(PropertyPromotion propertyPromotion) async {
    // Add validation logic here
    return await _service.create(propertyPromotion);
  }
}

class UpdatePropertyPromotionUseCase {
  final PropertyPromotionService _service;
  
  UpdatePropertyPromotionUseCase(this._service);
  
  Future<PropertyPromotion> execute(String id, PropertyPromotion propertyPromotion) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyPromotion);
  }
}

class DeletePropertyPromotionUseCase {
  final PropertyPromotionService _service;
  
  DeletePropertyPromotionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyPromotion Use Case Container
class PropertyPromotionUseCases {
  final GetPropertyPromotionByIdUseCase getById;
  final GetPropertyPromotionsUseCase getAll;
  final CreatePropertyPromotionUseCase create;
  final UpdatePropertyPromotionUseCase update;
  final DeletePropertyPromotionUseCase delete;
  
  PropertyPromotionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyPromotionUseCases.create(PropertyPromotionService service) {
    return PropertyPromotionUseCases(
      getById: GetPropertyPromotionByIdUseCase(service),
      getAll: GetPropertyPromotionsUseCase(service),
      create: CreatePropertyPromotionUseCase(service),
      update: UpdatePropertyPromotionUseCase(service),
      delete: DeletePropertyPromotionUseCase(service),
    );
  }
}
