import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/mortgage_offer_service.dart';

abstract class MortgageOfferRepository {
  Future<MortgageOffer> getById(String id);
  Future<List<MortgageOffer>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<MortgageOffer> create(MortgageOffer item);
  Future<MortgageOffer> update(String id, MortgageOffer item);
  Future<void> delete(String id);
}

class MortgageOfferRepositoryImpl implements MortgageOfferRepository {
  final MortgageOfferService _service;
  MortgageOfferRepositoryImpl(this._service);

  @override
  Future<MortgageOffer> getById(String id) => _service.getMortgageOfferById(id);

  @override
  Future<List<MortgageOffer>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getMortgageOffers(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<MortgageOffer> create(MortgageOffer item) => _service.createMortgageOffer(item);

  @override
  Future<MortgageOffer> update(String id, MortgageOffer item) => _service.updateMortgageOffer(id, item);

  @override
  Future<void> delete(String id) => _service.deleteMortgageOffer(id);
}
