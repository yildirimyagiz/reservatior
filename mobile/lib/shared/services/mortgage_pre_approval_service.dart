import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class MortgagePreApprovalService {
  final DioClient _dioClient;

  MortgagePreApprovalService(this._dioClient);

  // Get MortgagePreApproval by ID
  Future<MortgagePreApproval> getMortgagePreApprovalById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/mortgage_pre_approval/$id');
      return MortgagePreApproval.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all mortgage_pre_approvals
  Future<List<MortgagePreApproval>> getMortgagePreApprovals({
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

      final response = await _dioClient.get('/api/v1/mortgage_pre_approval', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => MortgagePreApproval.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create MortgagePreApproval
  Future<MortgagePreApproval> createMortgagePreApproval(MortgagePreApproval mortgagePreApproval) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/mortgage_pre_approval',
        data: mortgagePreApproval.toJson(),
      );
      return MortgagePreApproval.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update MortgagePreApproval
  Future<MortgagePreApproval> updateMortgagePreApproval(String id, MortgagePreApproval mortgagePreApproval) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/mortgage_pre_approval/$id',
        data: mortgagePreApproval.toJson(),
      );
      return MortgagePreApproval.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete MortgagePreApproval
  Future<void> deleteMortgagePreApproval(String id) async {
    try {
      await _dioClient.delete('/api/v1/mortgage_pre_approval/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
