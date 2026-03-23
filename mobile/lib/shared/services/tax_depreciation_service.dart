import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class TaxDepreciationService {
  final DioClient _dioClient;

  TaxDepreciationService(this._dioClient);

  // Get TaxDepreciation by ID
  Future<TaxDepreciation> getTaxDepreciationById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tax_depreciation/$id');
      return TaxDepreciation.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all tax_depreciations
  Future<List<TaxDepreciation>> getTaxDepreciations({
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

      final response = await _dioClient.get('/api/v1/tax_depreciation', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => TaxDepreciation.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create TaxDepreciation
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
    return Exception('API Error: ${e.message}');
  }
}
