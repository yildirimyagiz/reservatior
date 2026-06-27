import 'package:reservatior/shared/repositories/predictive_model_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPredictiveModelByIdUseCase {
  final PredictiveModelRepository _repository;
  GetPredictiveModelByIdUseCase(this._repository);
  Future<PredictiveModel> execute(String id) => _repository.getById(id);
}

class GetPredictiveModelsUseCase {
  final PredictiveModelRepository _repository;
  GetPredictiveModelsUseCase(this._repository);
  Future<List<PredictiveModel>> execute({
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

class CreatePredictiveModelUseCase {
  final PredictiveModelRepository _repository;
  CreatePredictiveModelUseCase(this._repository);
  Future<PredictiveModel> execute(PredictiveModel item) => _repository.create(item);
}

class UpdatePredictiveModelUseCase {
  final PredictiveModelRepository _repository;
  UpdatePredictiveModelUseCase(this._repository);
  Future<PredictiveModel> execute(String id, PredictiveModel item) => _repository.update(id, item);
}

class DeletePredictiveModelUseCase {
  final PredictiveModelRepository _repository;
  DeletePredictiveModelUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
