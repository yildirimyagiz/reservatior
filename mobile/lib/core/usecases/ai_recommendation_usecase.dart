import 'package:reservatior/shared/repositories/ai_recommendation_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiRecommendationByIdUseCase {
  final AiRecommendationRepository _repository;
  GetAiRecommendationByIdUseCase(this._repository);
  Future<AiRecommendation> execute(String id) => _repository.getById(id);
}

class GetAiRecommendationsUseCase {
  final AiRecommendationRepository _repository;
  GetAiRecommendationsUseCase(this._repository);
  Future<List<AiRecommendation>> execute({
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

class CreateAiRecommendationUseCase {
  final AiRecommendationRepository _repository;
  CreateAiRecommendationUseCase(this._repository);
  Future<AiRecommendation> execute(AiRecommendation item) => _repository.create(item);
}

class UpdateAiRecommendationUseCase {
  final AiRecommendationRepository _repository;
  UpdateAiRecommendationUseCase(this._repository);
  Future<AiRecommendation> execute(String id, AiRecommendation item) => _repository.update(id, item);
}

class DeleteAiRecommendationUseCase {
  final AiRecommendationRepository _repository;
  DeleteAiRecommendationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
