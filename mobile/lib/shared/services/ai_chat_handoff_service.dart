import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIChatHandoffService {
  final DioClient _dioClient;

  AIChatHandoffService(this._dioClient);

  // Get AIChatHandoff by ID
  Future<AIChatHandoff> getAIChatHandoffById(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    try {
      final response = await _dioClient.get('/api/v1/ai_chat_handoff/$id');
      return AIChatHandoff.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_chat_handoffs
  Future<List<AIChatHandoff>> getAIChatHandoffs({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/ai_chat_handoff', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIChatHandoff.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get AIChatHandoffs with filters
  Future<List<AIChatHandoff>> getAIChatHandoffsWithFilters({
    String? sessionId,
    String? handoffTo,
    String? orgId,
    DateTime? handoffAfter,
    bool? resolved,
  }) async {
    final filters = <String, dynamic>{};
    
    if (sessionId != null) filters['sessionId'] = sessionId;
    if (handoffTo != null) filters['handoffTo'] = handoffTo;
    if (orgId != null) filters['orgId'] = orgId;
    if (handoffAfter != null) filters['handoffAfter'] = handoffAfter.toIso8601String();
    if (resolved != null) filters['resolved'] = resolved.toString();

    return getAIChatHandoffs(filters: filters);
  }

  // Create AIChatHandoff
  Future<AIChatHandoff> createAIChatHandoff(AIChatHandoff aIChatHandoff) async {
    if (aIChatHandoff.sessionId == null || aIChatHandoff.sessionId!.isEmpty) {
      throw ArgumentError('Session ID is required');
    }
    if (aIChatHandoff.handoffTo == null || aIChatHandoff.handoffTo!.isEmpty) {
      throw ArgumentError('Handoff to is required');
    }
    
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_chat_handoff',
        data: aIChatHandoff.toJson(),
      );
      return AIChatHandoff.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIChatHandoff
  Future<AIChatHandoff> updateAIChatHandoff(String id, AIChatHandoff aIChatHandoff) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    if (aIChatHandoff.sessionId == null || aIChatHandoff.sessionId!.isEmpty) {
      throw ArgumentError('Session ID is required');
    }
    if (aIChatHandoff.handoffTo == null || aIChatHandoff.handoffTo!.isEmpty) {
      throw ArgumentError('Handoff to is required');
    }
    
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_chat_handoff/$id',
        data: aIChatHandoff.toJson(),
      );
      return AIChatHandoff.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIChatHandoff
  Future<void> deleteAIChatHandoff(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    
    try {
      await _dioClient.delete('/api/v1/ai_chat_handoff/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Resolve AIChatHandoff
  Future<AIChatHandoff> resolveAIChatHandoff(String id, String resolvedBy, {String? notes}) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    if (resolvedBy.isEmpty) {
      throw ArgumentError('Resolved by is required');
    }
    
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_chat_handoff/$id/resolve',
        data: {
          'resolvedBy': resolvedBy,
          'resolvedAt': DateTime.now().toIso8601String(),
          if (notes != null) 'notes': notes,
        },
      );
      return AIChatHandoff.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get AIChatHandoffs by session
  Future<List<AIChatHandoff>> getAIChatHandoffsBySession(String sessionId) async {
    if (sessionId.isEmpty) {
      throw ArgumentError('Session ID cannot be empty');
    }
    
    return getAIChatHandoffsWithFilters(sessionId: sessionId);
  }

  // Get AIChatHandoffs by organization
  Future<List<AIChatHandoff>> getAIChatHandoffsByOrganization(String orgId) async {
    if (orgId.isEmpty) {
      throw ArgumentError('Organization ID cannot be empty');
    }
    
    return getAIChatHandoffsWithFilters(orgId: orgId);
  }

  // Get unresolved AIChatHandoffs
  Future<List<AIChatHandoff>> getUnresolvedAIChatHandoffs({int limit = 50}) async {
    return getAIChatHandoffs(filters: {'resolved': 'false'});
  }

  // Get AIChatHandoffs by date range
  Future<List<AIChatHandoff>> getAIChatHandoffsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    return getAIChatHandoffs(filters: {
      'handoffAfter': startDate.toIso8601String(),
      'handoffBefore': endDate.toIso8601String(),
    });
  }

  Exception _handleError(DioException e) {
    String message = 'Unknown error occurred';
    
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
        message = 'Connection timeout. Please check your internet connection.';
        break;
      case DioExceptionType.sendTimeout:
        message = 'Request timeout. Please try again.';
        break;
      case DioExceptionType.receiveTimeout:
        message = 'Response timeout. Please try again.';
        break;
      case DioExceptionType.badResponse:
        message = 'Invalid response from server. Please try again.';
        break;
      case DioExceptionType.cancel:
        message = 'Request was cancelled.';
        break;
      case DioExceptionType.connectionError:
        message = 'Network connection error. Please check your internet connection.';
        break;
      case DioExceptionType.unknown:
      case DioExceptionType.badCertificate:
        message = 'Invalid SSL certificate. Please check the server configuration.';
        break;
    }
    
    return Exception(message);
  }

}
