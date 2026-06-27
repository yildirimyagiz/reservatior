import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_compliance_service.dart';

abstract class PropertyComplianceRepository {
  Future<PropertyCompliance> getById(String id);
  Future<List<PropertyCompliance>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<PropertyCompliance> create(PropertyCompliance item);
  Future<PropertyCompliance> update(String id, PropertyCompliance item);
  Future<void> delete(String id);
}

class PropertyComplianceRepositoryImpl implements PropertyComplianceRepository {
  final PropertyComplianceService _service;
  PropertyComplianceRepositoryImpl(this._service);

  @override
  Future<PropertyCompliance> getById(String id) => _service.getPropertyComplianceById(id);

  @override
  Future<List<PropertyCompliance>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getPropertyCompliances(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyCompliance> create(PropertyCompliance item) => _service.createPropertyCompliance(item);

  @override
  Future<PropertyCompliance> update(String id, PropertyCompliance item) => _service.updatePropertyCompliance(id, item);

  @override
  Future<void> delete(String id) => _service.deletePropertyCompliance(id);
}
