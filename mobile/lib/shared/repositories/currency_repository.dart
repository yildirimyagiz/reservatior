import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/currency_service.dart';

abstract class CurrencyRepository {
  Future<Currency> getById(String id);
  Future<List<Currency>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Currency> create(Currency item);
  Future<Currency> update(String id, Currency item);
  Future<void> delete(String id);
}

class CurrencyRepositoryImpl implements CurrencyRepository {
  final CurrencyService _service;
  CurrencyRepositoryImpl(this._service);

  @override
  Future<Currency> getById(String id) => _service.getCurrencyById(id);

  @override
  Future<List<Currency>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getCurrencies(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Currency> create(Currency item) => _service.createCurrency(item);

  @override
  Future<Currency> update(String id, Currency item) => _service.updateCurrency(id, item);

  @override
  Future<void> delete(String id) => _service.deleteCurrency(id);
}
