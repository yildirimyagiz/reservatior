import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/contact_service.dart';

abstract class ContactRepository {
  Future<Contact> getById(String id);
  Future<List<Contact>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Contact> create(Contact item);
  Future<Contact> update(String id, Contact item);
  Future<void> delete(String id);
}

class ContactRepositoryImpl implements ContactRepository {
  final ContactService _service;
  ContactRepositoryImpl(this._service);

  @override
  Future<Contact> getById(String id) => _service.getContactById(id);

  @override
  Future<List<Contact>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getContacts(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Contact> create(Contact item) => _service.createContact(item);

  @override
  Future<Contact> update(String id, Contact item) => _service.updateContact(id, item);

  @override
  Future<void> delete(String id) => _service.deleteContact(id);
}
