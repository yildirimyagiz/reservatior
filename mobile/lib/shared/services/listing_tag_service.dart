import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class ListingTagService {
  final DioClient _dioClient;

  ListingTagService(this._dioClient);

  // Get ListingTag by ID
  Future<ListingTag> getListingTagById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/listing_tag/$id');
      return ListingTag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all listing_tags
  Future<List<ListingTag>> getListingTags({
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

      final response = await _dioClient.get('/api/v1/listing_tag', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => ListingTag.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create ListingTag
  Future<ListingTag> createListingTag(ListingTag listingTag) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/listing_tag',
        data: listingTag.toJson(),
      );
      return ListingTag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update ListingTag
  Future<ListingTag> updateListingTag(String id, ListingTag listingTag) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/listing_tag/$id',
        data: listingTag.toJson(),
      );
      return ListingTag.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete ListingTag
  Future<void> deleteListingTag(String id) async {
    try {
      await _dioClient.delete('/api/v1/listing_tag/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
