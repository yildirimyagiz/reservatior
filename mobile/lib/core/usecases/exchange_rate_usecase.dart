import '../../features/shared/services/exchange_rate_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ExchangeRate

class GetExchangeRateByIdUseCase {
  final ExchangeRateService _service;
  
  GetExchangeRateByIdUseCase(this._service);
  
  Future<ExchangeRate> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetExchangeRatesUseCase {
  final ExchangeRateService _service;
  
  GetExchangeRatesUseCase(this._service);
  
  Future<List<ExchangeRate>> execute({
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

class CreateExchangeRateUseCase {
  final ExchangeRateService _service;
  
  CreateExchangeRateUseCase(this._service);
  
  Future<ExchangeRate> execute(ExchangeRate exchangeRate) async {
    // Add validation logic here
    return await _service.create(exchangeRate);
  }
}

class UpdateExchangeRateUseCase {
  final ExchangeRateService _service;
  
  UpdateExchangeRateUseCase(this._service);
  
  Future<ExchangeRate> execute(String id, ExchangeRate exchangeRate) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, exchangeRate);
  }
}

class DeleteExchangeRateUseCase {
  final ExchangeRateService _service;
  
  DeleteExchangeRateUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ExchangeRate Use Case Container
class ExchangeRateUseCases {
  final GetExchangeRateByIdUseCase getById;
  final GetExchangeRatesUseCase getAll;
  final CreateExchangeRateUseCase create;
  final UpdateExchangeRateUseCase update;
  final DeleteExchangeRateUseCase delete;
  
  ExchangeRateUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ExchangeRateUseCases.create(ExchangeRateService service) {
    return ExchangeRateUseCases(
      getById: GetExchangeRateByIdUseCase(service),
      getAll: GetExchangeRatesUseCase(service),
      create: CreateExchangeRateUseCase(service),
      update: UpdateExchangeRateUseCase(service),
      delete: DeleteExchangeRateUseCase(service),
    );
  }
}
