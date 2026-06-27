import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_property_description_service.dart';

abstract class AiPropertyDescriptionRepository {
  Future<AiPropertyDescription> getById(String id);
  Future<List<AiPropertyDescription>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiPropertyDescription> create(AiPropertyDescription item);
  Future<AiPropertyDescription> update(String id, AiPropertyDescription item);
  Future<void> delete(String id);
}

class AiPropertyDescriptionRepositoryImpl implements AiPropertyDescriptionRepository {
  final AiPropertyDescriptionService _service;
  AiPropertyDescriptionRepositoryImpl(this._service);

  @override
  Future<AiPropertyDescription> getById(String id) => _service.getAiPropertyDescriptionById(id);

  @override
  Future<List<AiPropertyDescription>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiPropertyDescriptions(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiPropertyDescription> create(AiPropertyDescription item) => _service.createAiPropertyDescription(item);

  @override
  Future<AiPropertyDescription> update(String id, AiPropertyDescription item) => _service.updateAiPropertyDescription(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiPropertyDescription(id);
}
