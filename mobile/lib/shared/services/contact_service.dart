import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ContactService {
  final DioClient _dioClient;

  ContactService(this._dioClient);

  // Get Contact by ID
  Future<Contact> getContactById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/contact/$id');
      return Contact.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all contacts
  Future<List<Contact>> getContacts({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/contact', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Contact.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Contact
  Future<Contact> createContact(Contact contact) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/contact',
        data: contact.toJson(),
      );
      return Contact.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Contact
  Future<Contact> updateContact(String id, Contact contact) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/contact/$id',
        data: contact.toJson(),
      );
      return Contact.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Contact
  Future<void> deleteContact(String id) async {
    try {
      await _dioClient.delete('/api/v1/contact/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
