import 'package:reservatior/shared/repositories/ai_lead_score_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiLeadScoreByIdUseCase {
  final AiLeadScoreRepository _repository;
  GetAiLeadScoreByIdUseCase(this._repository);
  Future<AiLeadScore> execute(String id) => _repository.getById(id);
}

class GetAiLeadScoresUseCase {
  final AiLeadScoreRepository _repository;
  GetAiLeadScoresUseCase(this._repository);
  Future<List<AiLeadScore>> execute({
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

class CreateAiLeadScoreUseCase {
  final AiLeadScoreRepository _repository;
  CreateAiLeadScoreUseCase(this._repository);
  Future<AiLeadScore> execute(AiLeadScore item) => _repository.create(item);
}

class UpdateAiLeadScoreUseCase {
  final AiLeadScoreRepository _repository;
  UpdateAiLeadScoreUseCase(this._repository);
  Future<AiLeadScore> execute(String id, AiLeadScore item) => _repository.update(id, item);
}

class DeleteAiLeadScoreUseCase {
  final AiLeadScoreRepository _repository;
  DeleteAiLeadScoreUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
