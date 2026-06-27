import 'package:reservatior/shared/repositories/ai_model_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiModelByIdUseCase {
  final AiModelRepository _repository;
  GetAiModelByIdUseCase(this._repository);
  Future<AiModel> execute(String id) => _repository.getById(id);
}

class GetAiModelsUseCase {
  final AiModelRepository _repository;
  GetAiModelsUseCase(this._repository);
  Future<List<AiModel>> execute({
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

class CreateAiModelUseCase {
  final AiModelRepository _repository;
  CreateAiModelUseCase(this._repository);
  Future<AiModel> execute(AiModel item) => _repository.create(item);
}

class UpdateAiModelUseCase {
  final AiModelRepository _repository;
  UpdateAiModelUseCase(this._repository);
  Future<AiModel> execute(String id, AiModel item) => _repository.update(id, item);
}

class DeleteAiModelUseCase {
  final AiModelRepository _repository;
  DeleteAiModelUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
