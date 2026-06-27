import 'package:reservatior/shared/repositories/ai_lead_scoring_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiLeadScoringByIdUseCase {
  final AiLeadScoringRepository _repository;
  GetAiLeadScoringByIdUseCase(this._repository);
  Future<AiLeadScoring> execute(String id) => _repository.getById(id);
}

class GetAiLeadScoringsUseCase {
  final AiLeadScoringRepository _repository;
  GetAiLeadScoringsUseCase(this._repository);
  Future<List<AiLeadScoring>> execute({
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

class CreateAiLeadScoringUseCase {
  final AiLeadScoringRepository _repository;
  CreateAiLeadScoringUseCase(this._repository);
  Future<AiLeadScoring> execute(AiLeadScoring item) => _repository.create(item);
}

class UpdateAiLeadScoringUseCase {
  final AiLeadScoringRepository _repository;
  UpdateAiLeadScoringUseCase(this._repository);
  Future<AiLeadScoring> execute(String id, AiLeadScoring item) => _repository.update(id, item);
}

class DeleteAiLeadScoringUseCase {
  final AiLeadScoringRepository _repository;
  DeleteAiLeadScoringUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
