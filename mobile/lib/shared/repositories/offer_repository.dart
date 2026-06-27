import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/offer_service.dart';

abstract class OfferRepository {
  Future<Offer> getById(String id);
  Future<List<Offer>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Offer> create(Offer item);
  Future<Offer> update(String id, Offer item);
  Future<void> delete(String id);
}

class OfferRepositoryImpl implements OfferRepository {
  final OfferService _service;
  OfferRepositoryImpl(this._service);

  @override
  Future<Offer> getById(String id) => _service.getOfferById(id);

  @override
  Future<List<Offer>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getOffers(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Offer> create(Offer item) => _service.createOffer(item);

  @override
  Future<Offer> update(String id, Offer item) => _service.updateOffer(id, item);

  @override
  Future<void> delete(String id) => _service.deleteOffer(id);
}
