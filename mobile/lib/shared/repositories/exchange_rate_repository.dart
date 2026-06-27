import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/exchange_rate_service.dart';

abstract class ExchangeRateRepository {
  Future<ExchangeRate> getById(String id);
  Future<List<ExchangeRate>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ExchangeRate> create(ExchangeRate item);
  Future<ExchangeRate> update(String id, ExchangeRate item);
  Future<void> delete(String id);
  Future<ExchangeRate> getLatest(String base, String target);
  Future<Map<String, dynamic>> convert(String from, String to, double amount, {String? date});
}

class ExchangeRateRepositoryImpl implements ExchangeRateRepository {
  final ExchangeRateService _service;
  ExchangeRateRepositoryImpl(this._service);

  @override
  Future<ExchangeRate> getById(String id) => _service.getExchangeRateById(id);

  @override
  Future<List<ExchangeRate>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getExchangeRates(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ExchangeRate> create(ExchangeRate item) => _service.createExchangeRate(item);

  @override
  Future<ExchangeRate> update(String id, ExchangeRate item) => _service.updateExchangeRate(id, item);

  @override
  Future<void> delete(String id) => _service.deleteExchangeRate(id);

  @override
  Future<ExchangeRate> getLatest(String base, String target) => _service.getLatest(base, target);

  @override
  Future<Map<String, dynamic>> convert(String from, String to, double amount, {String? date}) => 
    _service.convert(from, to, amount, date: date);
}
