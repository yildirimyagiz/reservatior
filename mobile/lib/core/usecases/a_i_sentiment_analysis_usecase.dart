import '../../features/shared/services/ai_sentiment_analysis_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for AISentimentAnalysis

class GetAISentimentAnalysisByIdUseCase {
  final AISentimentAnalysisService _service;
  
  GetAISentimentAnalysisByIdUseCase(this._service);
  
  Future<AISentimentAnalysis> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetAISentimentAnalysissUseCase {
  final AISentimentAnalysisService _service;
  
  GetAISentimentAnalysissUseCase(this._service);
  
  Future<List<AISentimentAnalysis>> execute({
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

class CreateAISentimentAnalysisUseCase {
  final AISentimentAnalysisService _service;
  
  CreateAISentimentAnalysisUseCase(this._service);
  
  Future<AISentimentAnalysis> execute(AISentimentAnalysis aISentimentAnalysis) async {
    // Add validation logic here
    return await _service.create(aISentimentAnalysis);
  }
}

class UpdateAISentimentAnalysisUseCase {
  final AISentimentAnalysisService _service;
  
  UpdateAISentimentAnalysisUseCase(this._service);
  
  Future<AISentimentAnalysis> execute(String id, AISentimentAnalysis aISentimentAnalysis) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, aISentimentAnalysis);
  }
}

class DeleteAISentimentAnalysisUseCase {
  final AISentimentAnalysisService _service;
  
  DeleteAISentimentAnalysisUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// AISentimentAnalysis Use Case Container
class AISentimentAnalysisUseCases {
  final GetAISentimentAnalysisByIdUseCase getById;
  final GetAISentimentAnalysissUseCase getAll;
  final CreateAISentimentAnalysisUseCase create;
  final UpdateAISentimentAnalysisUseCase update;
  final DeleteAISentimentAnalysisUseCase delete;
  
  AISentimentAnalysisUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory AISentimentAnalysisUseCases.create(AISentimentAnalysisService service) {
    return AISentimentAnalysisUseCases(
      getById: GetAISentimentAnalysisByIdUseCase(service),
      getAll: GetAISentimentAnalysissUseCase(service),
      create: CreateAISentimentAnalysisUseCase(service),
      update: UpdateAISentimentAnalysisUseCase(service),
      delete: DeleteAISentimentAnalysisUseCase(service),
    );
  }
}
