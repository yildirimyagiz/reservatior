import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for TaxRecord operations
/// Provides CRUD operations with proper error handling and type safety
class TaxRecordRepository {
  final DioClient _dioClient;

  TaxRecordRepository(this._dioClient);

  /// Get TaxRecord by ID
  /// Returns [TaxRecord] if found, throws [RepositoryException] otherwise
  Future<TaxRecord> getTaxRecordById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tax_record/$id');
      if (response.statusCode == 200) {
        return TaxRecord.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch tax_record',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all tax_records with pagination and filtering
  /// Returns list of [TaxRecord] objects
  Future<List<TaxRecord>> gettax_records({
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
      
      final response = await _dioClient.get('/api/v1/tax_record', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => TaxRecord.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch tax_records',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new TaxRecord
  /// Returns created [TaxRecord] object
  Future<TaxRecord> createTaxRecord(TaxRecord taxRecord) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/tax_record',
        data: taxRecord.toJson(),
      );
      return TaxRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update TaxRecord
  Future<TaxRecord> updateTaxRecord(String id, TaxRecord taxRecord) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/tax_record/$id',
        data: taxRecord.toJson(),
      );
      return TaxRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete TaxRecord
  Future<void> deleteTaxRecord(String id) async {
    try {
      await _dioClient.delete('/api/v1/tax_record/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
