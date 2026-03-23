import '../../features/shared/services/quote_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Quote

class GetQuoteByIdUseCase {
  final QuoteService _service;
  
  GetQuoteByIdUseCase(this._service);
  
  Future<Quote> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetQuotesUseCase {
  final QuoteService _service;
  
  GetQuotesUseCase(this._service);
  
  Future<List<Quote>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateQuoteUseCase {
  final QuoteService _service;
  
  CreateQuoteUseCase(this._service);
  
  Future<Quote> execute(Quote quote) async {
    // Add validation logic here
    return await _service.create(quote);
  }
}

class UpdateQuoteUseCase {
  final QuoteService _service;
  
  UpdateQuoteUseCase(this._service);
  
  Future<Quote> execute(String id, Quote quote) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, quote);
  }
}

class DeleteQuoteUseCase {
  final QuoteService _service;
  
  DeleteQuoteUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Quote Use Case Container
class QuoteUseCases {
  final GetQuoteByIdUseCase getById;
  final GetQuotesUseCase getAll;
  final CreateQuoteUseCase create;
  final UpdateQuoteUseCase update;
  final DeleteQuoteUseCase delete;
  
  QuoteUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory QuoteUseCases.create(QuoteService service) {
    return QuoteUseCases(
      getById: GetQuoteByIdUseCase(service),
      getAll: GetQuotesUseCase(service),
      create: CreateQuoteUseCase(service),
      update: UpdateQuoteUseCase(service),
      delete: DeleteQuoteUseCase(service),
    );
  }
}
