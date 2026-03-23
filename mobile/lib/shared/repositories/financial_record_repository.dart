import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for FinancialRecord operations
/// Provides CRUD operations with proper error handling and type safety
class FinancialRecordRepository {
  final DioClient _dioClient;

  FinancialRecordRepository(this._dioClient);

  /// Get FinancialRecord by ID
  /// Returns [FinancialRecord] if found, throws [RepositoryException] otherwise
  Future<FinancialRecord> getFinancialRecordById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/financial_record/$id');
      if (response.statusCode == 200) {
        return FinancialRecord.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch financial_record',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all financial_records with pagination and filtering
  /// Returns list of [FinancialRecord] objects
  Future<List<FinancialRecord>> getfinancial_records({
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
      
      final response = await _dioClient.get('/api/v1/financial_record', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => FinancialRecord.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch financial_records',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new FinancialRecord
  /// Returns created [FinancialRecord] object
  Future<FinancialRecord> createFinancialRecord(FinancialRecord financialRecord) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/financial_record',
        data: financialRecord.toJson(),
      );
      return FinancialRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update FinancialRecord
  Future<FinancialRecord> updateFinancialRecord(String id, FinancialRecord financialRecord) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/financial_record/$id',
        data: financialRecord.toJson(),
      );
      return FinancialRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete FinancialRecord
  Future<void> deleteFinancialRecord(String id) async {
    try {
      await _dioClient.delete('/api/v1/financial_record/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
