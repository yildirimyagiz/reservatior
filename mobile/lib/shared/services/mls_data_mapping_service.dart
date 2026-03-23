import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MlsDataMappingService {
  final DioClient _dioClient;

  MlsDataMappingService(this._dioClient);

  // Get MlsDataMapping by ID
  Future<MlsDataMapping> getMlsDataMappingById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mls_data_mapping/$id');
      return MlsDataMapping.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all mls_data_mappings
  Future<List<MlsDataMapping>> getMlsDataMappings({
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

      final response = await _dioClient.get('/api/v1/mls_data_mapping', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MlsDataMapping.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MlsDataMapping
  Future<MlsDataMapping> createMlsDataMapping(MlsDataMapping mlsDataMapping) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mls_data_mapping',
        data: mlsDataMapping.toJson(),
      );
      return MlsDataMapping.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MlsDataMapping
  Future<MlsDataMapping> updateMlsDataMapping(String id, MlsDataMapping mlsDataMapping) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mls_data_mapping/$id',
        data: mlsDataMapping.toJson(),
      );
      return MlsDataMapping.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MlsDataMapping
  Future<void> deleteMlsDataMapping(String id) async {
    try {
      await _dioClient.delete('/api/v1/mls_data_mapping/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
