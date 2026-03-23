import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class LeadService {
  final DioClient _dioClient;

  LeadService(this._dioClient);

  // Get Lead by ID
  Future<Lead> getLeadById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/lead/$id');
      return Lead.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all leads
  Future<List<Lead>> getLeads({
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

      final response = await _dioClient.get('/api/v1/lead', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Lead.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Lead
  Future<Lead> createLead(Lead lead) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/lead',
        data: lead.toJson(),
      );
      return Lead.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Lead
  Future<Lead> updateLead(String id, Lead lead) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/lead/$id',
        data: lead.toJson(),
      );
      return Lead.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Lead
  Future<void> deleteLead(String id) async {
    try {
      await _dioClient.delete('/api/v1/lead/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
