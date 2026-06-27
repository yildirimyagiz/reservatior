import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MortgageService {
  final DioClient _dioClient;
  MortgageService(this._dioClient);

  Future<Mortgage> getMortgageById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mortgages}/$id');
    return Mortgage.fromJson(response.data['data']);
  }

  Future<List<Mortgage>> getMortgages({
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
    final response = await _dioClient.get(ApiEndpoints.mortgages, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Mortgage.fromJson(json)).toList();
  }

  Future<Mortgage> createMortgage(Mortgage item) async {
    final response = await _dioClient.post(ApiEndpoints.mortgages, data: item.toJson());
    return Mortgage.fromJson(response.data['data']);
  }

  Future<Mortgage> updateMortgage(String id, Mortgage item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mortgages}/$id', data: item.toJson());
    return Mortgage.fromJson(response.data['data']);
  }

  Future<void> deleteMortgage(String id) async {
    await _dioClient.delete('${ApiEndpoints.mortgages}/$id');
  }
}
