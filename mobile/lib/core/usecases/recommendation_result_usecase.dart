import 'package:reservatior/shared/repositories/recommendation_result_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetRecommendationResultByIdUseCase {
  final RecommendationResultRepository _repository;
  GetRecommendationResultByIdUseCase(this._repository);
  Future<RecommendationResult> execute(String id) => _repository.getById(id);
}

class GetRecommendationResultsUseCase {
  final RecommendationResultRepository _repository;
  GetRecommendationResultsUseCase(this._repository);
  Future<List<RecommendationResult>> execute({
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

class CreateRecommendationResultUseCase {
  final RecommendationResultRepository _repository;
  CreateRecommendationResultUseCase(this._repository);
  Future<RecommendationResult> execute(RecommendationResult item) => _repository.create(item);
}

class UpdateRecommendationResultUseCase {
  final RecommendationResultRepository _repository;
  UpdateRecommendationResultUseCase(this._repository);
  Future<RecommendationResult> execute(String id, RecommendationResult item) => _repository.update(id, item);
}

class DeleteRecommendationResultUseCase {
  final RecommendationResultRepository _repository;
  DeleteRecommendationResultUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
