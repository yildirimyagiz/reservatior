import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for BrandAmbassador operations
/// Provides CRUD operations with proper error handling and type safety
class BrandAmbassadorRepository {
  final DioClient _dioClient;

  BrandAmbassadorRepository(this._dioClient);

  /// Get BrandAmbassador by ID
  /// Returns [BrandAmbassador] if found, throws [RepositoryException] otherwise
  Future<BrandAmbassador> getBrandAmbassadorById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/brand_ambassador/$id');
      if (response.statusCode == 200) {
        return BrandAmbassador.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch brand_ambassador',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all brand_ambassadors with pagination and filtering
  /// Returns list of [BrandAmbassador] objects
  Future<List<BrandAmbassador>> getbrand_ambassadors({
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
      
      final response = await _dioClient.get('/api/v1/brand_ambassador', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => BrandAmbassador.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch brand_ambassadors',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new BrandAmbassador
  /// Returns created [BrandAmbassador] object
  Future<BrandAmbassador> createBrandAmbassador(BrandAmbassador brandAmbassador) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/brand_ambassador',
        data: brandAmbassador.toJson(),
      );
      return BrandAmbassador.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update BrandAmbassador
  Future<BrandAmbassador> updateBrandAmbassador(String id, BrandAmbassador brandAmbassador) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/brand_ambassador/$id',
        data: brandAmbassador.toJson(),
      );
      return BrandAmbassador.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete BrandAmbassador
  Future<void> deleteBrandAmbassador(String id) async {
    try {
      await _dioClient.delete('/api/v1/brand_ambassador/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
