import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for CommunicationTemplate operations
/// Provides CRUD operations with proper error handling and type safety
class CommunicationTemplateRepository {
  final DioClient _dioClient;

  CommunicationTemplateRepository(this._dioClient);

  /// Get CommunicationTemplate by ID
  /// Returns [CommunicationTemplate] if found, throws [RepositoryException] otherwise
  Future<CommunicationTemplate> getCommunicationTemplateById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/communication_template/$id');
      if (response.statusCode == 200) {
        return CommunicationTemplate.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch communication_template',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all communication_templates with pagination and filtering
  /// Returns list of [CommunicationTemplate] objects
  Future<List<CommunicationTemplate>> getcommunication_templates({
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
      
      final response = await _dioClient.get('/api/v1/communication_template', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => CommunicationTemplate.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch communication_templates',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new CommunicationTemplate
  /// Returns created [CommunicationTemplate] object
  Future<CommunicationTemplate> createCommunicationTemplate(CommunicationTemplate communicationTemplate) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/communication_template',
        data: communicationTemplate.toJson(),
      );
      return CommunicationTemplate.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update CommunicationTemplate
  Future<CommunicationTemplate> updateCommunicationTemplate(String id, CommunicationTemplate communicationTemplate) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/communication_template/$id',
        data: communicationTemplate.toJson(),
      );
      return CommunicationTemplate.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete CommunicationTemplate
  Future<void> deleteCommunicationTemplate(String id) async {
    try {
      await _dioClient.delete('/api/v1/communication_template/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
