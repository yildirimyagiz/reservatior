import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class VerificationService {
  final DioClient _dioClient;
  VerificationService(this._dioClient);

  Future<Verification> getVerificationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.verifications}/$id');
    return Verification.fromJson(response.data['data']);
  }

  Future<List<Verification>> getVerifications({
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
    final response = await _dioClient.get(ApiEndpoints.verifications, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => Verification.fromJson(json)).toList();
  }

  Future<Verification> createVerification(Verification item) async {
    final response = await _dioClient.post(ApiEndpoints.verifications, data: item.toJson());
    return Verification.fromJson(response.data['data']);
  }

  Future<Verification> updateVerification(String id, Verification item) async {
    final response = await _dioClient.patch('${ApiEndpoints.verifications}/$id', data: item.toJson());
    return Verification.fromJson(response.data['data']);
  }

  Future<void> deleteVerification(String id) async {
    await _dioClient.delete('${ApiEndpoints.verifications}/$id');
  }
}
