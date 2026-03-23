import '../../features/shared/services/recommendation_result_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for RecommendationResult

class GetRecommendationResultByIdUseCase {
  final RecommendationResultService _service;
  
  GetRecommendationResultByIdUseCase(this._service);
  
  Future<RecommendationResult> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetRecommendationResultsUseCase {
  final RecommendationResultService _service;
  
  GetRecommendationResultsUseCase(this._service);
  
  Future<List<RecommendationResult>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateRecommendationResultUseCase {
  final RecommendationResultService _service;
  
  CreateRecommendationResultUseCase(this._service);
  
  Future<RecommendationResult> execute(RecommendationResult recommendationResult) async {
    // Add validation logic here
    return await _service.create(recommendationResult);
  }
}

class UpdateRecommendationResultUseCase {
  final RecommendationResultService _service;
  
  UpdateRecommendationResultUseCase(this._service);
  
  Future<RecommendationResult> execute(String id, RecommendationResult recommendationResult) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, recommendationResult);
  }
}

class DeleteRecommendationResultUseCase {
  final RecommendationResultService _service;
  
  DeleteRecommendationResultUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// RecommendationResult Use Case Container
class RecommendationResultUseCases {
  final GetRecommendationResultByIdUseCase getById;
  final GetRecommendationResultsUseCase getAll;
  final CreateRecommendationResultUseCase create;
  final UpdateRecommendationResultUseCase update;
  final DeleteRecommendationResultUseCase delete;
  
  RecommendationResultUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory RecommendationResultUseCases.create(RecommendationResultService service) {
    return RecommendationResultUseCases(
      getById: GetRecommendationResultByIdUseCase(service),
      getAll: GetRecommendationResultsUseCase(service),
      create: CreateRecommendationResultUseCase(service),
      update: UpdateRecommendationResultUseCase(service),
      delete: DeleteRecommendationResultUseCase(service),
    );
  }
}
