import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ContactService {
  final DioClient _dioClient;
  ContactService(this._dioClient);

  Future<Contact> getContactById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.contacts}/$id');
    return Contact.fromJson(response.data['data']);
  }

  Future<List<Contact>> getContacts({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.contacts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Contact.fromJson(json)).toList();
  }

  Future<Contact> createContact(Contact item) async {
    final response = await _dioClient.post(ApiEndpoints.contacts, data: item.toJson());
    return Contact.fromJson(response.data['data']);
  }

  Future<Contact> updateContact(String id, Contact item) async {
    final response = await _dioClient.patch('${ApiEndpoints.contacts}/$id', data: item.toJson());
    return Contact.fromJson(response.data['data']);
  }

  Future<void> deleteContact(String id) async {
    await _dioClient.delete('${ApiEndpoints.contacts}/$id');
  }
}
