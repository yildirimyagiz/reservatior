import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ReferenceSourceService {
  final DioClient _dioClient;

  ReferenceSourceService(this._dioClient);

  // Get ReferenceSource by ID
  Future<ReferenceSource> getReferenceSourceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/reference_source/$id');
      return ReferenceSource.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all reference_sources
  Future<List<ReferenceSource>> getReferenceSources({
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

      final response = await _dioClient.get('/api/v1/reference_source', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ReferenceSource.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ReferenceSource
  Future<ReferenceSource> createReferenceSource(ReferenceSource referenceSource) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/reference_source',
        data: referenceSource.toJson(),
      );
      return ReferenceSource.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ReferenceSource
  Future<ReferenceSource> updateReferenceSource(String id, ReferenceSource referenceSource) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/reference_source/$id',
        data: referenceSource.toJson(),
      );
      return ReferenceSource.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ReferenceSource
  Future<void> deleteReferenceSource(String id) async {
    try {
      await _dioClient.delete('/api/v1/reference_source/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
