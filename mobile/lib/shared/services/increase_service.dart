import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class IncreaseService {
  final DioClient _dioClient;

  IncreaseService(this._dioClient);

  // Get Increase by ID
  Future<Increase> getIncreaseById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/increase/$id');
      return Increase.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all increases
  Future<List<Increase>> getIncreases({
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

      final response = await _dioClient.get('/api/v1/increase', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Increase.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Increase
  Future<Increase> createIncrease(Increase increase) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/increase',
        data: increase.toJson(),
      );
      return Increase.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Increase
  Future<Increase> updateIncrease(String id, Increase increase) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/increase/$id',
        data: increase.toJson(),
      );
      return Increase.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Increase
  Future<void> deleteIncrease(String id) async {
    try {
      await _dioClient.delete('/api/v1/increase/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
