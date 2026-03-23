import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for PropertyPromotion operations
/// Provides CRUD operations with proper error handling and type safety
class PropertyPromotionRepository {
  final DioClient _dioClient;

  PropertyPromotionRepository(this._dioClient);

  /// Get PropertyPromotion by ID
  /// Returns [PropertyPromotion] if found, throws [RepositoryException] otherwise
  Future<PropertyPromotion> getPropertyPromotionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/property_promotion/$id');
      if (response.statusCode == 200) {
        return PropertyPromotion.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_promotion',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all property_promotions with pagination and filtering
  /// Returns list of [PropertyPromotion] objects
  Future<List<PropertyPromotion>> getproperty_promotions({
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
      
      final response = await _dioClient.get('/api/v1/property_promotion', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => PropertyPromotion.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch property_promotions',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new PropertyPromotion
  /// Returns created [PropertyPromotion] object
  Future<PropertyPromotion> createPropertyPromotion(PropertyPromotion propertyPromotion) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/property_promotion',
        data: propertyPromotion.toJson(),
      );
      return PropertyPromotion.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update PropertyPromotion
  Future<PropertyPromotion> updatePropertyPromotion(String id, PropertyPromotion propertyPromotion) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/property_promotion/$id',
        data: propertyPromotion.toJson(),
      );
      return PropertyPromotion.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete PropertyPromotion
  Future<void> deletePropertyPromotion(String id) async {
    try {
      await _dioClient.delete('/api/v1/property_promotion/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
