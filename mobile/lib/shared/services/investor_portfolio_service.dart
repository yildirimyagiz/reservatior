import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/models.dart';

class InvestorPortfolioService {
  final DioClient _dioClient;
  InvestorPortfolioService(this._dioClient);

  Future<InvestorPortfolio> getInvestorPortfolioById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.investorPortfolios}/$id');
    return InvestorPortfolio.fromJson(response.data['data']);
  }

  Future<List<InvestorPortfolio>> getInvestorPortfolios({
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
    final response = await _dioClient.get(ApiEndpoints.investorPortfolios, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => InvestorPortfolio.fromJson(json)).toList();
  }

  Future<InvestorPortfolio> createInvestorPortfolio(InvestorPortfolio item) async {
    final response = await _dioClient.post(ApiEndpoints.investorPortfolios, data: item.toJson());
    return InvestorPortfolio.fromJson(response.data['data']);
  }

  Future<InvestorPortfolio> updateInvestorPortfolio(String id, InvestorPortfolio item) async {
    final response = await _dioClient.patch('${ApiEndpoints.investorPortfolios}/$id', data: item.toJson());
    return InvestorPortfolio.fromJson(response.data['data']);
  }

  Future<void> deleteInvestorPortfolio(String id) async {
    await _dioClient.delete('${ApiEndpoints.investorPortfolios}/$id');
  }
}
