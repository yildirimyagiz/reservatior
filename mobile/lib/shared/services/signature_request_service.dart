import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SignatureRequestService {
  final DioClient _dioClient;

  SignatureRequestService(this._dioClient);

  // Get SignatureRequest by ID
  Future<SignatureRequest> getSignatureRequestById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/signature_request/$id');
      return SignatureRequest.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all signature_requests
  Future<List<SignatureRequest>> getSignatureRequests({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    try {
      final queryParams = <String, dynamic>{
        'page': page.toString(),
        'limit': limit.toString(),
      };

      if (filters != null) {
        queryParams.addAll(filters);
      }

      final response = await _dioClient.get('/api/v1/signature_request', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => SignatureRequest.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create SignatureRequest
  Future<SignatureRequest> createSignatureRequest(SignatureRequest signatureRequest) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/signature_request',
        data: signatureRequest.toJson(),
      );
      return SignatureRequest.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SignatureRequest
  Future<SignatureRequest> updateSignatureRequest(String id, SignatureRequest signatureRequest) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/signature_request/$id',
        data: signatureRequest.toJson(),
      );
      return SignatureRequest.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SignatureRequest
  Future<void> deleteSignatureRequest(String id) async {
    try {
      await _dioClient.delete('/api/v1/signature_request/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
