import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class LeadSourceService {
  final DioClient _dioClient;

  LeadSourceService(this._dioClient);

  // Get LeadSource by ID
  Future<LeadSource> getLeadSourceById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/lead_source/$id');
      return LeadSource.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all lead_sources
  Future<List<LeadSource>> getLeadSources({
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

      final response = await _dioClient.get('/api/v1/lead_source', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => LeadSource.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create LeadSource
  Future<LeadSource> createLeadSource(LeadSource leadSource) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/lead_source',
        data: leadSource.toJson(),
      );
      return LeadSource.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update LeadSource
  Future<LeadSource> updateLeadSource(String id, LeadSource leadSource) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/lead_source/$id',
        data: leadSource.toJson(),
      );
      return LeadSource.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete LeadSource
  Future<void> deleteLeadSource(String id) async {
    try {
      await _dioClient.delete('/api/v1/lead_source/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
