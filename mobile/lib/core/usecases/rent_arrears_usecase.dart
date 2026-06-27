import 'package:reservatior/shared/repositories/rent_arrears_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetRentArrearsByIdUseCase {
  final RentArrearsRepository _repository;
  GetRentArrearsByIdUseCase(this._repository);
  Future<RentArrears> execute(String id) => _repository.getById(id);
}

class GetRentArrearssUseCase {
  final RentArrearsRepository _repository;
  GetRentArrearssUseCase(this._repository);
  Future<List<RentArrears>> execute({
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

class CreateRentArrearsUseCase {
  final RentArrearsRepository _repository;
  CreateRentArrearsUseCase(this._repository);
  Future<RentArrears> execute(RentArrears item) => _repository.create(item);
}

class UpdateRentArrearsUseCase {
  final RentArrearsRepository _repository;
  UpdateRentArrearsUseCase(this._repository);
  Future<RentArrears> execute(String id, RentArrears item) => _repository.update(id, item);
}

class DeleteRentArrearsUseCase {
  final RentArrearsRepository _repository;
  DeleteRentArrearsUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
