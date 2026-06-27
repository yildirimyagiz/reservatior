import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_property_valuation_service.dart';

abstract class AiPropertyValuationRepository {
  Future<AiPropertyValuation> getById(String id);
  Future<List<AiPropertyValuation>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiPropertyValuation> create(AiPropertyValuation item);
  Future<AiPropertyValuation> update(String id, AiPropertyValuation item);
  Future<void> delete(String id);
}

class AiPropertyValuationRepositoryImpl implements AiPropertyValuationRepository {
  final AiPropertyValuationService _service;
  AiPropertyValuationRepositoryImpl(this._service);

  @override
  Future<AiPropertyValuation> getById(String id) => _service.getAiPropertyValuationById(id);

  @override
  Future<List<AiPropertyValuation>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiPropertyValuations(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiPropertyValuation> create(AiPropertyValuation item) => _service.createAiPropertyValuation(item);

  @override
  Future<AiPropertyValuation> update(String id, AiPropertyValuation item) => _service.updateAiPropertyValuation(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiPropertyValuation(id);
}
