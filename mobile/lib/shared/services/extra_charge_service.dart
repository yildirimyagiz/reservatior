import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class ExtraChargeService {
  final DioClient _dioClient;
  ExtraChargeService(this._dioClient);

  Future<ExtraCharge> getExtraChargeById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.extraCharges}/$id');
    return ExtraCharge.fromJson(response.data['data']);
  }

  Future<List<ExtraCharge>> getExtraCharges({
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
    final response = await _dioClient.get(ApiEndpoints.extraCharges, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => ExtraCharge.fromJson(json)).toList();
  }

  Future<ExtraCharge> createExtraCharge(ExtraCharge item) async {
    final response = await _dioClient.post(ApiEndpoints.extraCharges, data: item.toJson());
    return ExtraCharge.fromJson(response.data['data']);
  }

  Future<ExtraCharge> updateExtraCharge(String id, ExtraCharge item) async {
    final response = await _dioClient.patch('${ApiEndpoints.extraCharges}/$id', data: item.toJson());
    return ExtraCharge.fromJson(response.data['data']);
  }

  Future<void> deleteExtraCharge(String id) async {
    await _dioClient.delete('${ApiEndpoints.extraCharges}/$id');
  }
}
