import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_offer_service.dart';

abstract class PropertyOfferRepository {
  Future<PropertyOffer> getById(String id);
  Future<List<PropertyOffer>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PropertyOffer> create(PropertyOffer item);
  Future<PropertyOffer> update(String id, PropertyOffer item);
  Future<void> delete(String id);
}

class PropertyOfferRepositoryImpl implements PropertyOfferRepository {
  final PropertyOfferService _service;
  PropertyOfferRepositoryImpl(this._service);

  @override
  Future<PropertyOffer> getById(String id) => _service.getPropertyOfferById(id);

  @override
  Future<List<PropertyOffer>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPropertyOffers(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyOffer> create(PropertyOffer item) => _service.createPropertyOffer(item);

  @override
  Future<PropertyOffer> update(String id, PropertyOffer item) => _service.updatePropertyOffer(id, item);

  @override
  Future<void> delete(String id) => _service.deletePropertyOffer(id);
}
