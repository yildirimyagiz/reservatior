import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/gift_card_service.dart';

abstract class GiftCardRepository {
  Future<GiftCard> getById(String id);
  Future<List<GiftCard>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<GiftCard> create(GiftCard item);
  Future<GiftCard> update(String id, GiftCard item);
  Future<void> delete(String id);
}

class GiftCardRepositoryImpl implements GiftCardRepository {
  final GiftCardService _service;
  GiftCardRepositoryImpl(this._service);

  @override
  Future<GiftCard> getById(String id) => _service.getGiftCardById(id);

  @override
  Future<List<GiftCard>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getGiftCards(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<GiftCard> create(GiftCard item) => _service.createGiftCard(item);

  @override
  Future<GiftCard> update(String id, GiftCard item) => _service.updateGiftCard(id, item);

  @override
  Future<void> delete(String id) => _service.deleteGiftCard(id);
}
