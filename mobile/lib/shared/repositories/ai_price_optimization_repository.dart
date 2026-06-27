import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_price_optimization_service.dart';

abstract class AiPriceOptimizationRepository {
  Future<AiPriceOptimization> getById(String id);
  Future<List<AiPriceOptimization>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiPriceOptimization> create(AiPriceOptimization item);
  Future<AiPriceOptimization> update(String id, AiPriceOptimization item);
  Future<void> delete(String id);
}

class AiPriceOptimizationRepositoryImpl implements AiPriceOptimizationRepository {
  final AiPriceOptimizationService _service;
  AiPriceOptimizationRepositoryImpl(this._service);

  @override
  Future<AiPriceOptimization> getById(String id) => _service.getAiPriceOptimizationById(id);

  @override
  Future<List<AiPriceOptimization>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiPriceOptimizations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiPriceOptimization> create(AiPriceOptimization item) => _service.createAiPriceOptimization(item);

  @override
  Future<AiPriceOptimization> update(String id, AiPriceOptimization item) => _service.updateAiPriceOptimization(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiPriceOptimization(id);
}
