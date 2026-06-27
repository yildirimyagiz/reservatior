import 'package:reservatior/shared/repositories/ai_property_valuation_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiPropertyValuationByIdUseCase {
  final AiPropertyValuationRepository _repository;
  GetAiPropertyValuationByIdUseCase(this._repository);
  Future<AiPropertyValuation> execute(String id) => _repository.getById(id);
}

class GetAiPropertyValuationsUseCase {
  final AiPropertyValuationRepository _repository;
  GetAiPropertyValuationsUseCase(this._repository);
  Future<List<AiPropertyValuation>> execute({
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

class CreateAiPropertyValuationUseCase {
  final AiPropertyValuationRepository _repository;
  CreateAiPropertyValuationUseCase(this._repository);
  Future<AiPropertyValuation> execute(AiPropertyValuation item) => _repository.create(item);
}

class UpdateAiPropertyValuationUseCase {
  final AiPropertyValuationRepository _repository;
  UpdateAiPropertyValuationUseCase(this._repository);
  Future<AiPropertyValuation> execute(String id, AiPropertyValuation item) => _repository.update(id, item);
}

class DeleteAiPropertyValuationUseCase {
  final AiPropertyValuationRepository _repository;
  DeleteAiPropertyValuationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
