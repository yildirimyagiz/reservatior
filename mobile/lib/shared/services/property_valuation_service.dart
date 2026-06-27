import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/core/network/api_endpoints.dart';
import 'package:reservatior/shared/models/property_valuation.dart';

class PropertyValuationService {
  final DioClient _dioClient;
  PropertyValuationService(this._dioClient);

  // Property Valuations
  Future<PropertyValuation> getPropertyValuationById(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.valuations}/$id');
    return PropertyValuation.fromJson(response.data['data']);
  }

  Future<List<PropertyValuation>> getPropertyValuations({
    int page = 1, 
    int limit = 20, 
    String? orgId,
    String? propertyId,
    String? agentId,
    String? status,
    String? valuationType,
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) async {
    final queryParams = {
      'page': page, 
      'limit': limit,
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (agentId != null) 'agentId': agentId,
      if (status != null) 'status': status,
      if (valuationType != null) 'valuationType': valuationType,
      if (sortBy != null) 'sortBy': sortBy,
      if (sortOrder != null) 'sortOrder': sortOrder,
      ...?filters
    };
    final response = await _dioClient.get(ApiEndpoints.valuations, queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyValuation.fromJson(json)).toList();
  }

  Future<PropertyValuation> createValuation({
    required String propertyId,
    String? valuationType,
    String? priority,
    Map<String, dynamic>? contactInfo,
    Map<String, dynamic>? propertyData,
    String? videoUrl,
    List<String>? images,
    List<String>? requirements,
  }) async {
    final data = {
      'propertyId': propertyId,
      if (valuationType != null) 'valuationType': valuationType,
      if (priority != null) 'priority': priority,
      if (contactInfo != null) 'contactInfo': contactInfo,
      if (propertyData != null) 'propertyData': propertyData,
      if (videoUrl != null) 'videoUrl': videoUrl,
      if (images != null) 'images': images,
      if (requirements != null) 'requirements': requirements,
    };
    final response = await _dioClient.post(ApiEndpoints.valuations, data: data);
    return PropertyValuation.fromJson(response.data['data']);
  }

  Future<PropertyValuation> updatePropertyValuation(String id, {
    double? value,
    double? confidence,
    String? status,
    Map<String, dynamic>? priceRange,
    Map<String, dynamic>? marketTrends,
    List<dynamic>? comparableProperties,
    Map<String, dynamic>? factors,
    Map<String, dynamic>? aiAnalysis,
    Map<String, dynamic>? videoAnalysis,
    Map<String, dynamic>? userBehavior,
    List<String>? recommendations,
  }) async {
    final data = {
      if (value != null) 'value': value,
      if (confidence != null) 'confidence': confidence,
      if (status != null) 'status': status,
      if (priceRange != null) 'priceRange': priceRange,
      if (marketTrends != null) 'marketTrends': marketTrends,
      if (comparableProperties != null) 'comparableProperties': comparableProperties,
      if (factors != null) 'factors': factors,
      if (aiAnalysis != null) 'aiAnalysis': aiAnalysis,
      if (videoAnalysis != null) 'videoAnalysis': videoAnalysis,
      if (userBehavior != null) 'userBehavior': userBehavior,
      if (recommendations != null) 'recommendations': recommendations,
    };
    final response = await _dioClient.patch('${ApiEndpoints.valuations}/$id', data: data);
    return PropertyValuation.fromJson(response.data['data']);
  }

  Future<void> deletePropertyValuation(String id) async {
    await _dioClient.delete('${ApiEndpoints.valuations}/$id');
  }

  // Valuation Processing
  Future<PropertyValuation> processValuation(String id) async {
    final response = await _dioClient.post('${ApiEndpoints.valuations}/$id/process');
    return PropertyValuation.fromJson(response.data['valuation']);
  }

  // Valuation Analytics
  Future<Map<String, dynamic>> getValuationAnalytics(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.valuations}/$id/analytics');
    return response.data as Map<String, dynamic>;
  }

  // Valuation Reports
  Future<ValuationReport> createValuationReport(String id, {
    String? reportType,
    String? format,
    Map<String, dynamic>? content,
    String? summary,
    List<String>? insights,
    List<String>? recommendations,
    Map<String, dynamic>? charts,
    bool? isPublic,
  }) async {
    final data = {
      if (reportType != null) 'reportType': reportType,
      if (format != null) 'format': format,
      if (content != null) 'content': content,
      if (summary != null) 'summary': summary,
      if (insights != null) 'insights': insights,
      if (recommendations != null) 'recommendations': recommendations,
      if (charts != null) 'charts': charts,
      if (isPublic != null) 'isPublic': isPublic,
    };
    final response = await _dioClient.post('${ApiEndpoints.valuations}/$id/reports', data: data);
    return ValuationReport.fromJson(response.data['report']);
  }

  Future<List<ValuationReport>> getValuationReports(String id) async {
    final response = await _dioClient.get('${ApiEndpoints.valuations}/$id/reports');
    final data = response.data['data'] as List;
    return data.map((json) => ValuationReport.fromJson(json)).toList();
  }

  Future<ValuationReport> getPublicReport(String shareToken) async {
    final response = await _dioClient.get('${ApiEndpoints.valuations}/public/$shareToken');
    return ValuationReport.fromJson(response.data['data']);
  }

  // Bulk Operations
  Future<List<PropertyValuation>> bulkUpdateValuations(List<String> ids, Map<String, dynamic> data) async {
    final response = await _dioClient.patch('${ApiEndpoints.valuations}/bulk', data: {
      'ids': ids,
      ...data,
    });
    final responseData = response.data['data'] as List;
    return responseData.map((json) => PropertyValuation.fromJson(json)).toList();
  }

  // Export
  Future<void> exportValuations({
    String? format,
    String? propertyId,
    String? status,
    String? dateFrom,
    String? dateTo,
  }) async {
    final queryParams = {
      if (format != null) 'format': format,
      if (propertyId != null) 'propertyId': propertyId,
      if (status != null) 'status': status,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
    };
    await _dioClient.get('${ApiEndpoints.valuations}/export', queryParameters: queryParams);
  }

  // Search
  Future<List<PropertyValuation>> searchValuations(String query, {
    String? propertyId,
    String? status,
    String? valuationType,
    String? dateFrom,
    String? dateTo,
  }) async {
    final queryParams = {
      'query': query,
      if (propertyId != null) 'propertyId': propertyId,
      if (status != null) 'status': status,
      if (valuationType != null) 'valuationType': valuationType,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
    };
    final response = await _dioClient.get('${ApiEndpoints.valuations}/search', queryParameters: queryParams);
    final data = response.data['data'] as List;
    return data.map((json) => PropertyValuation.fromJson(json)).toList();
  }

  // Statistics
  Future<Map<String, dynamic>> getValuationStats({
    String? orgId,
    String? propertyId,
    String? dateFrom,
    String? dateTo,
  }) async {
    final queryParams = {
      if (orgId != null) 'orgId': orgId,
      if (propertyId != null) 'propertyId': propertyId,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
    };
    final response = await _dioClient.get('${ApiEndpoints.valuations}/stats', queryParameters: queryParams);
    return response.data as Map<String, dynamic>;
  }
}
