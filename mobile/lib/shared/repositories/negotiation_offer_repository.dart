import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/negotiation_offer_service.dart';

abstract class NegotiationOfferRepository {
  Future<NegotiationOffer> getById(String id);
  Future<List<NegotiationOffer>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<NegotiationOffer> create(NegotiationOffer item);
  Future<NegotiationOffer> update(String id, NegotiationOffer item);
  Future<void> delete(String id);
}

class NegotiationOfferRepositoryImpl implements NegotiationOfferRepository {
  final NegotiationOfferService _service;
  NegotiationOfferRepositoryImpl(this._service);

  @override
  Future<NegotiationOffer> getById(String id) => _service.getNegotiationOfferById(id);

  @override
  Future<List<NegotiationOffer>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getNegotiationOffers(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<NegotiationOffer> create(NegotiationOffer item) => _service.createNegotiationOffer(item);

  @override
  Future<NegotiationOffer> update(String id, NegotiationOffer item) => _service.updateNegotiationOffer(id, item);

  @override
  Future<void> delete(String id) => _service.deleteNegotiationOffer(id);
}
