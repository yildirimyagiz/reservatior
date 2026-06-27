import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/ai_fraud_detection_service.dart';

abstract class AiFraudDetectionRepository {
  Future<AiFraudDetection> getById(String id);
  Future<List<AiFraudDetection>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<AiFraudDetection> create(AiFraudDetection item);
  Future<AiFraudDetection> update(String id, AiFraudDetection item);
  Future<void> delete(String id);
}

class AiFraudDetectionRepositoryImpl implements AiFraudDetectionRepository {
  final AiFraudDetectionService _service;
  AiFraudDetectionRepositoryImpl(this._service);

  @override
  Future<AiFraudDetection> getById(String id) => _service.getAiFraudDetectionById(id);

  @override
  Future<List<AiFraudDetection>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getAiFraudDetections(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<AiFraudDetection> create(AiFraudDetection item) => _service.createAiFraudDetection(item);

  @override
  Future<AiFraudDetection> update(String id, AiFraudDetection item) => _service.updateAiFraudDetection(id, item);

  @override
  Future<void> delete(String id) => _service.deleteAiFraudDetection(id);
}
