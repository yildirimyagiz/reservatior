import '../../features/shared/services/currency_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Currency

class GetCurrencyByIdUseCase {
  final CurrencyService _service;
  
  GetCurrencyByIdUseCase(this._service);
  
  Future<Currency> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetCurrencysUseCase {
  final CurrencyService _service;
  
  GetCurrencysUseCase(this._service);
  
  Future<List<Currency>> execute({
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

class CreateCurrencyUseCase {
  final CurrencyService _service;
  
  CreateCurrencyUseCase(this._service);
  
  Future<Currency> execute(Currency currency) async {
    // Add validation logic here
    return await _service.create(currency);
  }
}

class UpdateCurrencyUseCase {
  final CurrencyService _service;
  
  UpdateCurrencyUseCase(this._service);
  
  Future<Currency> execute(String id, Currency currency) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, currency);
  }
}

class DeleteCurrencyUseCase {
  final CurrencyService _service;
  
  DeleteCurrencyUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Currency Use Case Container
class CurrencyUseCases {
  final GetCurrencyByIdUseCase getById;
  final GetCurrencysUseCase getAll;
  final CreateCurrencyUseCase create;
  final UpdateCurrencyUseCase update;
  final DeleteCurrencyUseCase delete;
  
  CurrencyUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory CurrencyUseCases.create(CurrencyService service) {
    return CurrencyUseCases(
      getById: GetCurrencyByIdUseCase(service),
      getAll: GetCurrencysUseCase(service),
      create: CreateCurrencyUseCase(service),
      update: UpdateCurrencyUseCase(service),
      delete: DeleteCurrencyUseCase(service),
    );
  }
}
