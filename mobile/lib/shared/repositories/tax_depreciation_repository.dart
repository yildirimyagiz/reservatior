import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for TaxDepreciation operations
/// Provides CRUD operations with proper error handling and type safety
class TaxDepreciationRepository {
  final DioClient _dioClient;

  TaxDepreciationRepository(this._dioClient);

  /// Get TaxDepreciation by ID
  /// Returns [TaxDepreciation] if found, throws [RepositoryException] otherwise
  Future<TaxDepreciation> getTaxDepreciationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tax_depreciation/$id');
      if (response.statusCode == 200) {
        return TaxDepreciation.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch tax_depreciation',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all tax_depreciations with pagination and filtering
  /// Returns list of [TaxDepreciation] objects
  Future<List<TaxDepreciation>> gettax_depreciations({
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
      
      final response = await _dioClient.get('/api/v1/tax_depreciation', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => TaxDepreciation.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch tax_depreciations',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new TaxDepreciation
  /// Returns created [TaxDepreciation] object
  Future<TaxDepreciation> createTaxDepreciation(TaxDepreciation taxDepreciation) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/tax_depreciation',
        data: taxDepreciation.toJson(),
      );
      return TaxDepreciation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update TaxDepreciation
  Future<TaxDepreciation> updateTaxDepreciation(String id, TaxDepreciation taxDepreciation) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/tax_depreciation/$id',
        data: taxDepreciation.toJson(),
      );
      return TaxDepreciation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete TaxDepreciation
  Future<void> deleteTaxDepreciation(String id) async {
    try {
      await _dioClient.delete('/api/v1/tax_depreciation/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
