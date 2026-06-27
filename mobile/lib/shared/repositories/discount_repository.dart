import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/discount_service.dart';

abstract class DiscountRepository {
  Future<Discount> getById(String id);
  Future<List<Discount>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Discount> create(Discount item);
  Future<Discount> update(String id, Discount item);
  Future<void> delete(String id);
}

class DiscountRepositoryImpl implements DiscountRepository {
  final DiscountService _service;
  DiscountRepositoryImpl(this._service);

  @override
  Future<Discount> getById(String id) => _service.getDiscountById(id);

  @override
  Future<List<Discount>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getDiscounts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Discount> create(Discount item) => _service.createDiscount(item);

  @override
  Future<Discount> update(String id, Discount item) => _service.updateDiscount(id, item);

  @override
  Future<void> delete(String id) => _service.deleteDiscount(id);
}
