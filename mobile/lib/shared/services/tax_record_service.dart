import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class TaxRecordService {
  final DioClient _dioClient;

  TaxRecordService(this._dioClient);

  // Get TaxRecord by ID
  Future<TaxRecord> getTaxRecordById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tax_record/$id');
      return TaxRecord.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all tax_records
  Future<List<TaxRecord>> getTaxRecords({
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

      final response = await _dioClient.get('/api/v1/tax_record', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => TaxRecord.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create TaxRecord
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
    return Exception('API Error: ${e.message}');
  }
}
