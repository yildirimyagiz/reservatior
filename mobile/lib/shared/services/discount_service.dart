import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class DiscountService {
  final DioClient _dioClient;
  DiscountService(this._dioClient);

  Future<Discount> getDiscountById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.discounts}/$id');
    return Discount.fromJson(response.data['data']);
  }

  Future<List<Discount>> getDiscounts({
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
    final response = await _dioClient.get(ApiEndpoints.discounts, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Discount.fromJson(json)).toList();
  }

  Future<Discount> createDiscount(Discount item) async {
    final response = await _dioClient.post(ApiEndpoints.discounts, data: item.toJson());
    return Discount.fromJson(response.data['data']);
  }

  Future<Discount> updateDiscount(String id, Discount item) async {
    final response = await _dioClient.patch('${ApiEndpoints.discounts}/$id', data: item.toJson());
    return Discount.fromJson(response.data['data']);
  }

  Future<void> deleteDiscount(String id) async {
    await _dioClient.delete('${ApiEndpoints.discounts}/$id');
  }
}
