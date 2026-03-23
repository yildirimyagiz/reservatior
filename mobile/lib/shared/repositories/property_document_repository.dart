import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for PropertyDocument operations
/// Provides CRUD operations with proper error handling and type safety
class PropertyDocumentRepository {
  final DioClient _dioClient;

  PropertyDocumentRepository(this._dioClient);

  /// Get PropertyDocument by ID
  /// Returns [PropertyDocument] if found, throws [RepositoryException] otherwise
  Future<PropertyDocument> getPropertyDocumentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_document/$id');
      if (response.statusCode == 200) {
        return PropertyDocument.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_document',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all property_documents with pagination and filtering
  /// Returns list of [PropertyDocument] objects
  Future<List<PropertyDocument>> getproperty_documents({
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
      
      final response = await _dioClient.get('/api/v1/property_document', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => PropertyDocument.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_documents',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new PropertyDocument
  /// Returns created [PropertyDocument] object
  Future<PropertyDocument> createPropertyDocument(PropertyDocument propertyDocument) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_document',
        data: propertyDocument.toJson(),
      );
      return PropertyDocument.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyDocument
  Future<PropertyDocument> updatePropertyDocument(String id, PropertyDocument propertyDocument) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_document/$id',
        data: propertyDocument.toJson(),
      );
      return PropertyDocument.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyDocument
  Future<void> deletePropertyDocument(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_document/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
