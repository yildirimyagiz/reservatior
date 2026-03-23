import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class InvestorPortfolioService {
  final DioClient _dioClient;

  InvestorPortfolioService(this._dioClient);

  // Get InvestorPortfolio by ID
  Future<InvestorPortfolio> getInvestorPortfolioById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/investor_portfolio/$id');
      return InvestorPortfolio.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all investor_portfolios
  Future<List<InvestorPortfolio>> getInvestorPortfolios({
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

      final response = await _dioClient.get('/api/v1/investor_portfolio', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => InvestorPortfolio.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create InvestorPortfolio
  Future<InvestorPortfolio> createInvestorPortfolio(InvestorPortfolio investorPortfolio) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/investor_portfolio',
        data: investorPortfolio.toJson(),
      );
      return InvestorPortfolio.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update InvestorPortfolio
  Future<InvestorPortfolio> updateInvestorPortfolio(String id, InvestorPortfolio investorPortfolio) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/investor_portfolio/$id',
        data: investorPortfolio.toJson(),
      );
      return InvestorPortfolio.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete InvestorPortfolio
  Future<void> deleteInvestorPortfolio(String id) async {
    try {
      await _dioClient.delete('/api/v1/investor_portfolio/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
