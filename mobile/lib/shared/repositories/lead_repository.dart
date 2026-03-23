import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Lead operations
/// Provides CRUD operations with proper error handling and type safety
class LeadRepository {
  final DioClient _dioClient;

  LeadRepository(this._dioClient);

  /// Get Lead by ID
  /// Returns [Lead] if found, throws [RepositoryException] otherwise
  Future<Lead> getLeadById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/lead/$id');
      if (response.statusCode == 200) {
        return Lead.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch lead',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all leads with pagination and filtering
  /// Returns list of [Lead] objects
  Future<List<Lead>> getleads({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page,
        'limit': limit,
        if (sortBy != null) 'sort_by': sortBy,
        if (sortOrder != null) 'sort_order': sortOrder,
        ...?filters,
      };
      
      final response = await _dioClient.get('/api/v1/lead', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Lead.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch leads',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Lead
  /// Returns created [Lead] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
