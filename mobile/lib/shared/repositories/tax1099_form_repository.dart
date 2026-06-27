import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/tax1099_form_service.dart';

abstract class Tax1099FormRepository {
  Future<Tax1099Form> getById(String id);
  Future<List<Tax1099Form>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Tax1099Form> create(Tax1099Form item);
  Future<Tax1099Form> update(String id, Tax1099Form item);
  Future<void> delete(String id);
}

class Tax1099FormRepositoryImpl implements Tax1099FormRepository {
  final Tax1099FormService _service;
  Tax1099FormRepositoryImpl(this._service);

  @override
  Future<Tax1099Form> getById(String id) => _service.getTax1099FormById(id);

  @override
  Future<List<Tax1099Form>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getTax1099Forms(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Tax1099Form> create(Tax1099Form item) => _service.createTax1099Form(item);

  @override
  Future<Tax1099Form> update(String id, Tax1099Form item) => _service.updateTax1099Form(id, item);

  @override
  Future<void> delete(String id) => _service.deleteTax1099Form(id);
}
