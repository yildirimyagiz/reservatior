import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import '../../core/error/repository_exception.dart';

/// Repository for Language operations
/// Provides CRUD operations with proper error handling and type safety
class LanguageRepository {
  final DioClient _dioClient;

  LanguageRepository(this._dioClient);

  /// Get Language by ID
  /// Returns [Language] if found, throws [RepositoryException] otherwise
  Future<Language> getLanguageById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/language/$id');
      if (response.statusCode == 200) {
        return Language.fromJson(response.data['data']);
      } else {
        throw RepositoryException(
          message: 'Failed to fetch language',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.notFound,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Get all languages with pagination and filtering
  /// Returns list of [Language] objects
  Future<List<Language>> getlanguages({
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
      
      final response = await _dioClient.get('/api/v1/language', queryParameters: queryParams);
      if (response.statusCode == 200) {
        final data = response.data['data'] as List;
        return data.map((item) => Language.fromJson(item)).toList();
      } else {
        throw RepositoryException(
          message: 'Failed to fetch languages',
          code: response.statusCode.toString(),
          type: RepositoryExceptionType.fetchError,
        );
      }
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  /// Create new Language
  /// Returns created [Language] object
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
    // Implement error handling logic here
    return Exception('API Error: ${e.message}');
  }
}
