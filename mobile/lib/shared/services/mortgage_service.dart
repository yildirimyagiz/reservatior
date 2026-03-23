import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MortgageService {
  final DioClient _dioClient;

  MortgageService(this._dioClient);

  // Get Mortgage by ID
  Future<Mortgage> getMortgageById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mortgage/$id');
      return Mortgage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all mortgages
  Future<List<Mortgage>> getMortgages({
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

      final response = await _dioClient.get('/api/v1/mortgage', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Mortgage.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Mortgage
  Future<Mortgage> createMortgage(Mortgage mortgage) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mortgage',
        data: mortgage.toJson(),
      );
      return Mortgage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Mortgage
  Future<Mortgage> updateMortgage(String id, Mortgage mortgage) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mortgage/$id',
        data: mortgage.toJson(),
      );
      return Mortgage.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Mortgage
  Future<void> deleteMortgage(String id) async {
    try {
      await _dioClient.delete('/api/v1/mortgage/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
