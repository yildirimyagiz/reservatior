import 'package:reservatior/shared/repositories/right_to_rent_check_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetRightToRentCheckByIdUseCase {
  final RightToRentCheckRepository _repository;
  GetRightToRentCheckByIdUseCase(this._repository);
  Future<RightToRentCheck> execute(String id) => _repository.getById(id);
}

class GetRightToRentChecksUseCase {
  final RightToRentCheckRepository _repository;
  GetRightToRentChecksUseCase(this._repository);
  Future<List<RightToRentCheck>> execute({
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

class CreateRightToRentCheckUseCase {
  final RightToRentCheckRepository _repository;
  CreateRightToRentCheckUseCase(this._repository);
  Future<RightToRentCheck> execute(RightToRentCheck item) => _repository.create(item);
}

class UpdateRightToRentCheckUseCase {
  final RightToRentCheckRepository _repository;
  UpdateRightToRentCheckUseCase(this._repository);
  Future<RightToRentCheck> execute(String id, RightToRentCheck item) => _repository.update(id, item);
}

class DeleteRightToRentCheckUseCase {
  final RightToRentCheckRepository _repository;
  DeleteRightToRentCheckUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
