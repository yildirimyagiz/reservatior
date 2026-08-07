import 'package:reservatior/shared/models/solicitor_management.dart';

abstract class AbstractSolicitorRepository {
  Future<List<SolicitorManagement>> getSolicitorManagements({
    int page,
    int limit,
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  });

  Future<SolicitorManagement> getSolicitorManagementById(String id);

  Future<SolicitorManagement> createSolicitorManagement(
      SolicitorManagement solicitor);

  Future<SolicitorManagement> updateSolicitorManagement(
      String id, SolicitorManagement solicitor);

  Future<void> deleteSolicitorManagement(String id);
}
