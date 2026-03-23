import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class LanguageService {
  final DioClient _dioClient;

  LanguageService(this._dioClient);

  // Get Language by ID
  Future<Language> getLanguageById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/language/$id');
      return Language.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all languages
  Future<List<Language>> getLanguages({
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

      final response = await _dioClient.get('/api/v1/language', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => Language.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create Language
  Future<Language> createLanguage(Language language) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/language',
        data: language.toJson(),
      );
      return Language.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update Language
  Future<Language> updateLanguage(String id, Language language) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/language/$id',
        data: language.toJson(),
      );
      return Language.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete Language
  Future<void> deleteLanguage(String id) async {
    try {
      await _dioClient.delete('/api/v1/language/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
