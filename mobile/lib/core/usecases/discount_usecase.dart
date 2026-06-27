import 'package:reservatior/shared/repositories/discount_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetDiscountByIdUseCase {
  final DiscountRepository _repository;
  GetDiscountByIdUseCase(this._repository);
  Future<Discount> execute(String id) => _repository.getById(id);
}

class GetDiscountsUseCase {
  final DiscountRepository _repository;
  GetDiscountsUseCase(this._repository);
  Future<List<Discount>> execute({
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

class CreateDiscountUseCase {
  final DiscountRepository _repository;
  CreateDiscountUseCase(this._repository);
  Future<Discount> execute(Discount item) => _repository.create(item);
}

class UpdateDiscountUseCase {
  final DiscountRepository _repository;
  UpdateDiscountUseCase(this._repository);
  Future<Discount> execute(String id, Discount item) => _repository.update(id, item);
}

class DeleteDiscountUseCase {
  final DiscountRepository _repository;
  DeleteDiscountUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
