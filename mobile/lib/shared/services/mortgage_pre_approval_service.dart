import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class MortgagePreApprovalService {
  final DioClient _dioClient;
  MortgagePreApprovalService(this._dioClient);

  Future<MortgagePreApproval> getMortgagePreApprovalById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.mortgagePreApprovals}/$id');
    return MortgagePreApproval.fromJson(response.data['data']);
  }

  Future<List<MortgagePreApproval>> getMortgagePreApprovals({
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
    final response = await _dioClient.get(ApiEndpoints.mortgagePreApprovals, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => MortgagePreApproval.fromJson(json)).toList();
  }

  Future<MortgagePreApproval> createMortgagePreApproval(MortgagePreApproval item) async {
    final response = await _dioClient.post(ApiEndpoints.mortgagePreApprovals, data: item.toJson());
    return MortgagePreApproval.fromJson(response.data['data']);
  }

  Future<MortgagePreApproval> updateMortgagePreApproval(String id, MortgagePreApproval item) async {
    final response = await _dioClient.patch('${ApiEndpoints.mortgagePreApprovals}/$id', data: item.toJson());
    return MortgagePreApproval.fromJson(response.data['data']);
  }

  Future<void> deleteMortgagePreApproval(String id) async {
    await _dioClient.delete('${ApiEndpoints.mortgagePreApprovals}/$id');
  }
}
