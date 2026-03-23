import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AgencyService {
  final DioClient _dioClient;

  AgencyService(this._dioClient);

  // Get Agency by ID
  Future<Agency> getAgencyById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/agency/$id');
      return Agency.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all agencys
  Future<List<Agency>> getAgencys({
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

      final response = await _dioClient.get('/api/v1/agency', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Agency.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Agency
  Future<Agency> createAgency(Agency agency) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/agency',
        data: agency.toJson(),
      );
      return Agency.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Agency
  Future<Agency> updateAgency(String id, Agency agency) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/agency/$id',
        data: agency.toJson(),
      );
      return Agency.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Agency
  Future<void> deleteAgency(String id) async {
    try {
      await _dioClient.delete('/api/v1/agency/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
