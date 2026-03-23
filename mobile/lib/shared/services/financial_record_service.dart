import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class FinancialRecordService {
  final DioClient _dioClient;

  FinancialRecordService(this._dioClient);

  // Get FinancialRecord by ID
  Future<FinancialRecord> getFinancialRecordById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/financial_record/$id');
      return FinancialRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all financial_records
  Future<List<FinancialRecord>> getFinancialRecords({
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

      final response = await _dioClient.get('/api/v1/financial_record', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => FinancialRecord.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create FinancialRecord
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
    return Exception('API Error: ${e.message}');
  }
}
