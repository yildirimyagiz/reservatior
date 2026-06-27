import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_model_deployment_service.dart';

abstract class AiModelDeploymentRepository {
  Future<AiModelDeployment> getById(String id);
  Future<List<AiModelDeployment>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiModelDeployment> create(AiModelDeployment item);
  Future<AiModelDeployment> update(String id, AiModelDeployment item);
  Future<void> delete(String id);
}

class AiModelDeploymentRepositoryImpl implements AiModelDeploymentRepository {
  final AiModelDeploymentService _service;
  AiModelDeploymentRepositoryImpl(this._service);

  @override
  Future<AiModelDeployment> getById(String id) => _service.getAiModelDeploymentById(id);

  @override
  Future<List<AiModelDeployment>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiModelDeployments(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiModelDeployment> create(AiModelDeployment item) => _service.createAiModelDeployment(item);

  @override
  Future<AiModelDeployment> update(String id, AiModelDeployment item) => _service.updateAiModelDeployment(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiModelDeployment(id);
}
