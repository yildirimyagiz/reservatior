import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Attachment operations
/// Provides CRUD operations with proper error handling and type safety
class AttachmentRepository {
  final DioClient _dioClient;

  AttachmentRepository(this._dioClient);

  /// Get Attachment by ID
  /// Returns [Attachment] if found, throws [RepositoryException] otherwise
  Future<Attachment> getAttachmentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/attachment/$id');
      if (response.statusCode == 200) {
        return Attachment.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch attachment',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all attachments with pagination and filtering
  /// Returns list of [Attachment] objects
  Future<List<Attachment>> getattachments({
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
      
      final response = await _dioClient.get('/api/v1/attachment', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Attachment.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch attachments',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Attachment
  /// Returns created [Attachment] object
  Future<Attachment> createAttachment(Attachment attachment) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/attachment',
        data: attachment.toJson(),
      );
      return Attachment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Attachment
  Future<Attachment> updateAttachment(String id, Attachment attachment) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/attachment/$id',
        data: attachment.toJson(),
      );
      return Attachment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Attachment
  Future<void> deleteAttachment(String id) async {
    try {
      await _dioClient.delete('/api/v1/attachment/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
