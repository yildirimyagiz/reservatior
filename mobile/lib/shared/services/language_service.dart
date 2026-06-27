import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class LanguageService {
  final DioClient _dioClient;
  LanguageService(this._dioClient);

  Future<Language> getLanguageById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.languages}/$id');
    return Language.fromJson(response.data['data']);
  }

  Future<List<Language>> getLanguages({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.languages, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Language.fromJson(json)).toList();
  }

  Future<Language> createLanguage(Language item) async {
    final response = await _dioClient.post(ApiEndpoints.languages, data: item.toJson());
    return Language.fromJson(response.data['data']);
  }

  Future<Language> updateLanguage(String id, Language item) async {
    final response = await _dioClient.patch('${ApiEndpoints.languages}/$id', data: item.toJson());
    return Language.fromJson(response.data['data']);
  }

  Future<void> deleteLanguage(String id) async {
    await _dioClient.delete('${ApiEndpoints.languages}/$id');
  }
}
