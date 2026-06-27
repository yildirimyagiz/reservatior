import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/models/category.dart';
import 'package:reservatior/shared/models/ai_service_task.dart';

class ListingService {
  final DioClient _dioClient;
  ListingService(this._dioClient);

  Future<Listing> getListingById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.listings}/$id');
    return Listing.fromJson(response.data['data']);
  }

  Future<List<Listing>> getListings({
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
    final response = await _dioClient.get(ApiEndpoints.listings, queryParameters: queryParams);
    
    print('🏠 Listing Response: ${response.data}');
    
    final data = response.data['data'] as List;
    print('🏠 Listing Parsed ${data.length} items');
    return data.map((json) => Listing.fromJson(json)).toList();
  }

  Future<Listing> createListing(Listing item) async {
    final response = await _dioClient.post(ApiEndpoints.listings, data: item.toJson());
    return Listing.fromJson(response.data['data']);
  }

  Future<Listing> updateListing(String id, Listing item) async {
    final response = await _dioClient.patch('${ApiEndpoints.listings}/$id', data: item.toJson());
    return Listing.fromJson(response.data['data']);
  }

  Future<void> deleteListing(String id) async {
    await _dioClient.delete('${ApiEndpoints.listings}/$id');
  }

  Future<List<Category>> fetchCategories({String lang = 'en'}) async {
    final response = await _dioClient.get(ApiEndpoints.categories, queryParameters: {'lang': lang});
    final data = response.data['data'] as List;
    return data.map((json) => Category.fromJson(json)).toList();
  }

  Future<AiServiceTask> triggerAiTask(String orgId, String propertyId, String taskType, Map<String, dynamic> input) async {
    final response = await _dioClient.post(ApiEndpoints.triggerAiService, data: {
      'orgId': orgId,
      'propertyId': propertyId,
      'taskType': taskType,
      'input': input,
    });
    return AiServiceTask.fromJson(response.data['task']);
  }
}
