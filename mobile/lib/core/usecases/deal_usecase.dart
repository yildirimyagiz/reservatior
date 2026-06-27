import 'package:reservatior/shared/repositories/deal_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetDealByIdUseCase {
  final DealRepository _repository;
  GetDealByIdUseCase(this._repository);
  Future<Deal> execute(String id) => _repository.getById(id);
}

class GetDealsUseCase {
  final DealRepository _repository;
  GetDealsUseCase(this._repository);
  Future<List<Deal>> execute({
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

class CreateDealUseCase {
  final DealRepository _repository;
  CreateDealUseCase(this._repository);
  Future<Deal> execute(Deal item) => _repository.create(item);
}

class UpdateDealUseCase {
  final DealRepository _repository;
  UpdateDealUseCase(this._repository);
  Future<Deal> execute(String id, Deal item) => _repository.update(id, item);
}

class DeleteDealUseCase {
  final DealRepository _repository;
  DeleteDealUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
