import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class Tax1099FormService {
  final DioClient _dioClient;

  Tax1099FormService(this._dioClient);

  // Get Tax1099Form by ID
  Future<Tax1099Form> getTax1099FormById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/tax1099_form/$id');
      return Tax1099Form.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all tax1099_forms
  Future<List<Tax1099Form>> getTax1099Forms({
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

      final response = await _dioClient.get('/api/v1/tax1099_form', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Tax1099Form.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Tax1099Form
  Future<Tax1099Form> createTax1099Form(Tax1099Form tax1099Form) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/tax1099_form',
        data: tax1099Form.toJson(),
      );
      return Tax1099Form.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Tax1099Form
  Future<Tax1099Form> updateTax1099Form(String id, Tax1099Form tax1099Form) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/tax1099_form/$id',
        data: tax1099Form.toJson(),
      );
      return Tax1099Form.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Tax1099Form
  Future<void> deleteTax1099Form(String id) async {
    try {
      await _dioClient.delete('/api/v1/tax1099_form/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
