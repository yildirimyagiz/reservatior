import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class SignatureSignerService {
  final DioClient _dioClient;

  SignatureSignerService(this._dioClient);

  // Get SignatureSigner by ID
  Future<SignatureSigner> getSignatureSignerById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/signature_signer/$id');
      return SignatureSigner.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all signature_signers
  Future<List<SignatureSigner>> getSignatureSigners({
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

      final response = await _dioClient.get('/api/v1/signature_signer', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => SignatureSigner.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create SignatureSigner
  Future<SignatureSigner> createSignatureSigner(SignatureSigner signatureSigner) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/signature_signer',
        data: signatureSigner.toJson(),
      );
      return SignatureSigner.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update SignatureSigner
  Future<SignatureSigner> updateSignatureSigner(String id, SignatureSigner signatureSigner) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/signature_signer/$id',
        data: signatureSigner.toJson(),
      );
      return SignatureSigner.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete SignatureSigner
  Future<void> deleteSignatureSigner(String id) async {
    try {
      await _dioClient.delete('/api/v1/signature_signer/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
