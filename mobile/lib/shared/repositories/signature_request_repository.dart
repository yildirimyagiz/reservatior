import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/signature_request_service.dart';

abstract class SignatureRequestRepository {
  Future<SignatureRequest> getById(String id);
  Future<List<SignatureRequest>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<SignatureRequest> create(SignatureRequest item);
  Future<SignatureRequest> update(String id, SignatureRequest item);
  Future<void> delete(String id);
}

class SignatureRequestRepositoryImpl implements SignatureRequestRepository {
  final SignatureRequestService _service;
  SignatureRequestRepositoryImpl(this._service);

  @override
  Future<SignatureRequest> getById(String id) => _service.getSignatureRequestById(id);

  @override
  Future<List<SignatureRequest>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSignatureRequests(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<SignatureRequest> create(SignatureRequest item) => _service.createSignatureRequest(item);

  @override
  Future<SignatureRequest> update(String id, SignatureRequest item) => _service.updateSignatureRequest(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSignatureRequest(id);
}
