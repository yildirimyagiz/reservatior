import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Channel operations
/// Provides CRUD operations with proper error handling and type safety
class ChannelRepository {
  final DioClient _dioClient;

  ChannelRepository(this._dioClient);

  /// Get Channel by ID
  /// Returns [Channel] if found, throws [RepositoryException] otherwise
  Future<Channel> getChannelById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/channel/$id');
      if (response.statusCode == 200) {
        return Channel.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch channel',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all channels with pagination and filtering
  /// Returns list of [Channel] objects
  Future<List<Channel>> getchannels({
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
      
      final response = await _dioClient.get('/api/v1/channel', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Channel.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch channels',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Channel
  /// Returns created [Channel] object
  Future<Channel> createChannel(Channel channel) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/channel',
        data: channel.toJson(),
      );
      return Channel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Channel
  Future<Channel> updateChannel(String id, Channel channel) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/channel/$id',
        data: channel.toJson(),
      );
      return Channel.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Channel
  Future<void> deleteChannel(String id) async {
    try {
      await _dioClient.delete('/api/v1/channel/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
