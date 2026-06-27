import 'package:reservatior/shared/repositories/currency_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetCurrencyByIdUseCase {
  final CurrencyRepository _repository;
  GetCurrencyByIdUseCase(this._repository);
  Future<Currency> execute(String id) => _repository.getById(id);
}

class GetCurrencysUseCase {
  final CurrencyRepository _repository;
  GetCurrencysUseCase(this._repository);
  Future<List<Currency>> execute({
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

class CreateCurrencyUseCase {
  final CurrencyRepository _repository;
  CreateCurrencyUseCase(this._repository);
  Future<Currency> execute(Currency item) => _repository.create(item);
}

class UpdateCurrencyUseCase {
  final CurrencyRepository _repository;
  UpdateCurrencyUseCase(this._repository);
  Future<Currency> execute(String id, Currency item) => _repository.update(id, item);
}

class DeleteCurrencyUseCase {
  final CurrencyRepository _repository;
  DeleteCurrencyUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
