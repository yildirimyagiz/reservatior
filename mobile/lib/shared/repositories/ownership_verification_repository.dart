import 'package:reservatior/shared/models/ownership_verification.dart';
import 'package:reservatior/shared/services/ownership_verification_service.dart';

abstract class OwnershipVerificationRepository {
  Future<PropertyOwnershipVerification> getById(String id);
  Future<List<PropertyOwnershipVerification>> getAll({Map<String, dynamic>? params});
  Future<PropertyOwnershipVerification> create(Map<String, dynamic> data);
  Future<PropertyOwnershipVerification> update(String id, Map<String, dynamic> data);
  Future<void> delete(String id);
  Future<PropertyOwnershipVerification> verify(String id, Map<String, dynamic> data);
  Future<PropertyOwnershipVerification> reject(String id, Map<String, dynamic> data);
}

class OwnershipVerificationRepositoryImpl implements OwnershipVerificationRepository {
  final OwnershipVerificationService _service;
  OwnershipVerificationRepositoryImpl(this._service);

  @override
  Future<PropertyOwnershipVerification> getById(String id) => _service.getOwnershipVerificationById(id);

  @override
  Future<List<PropertyOwnershipVerification>> getAll({Map<String, dynamic>? params}) => _service.getOwnershipVerifications();

  @override
  Future<PropertyOwnershipVerification> create(Map<String, dynamic> data) => _service.createOwnershipVerification(
    propertyId: data['propertyId'],
    orgId: data['orgId'],
    currentOwnerId: data['currentOwnerId'],
    verificationMethod: data['verificationMethod'],
    priorityVerification: data['priorityVerification'],
  );

  @override
  Future<PropertyOwnershipVerification> update(String id, Map<String, dynamic> data) => _service.updateOwnershipVerification(id);

  @override
  Future<void> delete(String id) => _service.deleteOwnershipVerification(id);

  @override
  Future<PropertyOwnershipVerification> verify(String id, Map<String, dynamic> data) => _service.verifyOwnership(id);

  @override
  Future<PropertyOwnershipVerification> reject(String id, Map<String, dynamic> data) => _service.rejectOwnership(id, rejectionReason: data['rejectionReason']);
}
