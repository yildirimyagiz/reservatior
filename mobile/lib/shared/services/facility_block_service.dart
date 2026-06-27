import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class FacilityBlockService {
  final DioClient _dioClient;
  FacilityBlockService(this._dioClient);

  Future<FacilityBlock> getFacilityBlockById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.facilityBlocks}/$id');
    return FacilityBlock.fromJson(response.data['data']);
  }

  Future<List<FacilityBlock>> getFacilityBlocks({
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
    final response = await _dioClient.get(ApiEndpoints.facilityBlocks, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => FacilityBlock.fromJson(json)).toList();
  }

  Future<FacilityBlock> createFacilityBlock(FacilityBlock item) async {
    final response = await _dioClient.post(ApiEndpoints.facilityBlocks, data: item.toJson());
    return FacilityBlock.fromJson(response.data['data']);
  }

  Future<FacilityBlock> updateFacilityBlock(String id, FacilityBlock item) async {
    final response = await _dioClient.patch('${ApiEndpoints.facilityBlocks}/$id', data: item.toJson());
    return FacilityBlock.fromJson(response.data['data']);
  }

  Future<void> deleteFacilityBlock(String id) async {
    await _dioClient.delete('${ApiEndpoints.facilityBlocks}/$id');
  }
}
