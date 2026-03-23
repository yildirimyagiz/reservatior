import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Contact operations
/// Provides CRUD operations with proper error handling and type safety
class ContactRepository {
  final DioClient _dioClient;

  ContactRepository(this._dioClient);

  /// Get Contact by ID
  /// Returns [Contact] if found, throws [RepositoryException] otherwise
  Future<Contact> getContactById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/contact/$id');
      if (response.statusCode == 200) {
        return Contact.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch contact',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all contacts with pagination and filtering
  /// Returns list of [Contact] objects
  Future<List<Contact>> getcontacts({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/contact', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Contact.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch contacts',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Contact
  /// Returns created [Contact] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
