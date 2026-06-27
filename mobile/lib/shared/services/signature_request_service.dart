import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SignatureRequestService {
  final DioClient _dioClient;
  SignatureRequestService(this._dioClient);

  Future<SignatureRequest> getSignatureRequestById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.signatureRequests}/$id');
    return SignatureRequest.fromJson(response.data['data']);
  }

  Future<List<SignatureRequest>> getSignatureRequests({
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
    final response = await _dioClient.get(ApiEndpoints.signatureRequests, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => SignatureRequest.fromJson(json)).toList();
  }

  Future<SignatureRequest> createSignatureRequest(SignatureRequest item) async {
    final response = await _dioClient.post(ApiEndpoints.signatureRequests, data: item.toJson());
    return SignatureRequest.fromJson(response.data['data']);
  }

  Future<SignatureRequest> updateSignatureRequest(String id, SignatureRequest item) async {
    final response = await _dioClient.patch('${ApiEndpoints.signatureRequests}/$id', data: item.toJson());
    return SignatureRequest.fromJson(response.data['data']);
  }

  Future<void> deleteSignatureRequest(String id) async {
    await _dioClient.delete('${ApiEndpoints.signatureRequests}/$id');
  }
}
