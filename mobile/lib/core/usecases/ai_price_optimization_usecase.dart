import 'package:reservatior/shared/repositories/ai_price_optimization_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAiPriceOptimizationByIdUseCase {
  final AiPriceOptimizationRepository _repository;
  GetAiPriceOptimizationByIdUseCase(this._repository);
  Future<AiPriceOptimization> execute(String id) => _repository.getById(id);
}

class GetAiPriceOptimizationsUseCase {
  final AiPriceOptimizationRepository _repository;
  GetAiPriceOptimizationsUseCase(this._repository);
  Future<List<AiPriceOptimization>> execute({
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

class CreateAiPriceOptimizationUseCase {
  final AiPriceOptimizationRepository _repository;
  CreateAiPriceOptimizationUseCase(this._repository);
  Future<AiPriceOptimization> execute(AiPriceOptimization item) => _repository.create(item);
}

class UpdateAiPriceOptimizationUseCase {
  final AiPriceOptimizationRepository _repository;
  UpdateAiPriceOptimizationUseCase(this._repository);
  Future<AiPriceOptimization> execute(String id, AiPriceOptimization item) => _repository.update(id, item);
}

class DeleteAiPriceOptimizationUseCase {
  final AiPriceOptimizationRepository _repository;
  DeleteAiPriceOptimizationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
