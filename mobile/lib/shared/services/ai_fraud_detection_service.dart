import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class AiFraudDetectionService {
  final DioClient _dioClient;
  AiFraudDetectionService(this._dioClient);

  Future<AiFraudDetection> getAiFraudDetectionById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.aiFraudDetections}/$id');
    return AiFraudDetection.fromJson(response.data['data']);
  }

  Future<List<AiFraudDetection>> getAiFraudDetections({
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
    final response = await _dioClient.get(ApiEndpoints.aiFraudDetections, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => AiFraudDetection.fromJson(json)).toList();
  }

  Future<AiFraudDetection> createAiFraudDetection(AiFraudDetection item) async {
    final response = await _dioClient.post(ApiEndpoints.aiFraudDetections, data: item.toJson());
    return AiFraudDetection.fromJson(response.data['data']);
  }

  Future<AiFraudDetection> updateAiFraudDetection(String id, AiFraudDetection item) async {
    final response = await _dioClient.patch('${ApiEndpoints.aiFraudDetections}/$id', data: item.toJson());
    return AiFraudDetection.fromJson(response.data['data']);
  }

  Future<void> deleteAiFraudDetection(String id) async {
    await _dioClient.delete('${ApiEndpoints.aiFraudDetections}/$id');
  }
}
