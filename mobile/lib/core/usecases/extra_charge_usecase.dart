import 'package:reservatior/shared/repositories/extra_charge_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetExtraChargeByIdUseCase {
  final ExtraChargeRepository _repository;
  GetExtraChargeByIdUseCase(this._repository);
  Future<ExtraCharge> execute(String id) => _repository.getById(id);
}

class GetExtraChargesUseCase {
  final ExtraChargeRepository _repository;
  GetExtraChargesUseCase(this._repository);
  Future<List<ExtraCharge>> execute({
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

class CreateExtraChargeUseCase {
  final ExtraChargeRepository _repository;
  CreateExtraChargeUseCase(this._repository);
  Future<ExtraCharge> execute(ExtraCharge item) => _repository.create(item);
}

class UpdateExtraChargeUseCase {
  final ExtraChargeRepository _repository;
  UpdateExtraChargeUseCase(this._repository);
  Future<ExtraCharge> execute(String id, ExtraCharge item) => _repository.update(id, item);
}

class DeleteExtraChargeUseCase {
  final ExtraChargeRepository _repository;
  DeleteExtraChargeUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
