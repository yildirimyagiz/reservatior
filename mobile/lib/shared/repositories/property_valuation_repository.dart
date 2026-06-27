import 'package:reservatior/shared/models/property_valuation.dart';
import 'package:reservatior/shared/services/property_valuation_service.dart';

abstract class PropertyValuationRepository {
  Future<PropertyValuation> getById(String id);
  Future<List<PropertyValuation>> getAll({
    int page, 
    int limit, 
    String? orgId,
    String? propertyId,
    String? agentId,
    String? status,
    String? valuationType,
    Map<String, dynamic>? filters, 
    String? sortBy, 
    String? sortOrder
  });
  Future<PropertyValuation> create({
    required String propertyId,
    String? valuationType,
    String? priority,
    Map<String, dynamic>? contactInfo,
    Map<String, dynamic>? propertyData,
    String? videoUrl,
    List<String>? images,
    List<String>? requirements,
  });
  Future<PropertyValuation> update(String id, {
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
  });
  Future<void> delete(String id);
  
  // Advanced operations
  Future<PropertyValuation> processValuation(String id);
  Future<Map<String, dynamic>> getValuationAnalytics(String id);
  Future<ValuationReport> createValuationReport(String id, {
    String? reportType,
    String? format,
    Map<String, dynamic>? content,
    String? summary,
    List<String>? insights,
    List<String>? recommendations,
    Map<String, dynamic>? charts,
    bool? isPublic,
  });
  Future<List<ValuationReport>> getValuationReports(String id);
  Future<ValuationReport> getPublicReport(String shareToken);
  Future<List<PropertyValuation>> bulkUpdateValuations(List<String> ids, Map<String, dynamic> data);
  Future<void> exportValuations({
    String? format,
    String? propertyId,
    String? status,
    String? dateFrom,
    String? dateTo,
  });
  Future<List<PropertyValuation>> searchValuations(String query, {
    String? propertyId,
    String? status,
    String? valuationType,
    String? dateFrom,
    String? dateTo,
  });
  Future<Map<String, dynamic>> getValuationStats({
    String? orgId,
    String? propertyId,
    String? dateFrom,
    String? dateTo,
  });
}

class PropertyValuationRepositoryImpl implements PropertyValuationRepository {
  final PropertyValuationService _service;
  PropertyValuationRepositoryImpl(this._service);

  @override
  Future<PropertyValuation> getById(String id) => _service.getPropertyValuationById(id);

  @override
  Future<List<PropertyValuation>> getAll({
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
  }) {
    return _service.getPropertyValuations(
      page: page, 
      limit: limit, 
      orgId: orgId,
      propertyId: propertyId,
      agentId: agentId,
      status: status,
      valuationType: valuationType,
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<PropertyValuation> create({
    required String propertyId,
    String? valuationType,
    String? priority,
    Map<String, dynamic>? contactInfo,
    Map<String, dynamic>? propertyData,
    String? videoUrl,
    List<String>? images,
    List<String>? requirements,
  }) {
    return _service.createValuation(
      propertyId: propertyId,
      valuationType: valuationType,
      priority: priority,
      contactInfo: contactInfo,
      propertyData: propertyData,
      videoUrl: videoUrl,
      images: images,
      requirements: requirements,
    );
  }

  @override
  Future<PropertyValuation> update(String id, {
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
  }) {
    return _service.updatePropertyValuation(
      id,
      value: value,
      confidence: confidence,
      status: status,
      priceRange: priceRange,
      marketTrends: marketTrends,
      comparableProperties: comparableProperties,
      factors: factors,
      aiAnalysis: aiAnalysis,
      videoAnalysis: videoAnalysis,
      userBehavior: userBehavior,
      recommendations: recommendations,
    );
  }

  @override
  Future<void> delete(String id) => _service.deletePropertyValuation(id);

  @override
  Future<PropertyValuation> processValuation(String id) => _service.processValuation(id);

  @override
  Future<Map<String, dynamic>> getValuationAnalytics(String id) => _service.getValuationAnalytics(id);

  @override
  Future<ValuationReport> createValuationReport(String id, {
    String? reportType,
    String? format,
    Map<String, dynamic>? content,
    String? summary,
    List<String>? insights,
    List<String>? recommendations,
    Map<String, dynamic>? charts,
    bool? isPublic,
  }) {
    return _service.createValuationReport(
      id,
      reportType: reportType,
      format: format,
      content: content,
      summary: summary,
      insights: insights,
      recommendations: recommendations,
      charts: charts,
      isPublic: isPublic,
    );
  }

  @override
  Future<List<ValuationReport>> getValuationReports(String id) => _service.getValuationReports(id);

  @override
  Future<ValuationReport> getPublicReport(String shareToken) => _service.getPublicReport(shareToken);

  @override
  Future<List<PropertyValuation>> bulkUpdateValuations(List<String> ids, Map<String, dynamic> data) => 
    _service.bulkUpdateValuations(ids, data);

  @override
  Future<void> exportValuations({
    String? format,
    String? propertyId,
    String? status,
    String? dateFrom,
    String? dateTo,
  }) {
    return _service.exportValuations(
      format: format,
      propertyId: propertyId,
      status: status,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
  }

  @override
  Future<List<PropertyValuation>> searchValuations(String query, {
    String? propertyId,
    String? status,
    String? valuationType,
    String? dateFrom,
    String? dateTo,
  }) {
    return _service.searchValuations(
      query,
      propertyId: propertyId,
      status: status,
      valuationType: valuationType,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
  }

  @override
  Future<Map<String, dynamic>> getValuationStats({
    String? orgId,
    String? propertyId,
    String? dateFrom,
    String? dateTo,
  }) {
    return _service.getValuationStats(
      orgId: orgId,
      propertyId: propertyId,
      dateFrom: dateFrom,
      dateTo: dateTo,
    );
  }
}
