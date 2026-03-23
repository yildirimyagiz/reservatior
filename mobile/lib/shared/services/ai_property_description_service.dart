import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class AIPropertyDescriptionService {
  final DioClient _dioClient;

  AIPropertyDescriptionService(this._dioClient);

  // Get AIPropertyDescription by ID
  Future<AIPropertyDescription> getAIPropertyDescriptionById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/ai_property_description/$id');
      return AIPropertyDescription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all ai_property_descriptions
  Future<List<AIPropertyDescription>> getAIPropertyDescriptions({
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

      final response = await _dioClient.get('/api/v1/ai_property_description', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => AIPropertyDescription.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create AIPropertyDescription
  Future<AIPropertyDescription> createAIPropertyDescription(AIPropertyDescription aIPropertyDescription) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/ai_property_description',
        data: aIPropertyDescription.toJson(),
      );
      return AIPropertyDescription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update AIPropertyDescription
  Future<AIPropertyDescription> updateAIPropertyDescription(String id, AIPropertyDescription aIPropertyDescription) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/ai_property_description/$id',
        data: aIPropertyDescription.toJson(),
      );
      return AIPropertyDescription.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete AIPropertyDescription
  Future<void> deleteAIPropertyDescription(String id) async {
    try {
      await _dioClient.delete('/api/v1/ai_property_description/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
