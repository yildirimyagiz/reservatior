import 'package:reservatior/shared/repositories/payout_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPayoutByIdUseCase {
  final PayoutRepository _repository;
  GetPayoutByIdUseCase(this._repository);
  Future<Payout> execute(String id) => _repository.getById(id);
}

class GetPayoutsUseCase {
  final PayoutRepository _repository;
  GetPayoutsUseCase(this._repository);
  Future<List<Payout>> execute({
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

class CreatePayoutUseCase {
  final PayoutRepository _repository;
  CreatePayoutUseCase(this._repository);
  Future<Payout> execute(Payout item) => _repository.create(item);
}

class UpdatePayoutUseCase {
  final PayoutRepository _repository;
  UpdatePayoutUseCase(this._repository);
  Future<Payout> execute(String id, Payout item) => _repository.update(id, item);
}

class DeletePayoutUseCase {
  final PayoutRepository _repository;
  DeletePayoutUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
