import 'package:reservatior/shared/repositories/property_valuation_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPropertyValuationByIdUseCase {
  final PropertyValuationRepository _repository;
  GetPropertyValuationByIdUseCase(this._repository);
  Future<PropertyValuation> execute(String id) => _repository.getById(id);
}

class GetPropertyValuationsUseCase {
  final PropertyValuationRepository _repository;
  GetPropertyValuationsUseCase(this._repository);
  Future<List<PropertyValuation>> execute({
    int page = 1, 
    int limit = 20, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) => _repository.getAll(
    page: page, 
    limit: limit, 
    filters: filters,
    sortBy: sortBy,
    sortOrder: sortOrder,
  );
}

class CreatePropertyValuationUseCase {
  final PropertyValuationRepository _repository;
  CreatePropertyValuationUseCase(this._repository);
  Future<PropertyValuation> execute(PropertyValuation item) => _repository.create(
    propertyId: item.propertyId,
    valuationType: item.valuationType.name,
    contactInfo: item.contactInfo,
    propertyData: item.propertyData,
    videoUrl: item.videoUrl,
    images: item.images,
  );
}

class UpdatePropertyValuationUseCase {
  final PropertyValuationRepository _repository;
  UpdatePropertyValuationUseCase(this._repository);
  Future<PropertyValuation> execute(String id, PropertyValuation item) => _repository.update(
    id,
    value: item.value,
    confidence: item.confidence,
    status: item.status.name,
    priceRange: item.priceRange,
    marketTrends: item.marketTrends,
    comparableProperties: item.comparableProperties,
    factors: item.factors,
    aiAnalysis: item.aiAnalysis,
    videoAnalysis: item.videoAnalysis,
    userBehavior: item.userBehavior,
    recommendations: item.recommendations,
  );
}

class DeletePropertyValuationUseCase {
  final PropertyValuationRepository _repository;
  DeletePropertyValuationUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
