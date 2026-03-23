import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class EarningService {
  final DioClient _dioClient;

  EarningService(this._dioClient);

  // Get Earning by ID
  Future<Earning> getEarningById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/earning/$id');
      return Earning.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all earnings
  Future<List<Earning>> getEarnings({
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

      final response = await _dioClient.get('/api/v1/earning', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Earning.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Earning
  Future<Earning> createEarning(Earning earning) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/earning',
        data: earning.toJson(),
      );
      return Earning.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Earning
  Future<Earning> updateEarning(String id, Earning earning) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/earning/$id',
        data: earning.toJson(),
      );
      return Earning.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Earning
  Future<void> deleteEarning(String id) async {
    try {
      await _dioClient.delete('/api/v1/earning/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
