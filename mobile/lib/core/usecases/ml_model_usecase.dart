import 'package:reservatior/shared/repositories/ml_model_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetMlModelByIdUseCase {
  final MlModelRepository _repository;
  GetMlModelByIdUseCase(this._repository);
  Future<MlModel> execute(String id) => _repository.getById(id);
}

class GetMlModelsUseCase {
  final MlModelRepository _repository;
  GetMlModelsUseCase(this._repository);
  Future<List<MlModel>> execute({
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

class CreateMlModelUseCase {
  final MlModelRepository _repository;
  CreateMlModelUseCase(this._repository);
  Future<MlModel> execute(MlModel item) => _repository.create(item);
}

class UpdateMlModelUseCase {
  final MlModelRepository _repository;
  UpdateMlModelUseCase(this._repository);
  Future<MlModel> execute(String id, MlModel item) => _repository.update(id, item);
}

class DeleteMlModelUseCase {
  final MlModelRepository _repository;
  DeleteMlModelUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
