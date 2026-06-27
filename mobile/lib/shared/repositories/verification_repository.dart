import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/verification_service.dart';

abstract class VerificationRepository {
  Future<Verification> getById(String id);
  Future<List<Verification>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Verification> create(Verification item);
  Future<Verification> update(String id, Verification item);
  Future<void> delete(String id);
}

class VerificationRepositoryImpl implements VerificationRepository {
  final VerificationService _service;
  VerificationRepositoryImpl(this._service);

  @override
  Future<Verification> getById(String id) => _service.getVerificationById(id);

  @override
  Future<List<Verification>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getVerifications(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Verification> create(Verification item) => _service.createVerification(item);

  @override
  Future<Verification> update(String id, Verification item) => _service.updateVerification(id, item);

  @override
  Future<void> delete(String id) => _service.deleteVerification(id);
}
