import 'package:reservatior/shared/repositories/ai_prediction_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiPredictionByIdUseCase {
  final AiPredictionRepository _repository;
  GetAiPredictionByIdUseCase(this._repository);
  Future<AiPrediction> execute(String id) => _repository.getById(id);
}

class GetAiPredictionsUseCase {
  final AiPredictionRepository _repository;
  GetAiPredictionsUseCase(this._repository);
  Future<List<AiPrediction>> execute({
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

class CreateAiPredictionUseCase {
  final AiPredictionRepository _repository;
  CreateAiPredictionUseCase(this._repository);
  Future<AiPrediction> execute(AiPrediction item) => _repository.create(item);
}

class UpdateAiPredictionUseCase {
  final AiPredictionRepository _repository;
  UpdateAiPredictionUseCase(this._repository);
  Future<AiPrediction> execute(String id, AiPrediction item) => _repository.update(id, item);
}

class DeleteAiPredictionUseCase {
  final AiPredictionRepository _repository;
  DeleteAiPredictionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
