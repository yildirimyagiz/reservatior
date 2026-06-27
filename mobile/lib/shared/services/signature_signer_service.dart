import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class SignatureSignerService {
  final DioClient _dioClient;
  SignatureSignerService(this._dioClient);

  Future<SignatureSigner> getSignatureSignerById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.signatureSigners}/$id');
    return SignatureSigner.fromJson(response.data['data']);
  }

  Future<List<SignatureSigner>> getSignatureSigners({
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
    final response = await _dioClient.get(ApiEndpoints.signatureSigners, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => SignatureSigner.fromJson(json)).toList();
  }

  Future<SignatureSigner> createSignatureSigner(SignatureSigner item) async {
    final response = await _dioClient.post(ApiEndpoints.signatureSigners, data: item.toJson());
    return SignatureSigner.fromJson(response.data['data']);
  }

  Future<SignatureSigner> updateSignatureSigner(String id, SignatureSigner item) async {
    final response = await _dioClient.patch('${ApiEndpoints.signatureSigners}/$id', data: item.toJson());
    return SignatureSigner.fromJson(response.data['data']);
  }

  Future<void> deleteSignatureSigner(String id) async {
    await _dioClient.delete('${ApiEndpoints.signatureSigners}/$id');
  }
}
