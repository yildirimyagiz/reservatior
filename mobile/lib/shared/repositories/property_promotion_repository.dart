import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_promotion_service.dart';

abstract class PropertyPromotionRepository {
  Future<PropertyPromotion> getById(String id);
  Future<List<PropertyPromotion>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PropertyPromotion> create(PropertyPromotion item);
  Future<PropertyPromotion> update(String id, PropertyPromotion item);
  Future<void> delete(String id);
}

class PropertyPromotionRepositoryImpl implements PropertyPromotionRepository {
  final PropertyPromotionService _service;
  PropertyPromotionRepositoryImpl(this._service);

  @override
  Future<PropertyPromotion> getById(String id) => _service.getPropertyPromotionById(id);

  @override
  Future<List<PropertyPromotion>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPropertyPromotions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyPromotion> create(PropertyPromotion item) => _service.createPropertyPromotion(item);

  @override
  Future<PropertyPromotion> update(String id, PropertyPromotion item) => _service.updatePropertyPromotion(id, item);

  @override
  Future<void> delete(String id) => _service.deletePropertyPromotion(id);
}
