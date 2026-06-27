import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MortgageOfferService {
  final DioClient _dioClient;
  MortgageOfferService(this._dioClient);

  Future<MortgageOffer> getMortgageOfferById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mortgageOffers}/$id');
    return MortgageOffer.fromJson(response.data['data']);
  }

  Future<List<MortgageOffer>> getMortgageOffers({
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
    final response = await _dioClient.get(ApiEndpoints.mortgageOffers, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MortgageOffer.fromJson(json)).toList();
  }

  Future<MortgageOffer> createMortgageOffer(MortgageOffer item) async {
    final response = await _dioClient.post(ApiEndpoints.mortgageOffers, data: item.toJson());
    return MortgageOffer.fromJson(response.data['data']);
  }

  Future<MortgageOffer> updateMortgageOffer(String id, MortgageOffer item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mortgageOffers}/$id', data: item.toJson());
    return MortgageOffer.fromJson(response.data['data']);
  }

  Future<void> deleteMortgageOffer(String id) async {
    await _dioClient.delete('${ApiEndpoints.mortgageOffers}/$id');
  }
}
