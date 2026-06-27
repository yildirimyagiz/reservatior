import 'package:reservatior/shared/repositories/quote_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetQuoteByIdUseCase {
  final QuoteRepository _repository;
  GetQuoteByIdUseCase(this._repository);
  Future<Quote> execute(String id) => _repository.getById(id);
}

class GetQuotesUseCase {
  final QuoteRepository _repository;
  GetQuotesUseCase(this._repository);
  Future<List<Quote>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreateQuoteUseCase {
  final QuoteRepository _repository;
  CreateQuoteUseCase(this._repository);
  Future<Quote> execute(Quote item) => _repository.create(item);
}

class UpdateQuoteUseCase {
  final QuoteRepository _repository;
  UpdateQuoteUseCase(this._repository);
  Future<Quote> execute(String id, Quote item) => _repository.update(id, item);
}

class DeleteQuoteUseCase {
  final QuoteRepository _repository;
  DeleteQuoteUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
