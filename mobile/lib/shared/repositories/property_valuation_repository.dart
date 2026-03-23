import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for PropertyValuation operations
/// Provides CRUD operations with proper error handling and type safety
class PropertyValuationRepository {
  final DioClient _dioClient;

  PropertyValuationRepository(this._dioClient);

  /// Get PropertyValuation by ID
  /// Returns [PropertyValuation] if found, throws [RepositoryException] otherwise
  Future<PropertyValuation> getPropertyValuationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_valuation/$id');
      if (response.statusCode == 200) {
        return PropertyValuation.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_valuation',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all property_valuations with pagination and filtering
  /// Returns list of [PropertyValuation] objects
  Future<List<PropertyValuation>> getproperty_valuations({
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
      
      final response = await _dioClient.get('/api/v1/property_valuation', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => PropertyValuation.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_valuations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new PropertyValuation
  /// Returns created [PropertyValuation] object
  Future<PropertyValuation> createPropertyValuation(PropertyValuation propertyValuation) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_valuation',
        data: propertyValuation.toJson(),
      );
      return PropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyValuation
  Future<PropertyValuation> updatePropertyValuation(String id, PropertyValuation propertyValuation) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_valuation/$id',
        data: propertyValuation.toJson(),
      );
      return PropertyValuation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyValuation
  Future<void> deletePropertyValuation(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_valuation/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
