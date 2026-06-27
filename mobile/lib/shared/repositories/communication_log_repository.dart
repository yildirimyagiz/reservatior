import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/communication_log_service.dart';

abstract class CommunicationLogRepository {
  Future<CommunicationLog> getById(String id);
  Future<List<CommunicationLog>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<CommunicationLog> create(CommunicationLog item);
  Future<CommunicationLog> update(String id, CommunicationLog item);
  Future<void> delete(String id);
}

class CommunicationLogRepositoryImpl implements CommunicationLogRepository {
  final CommunicationLogService _service;
  CommunicationLogRepositoryImpl(this._service);

  @override
  Future<CommunicationLog> getById(String id) => _service.getCommunicationLogById(id);

  @override
  Future<List<CommunicationLog>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getCommunicationLogs(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<CommunicationLog> create(CommunicationLog item) => _service.createCommunicationLog(item);

  @override
  Future<CommunicationLog> update(String id, CommunicationLog item) => _service.updateCommunicationLog(id, item);

  @override
  Future<void> delete(String id) => _service.deleteCommunicationLog(id);
}
