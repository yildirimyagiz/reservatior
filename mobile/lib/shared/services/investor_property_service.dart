import 'package:dio/dio.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';

class InvestorPropertyService {
  final DioClient _dioClient;

  InvestorPropertyService(this._dioClient);

  // Get InvestorProperty by ID
  Future<InvestorProperty> getInvestorPropertyById(String id) async {
    try {
      final response = await _dioClient.get('/api/v1/investor_property/$id');
      return InvestorProperty.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Get all investor_propertys
  Future<List<InvestorProperty>> getInvestorPropertys({
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

      final response = await _dioClient.get('/api/v1/investor_property', queryParameters: queryParams);
      final data = response.data['data'] as List;
      return data.map((json) => InvestorProperty.fromJson(json)).toList();
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Create InvestorProperty
  Future<InvestorProperty> createInvestorProperty(InvestorProperty investorProperty) async {
    try {
      final response = await _dioClient.post(
        '/api/v1/investor_property',
        data: investorProperty.toJson(),
      );
      return InvestorProperty.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Update InvestorProperty
  Future<InvestorProperty> updateInvestorProperty(String id, InvestorProperty investorProperty) async {
    try {
      final response = await _dioClient.put(
        '/api/v1/investor_property/$id',
        data: investorProperty.toJson(),
      );
      return InvestorProperty.fromJson(response.data['data']);
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  // Delete InvestorProperty
  Future<void> deleteInvestorProperty(String id) async {
    try {
      await _dioClient.delete('/api/v1/investor_property/$id');
    } on DioException catch (e) {
      throw _handleError(e);
    }
  }

  Exception _handleError(DioException e) {
    return Exception('API Error: ${e.message}');
  }
}
