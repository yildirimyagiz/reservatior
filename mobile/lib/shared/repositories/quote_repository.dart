import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/quote_service.dart';

abstract class QuoteRepository {
  Future<Quote> getById(String id);
  Future<List<Quote>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Quote> create(Quote item);
  Future<Quote> update(String id, Quote item);
  Future<void> delete(String id);
}

class QuoteRepositoryImpl implements QuoteRepository {
  final QuoteService _service;
  QuoteRepositoryImpl(this._service);

  @override
  Future<Quote> getById(String id) => _service.getQuoteById(id);

  @override
  Future<List<Quote>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getQuotes(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Quote> create(Quote item) => _service.createQuote(item);

  @override
  Future<Quote> update(String id, Quote item) => _service.updateQuote(id, item);

  @override
  Future<void> delete(String id) => _service.deleteQuote(id);
}
