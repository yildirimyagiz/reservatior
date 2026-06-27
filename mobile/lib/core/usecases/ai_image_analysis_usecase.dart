import 'package:reservatior/shared/repositories/ai_image_analysis_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiImageAnalysisByIdUseCase {
  final AiImageAnalysisRepository _repository;
  GetAiImageAnalysisByIdUseCase(this._repository);
  Future<AiImageAnalysis> execute(String id) => _repository.getById(id);
}

class GetAiImageAnalysissUseCase {
  final AiImageAnalysisRepository _repository;
  GetAiImageAnalysissUseCase(this._repository);
  Future<List<AiImageAnalysis>> execute({
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

class CreateAiImageAnalysisUseCase {
  final AiImageAnalysisRepository _repository;
  CreateAiImageAnalysisUseCase(this._repository);
  Future<AiImageAnalysis> execute(AiImageAnalysis item) => _repository.create(item);
}

class UpdateAiImageAnalysisUseCase {
  final AiImageAnalysisRepository _repository;
  UpdateAiImageAnalysisUseCase(this._repository);
  Future<AiImageAnalysis> execute(String id, AiImageAnalysis item) => _repository.update(id, item);
}

class DeleteAiImageAnalysisUseCase {
  final AiImageAnalysisRepository _repository;
  DeleteAiImageAnalysisUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
