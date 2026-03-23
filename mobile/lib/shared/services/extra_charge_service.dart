import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ExtraChargeService {
  final DioClient _dioClient;

  ExtraChargeService(this._dioClient);

  // Get ExtraCharge by ID
  Future<ExtraCharge> getExtraChargeById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/extra_charge/$id');
      return ExtraCharge.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all extra_charges
  Future<List<ExtraCharge>> getExtraCharges({
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

      final response = await _dioClient.get('/api/v1/extra_charge', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ExtraCharge.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ExtraCharge
  Future<ExtraCharge> createExtraCharge(ExtraCharge extraCharge) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/extra_charge',
        data: extraCharge.toJson(),
      );
      return ExtraCharge.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ExtraCharge
  Future<ExtraCharge> updateExtraCharge(String id, ExtraCharge extraCharge) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/extra_charge/$id',
        data: extraCharge.toJson(),
      );
      return ExtraCharge.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ExtraCharge
  Future<void> deleteExtraCharge(String id) async {
    try {
      await _dioClient.delete('/api/v1/extra_charge/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
