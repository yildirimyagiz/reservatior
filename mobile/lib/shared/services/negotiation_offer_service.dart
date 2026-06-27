import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class NegotiationOfferService {
  final DioClient _dioClient;
  NegotiationOfferService(this._dioClient);

  Future<NegotiationOffer> getNegotiationOfferById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.negotiationOffers}/$id');
    return NegotiationOffer.fromJson(response.data['data']);
  }

  Future<List<NegotiationOffer>> getNegotiationOffers({
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
    final response = await _dioClient.get(ApiEndpoints.negotiationOffers, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => NegotiationOffer.fromJson(json)).toList();
  }

  Future<NegotiationOffer> createNegotiationOffer(NegotiationOffer item) async {
    final response = await _dioClient.post(ApiEndpoints.negotiationOffers, data: item.toJson());
    return NegotiationOffer.fromJson(response.data['data']);
  }

  Future<NegotiationOffer> updateNegotiationOffer(String id, NegotiationOffer item) async {
    final response = await _dioClient.patch('${ApiEndpoints.negotiationOffers}/$id', data: item.toJson());
    return NegotiationOffer.fromJson(response.data['data']);
  }

  Future<void> deleteNegotiationOffer(String id) async {
    await _dioClient.delete('${ApiEndpoints.negotiationOffers}/$id');
  }
}
