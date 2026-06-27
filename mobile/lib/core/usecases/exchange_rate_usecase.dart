import 'package:reservatior/shared/repositories/exchange_rate_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetExchangeRateByIdUseCase {
  final ExchangeRateRepository _repository;
  GetExchangeRateByIdUseCase(this._repository);
  Future<ExchangeRate> execute(String id) => _repository.getById(id);
}

class GetExchangeRatesUseCase {
  final ExchangeRateRepository _repository;
  GetExchangeRatesUseCase(this._repository);
  Future<List<ExchangeRate>> execute({
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

class CreateExchangeRateUseCase {
  final ExchangeRateRepository _repository;
  CreateExchangeRateUseCase(this._repository);
  Future<ExchangeRate> execute(ExchangeRate item) => _repository.create(item);
}

class UpdateExchangeRateUseCase {
  final ExchangeRateRepository _repository;
  UpdateExchangeRateUseCase(this._repository);
  Future<ExchangeRate> execute(String id, ExchangeRate item) => _repository.update(id, item);
}

class DeleteExchangeRateUseCase {
  final ExchangeRateRepository _repository;
  DeleteExchangeRateUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
