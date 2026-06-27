import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class InvestorPropertyService {
  final DioClient _dioClient;
  InvestorPropertyService(this._dioClient);

  Future<InvestorProperty> getInvestorPropertyById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.investorProperties}/$id');
    return InvestorProperty.fromJson(response.data['data']);
  }

  Future<List<InvestorProperty>> getInvestorProperties({
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
    final response = await _dioClient.get(ApiEndpoints.investorProperties, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => InvestorProperty.fromJson(json)).toList();
  }

  Future<InvestorProperty> createInvestorProperty(InvestorProperty item) async {
    final response = await _dioClient.post(ApiEndpoints.investorProperties, data: item.toJson());
    return InvestorProperty.fromJson(response.data['data']);
  }

  Future<InvestorProperty> updateInvestorProperty(String id, InvestorProperty item) async {
    final response = await _dioClient.patch('${ApiEndpoints.investorProperties}/$id', data: item.toJson());
    return InvestorProperty.fromJson(response.data['data']);
  }

  Future<void> deleteInvestorProperty(String id) async {
    await _dioClient.delete('${ApiEndpoints.investorProperties}/$id');
  }
}
