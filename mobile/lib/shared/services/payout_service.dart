import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class PayoutService {
  final DioClient _dioClient;
  PayoutService(this._dioClient);

  Future<Payout> getPayoutById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.payouts}/$id');
    return Payout.fromJson(response.data['data']);
  }

  Future<List<Payout>> getPayouts({
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
    final response = await _dioClient.get(ApiEndpoints.payouts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Payout.fromJson(json)).toList();
  }

  Future<Payout> createPayout(Payout item) async {
    final response = await _dioClient.post(ApiEndpoints.payouts, data: item.toJson());
    return Payout.fromJson(response.data['data']);
  }

  Future<Payout> updatePayout(String id, Payout item) async {
    final response = await _dioClient.patch('${ApiEndpoints.payouts}/$id', data: item.toJson());
    return Payout.fromJson(response.data['data']);
  }

  Future<void> deletePayout(String id) async {
    await _dioClient.delete('${ApiEndpoints.payouts}/$id');
  }
}
