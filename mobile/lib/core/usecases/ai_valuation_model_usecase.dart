import 'package:reservatior/shared/repositories/ai_valuation_model_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiValuationModelByIdUseCase {
  final AiValuationModelRepository _repository;
  GetAiValuationModelByIdUseCase(this._repository);
  Future<AiValuationModel> execute(String id) => _repository.getById(id);
}

class GetAiValuationModelsUseCase {
  final AiValuationModelRepository _repository;
  GetAiValuationModelsUseCase(this._repository);
  Future<List<AiValuationModel>> execute({
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

class CreateAiValuationModelUseCase {
  final AiValuationModelRepository _repository;
  CreateAiValuationModelUseCase(this._repository);
  Future<AiValuationModel> execute(AiValuationModel item) => _repository.create(item);
}

class UpdateAiValuationModelUseCase {
  final AiValuationModelRepository _repository;
  UpdateAiValuationModelUseCase(this._repository);
  Future<AiValuationModel> execute(String id, AiValuationModel item) => _repository.update(id, item);
}

class DeleteAiValuationModelUseCase {
  final AiValuationModelRepository _repository;
  DeleteAiValuationModelUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
