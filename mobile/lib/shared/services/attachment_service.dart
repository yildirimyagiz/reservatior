import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AttachmentService {
  final DioClient _dioClient;

  AttachmentService(this._dioClient);

  // Get Attachment by ID
  Future<Attachment> getAttachmentById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/attachment/$id');
      return Attachment.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all attachments
  Future<List<Attachment>> getAttachments({
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

      final response = await _dioClient.get('/api/v1/attachment', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Attachment.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Attachment
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
    return Exception('API Error: ${e.message}');
  }
}
