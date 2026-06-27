import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/signature_signer_service.dart';

abstract class SignatureSignerRepository {
  Future<SignatureSigner> getById(String id);
  Future<List<SignatureSigner>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<SignatureSigner> create(SignatureSigner item);
  Future<SignatureSigner> update(String id, SignatureSigner item);
  Future<void> delete(String id);
}

class SignatureSignerRepositoryImpl implements SignatureSignerRepository {
  final SignatureSignerService _service;
  SignatureSignerRepositoryImpl(this._service);

  @override
  Future<SignatureSigner> getById(String id) => _service.getSignatureSignerById(id);

  @override
  Future<List<SignatureSigner>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getSignatureSigners(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<SignatureSigner> create(SignatureSigner item) => _service.createSignatureSigner(item);

  @override
  Future<SignatureSigner> update(String id, SignatureSigner item) => _service.updateSignatureSigner(id, item);

  @override
  Future<void> delete(String id) => _service.deleteSignatureSigner(id);
}
