import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class OfferService {
  final DioClient _dioClient;
  OfferService(this._dioClient);

  Future<Offer> getOfferById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.offers}/$id');
    return Offer.fromJson(response.data['data']);
  }

  Future<List<Offer>> getOffers({
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
    final response = await _dioClient.get(ApiEndpoints.offers, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Offer.fromJson(json)).toList();
  }

  Future<Offer> createOffer(Offer item) async {
    final response = await _dioClient.post(ApiEndpoints.offers, data: item.toJson());
    return Offer.fromJson(response.data['data']);
  }

  Future<Offer> updateOffer(String id, Offer item) async {
    final response = await _dioClient.patch('${ApiEndpoints.offers}/$id', data: item.toJson());
    return Offer.fromJson(response.data['data']);
  }

  Future<void> deleteOffer(String id) async {
    await _dioClient.delete('${ApiEndpoints.offers}/$id');
  }
}
