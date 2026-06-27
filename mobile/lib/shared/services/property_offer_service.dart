import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PropertyOfferService {
  final DioClient _dioClient;
  PropertyOfferService(this._dioClient);

  Future<PropertyOffer> getPropertyOfferById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.propertyOffers}/$id');
    return PropertyOffer.fromJson(response.data['data']);
  }

  Future<List<PropertyOffer>> getPropertyOffers({
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
    final response = await _dioClient.get(ApiEndpoints.propertyOffers, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyOffer.fromJson(json)).toList();
  }

  Future<PropertyOffer> createPropertyOffer(PropertyOffer item) async {
    final response = await _dioClient.post(ApiEndpoints.propertyOffers, data: item.toJson());
    return PropertyOffer.fromJson(response.data['data']);
  }

  Future<PropertyOffer> updatePropertyOffer(String id, PropertyOffer item) async {
    final response = await _dioClient.patch('${ApiEndpoints.propertyOffers}/$id', data: item.toJson());
    return PropertyOffer.fromJson(response.data['data']);
  }

  Future<void> deletePropertyOffer(String id) async {
    await _dioClient.delete('${ApiEndpoints.propertyOffers}/$id');
  }
}
