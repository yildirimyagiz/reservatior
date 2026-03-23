import '../../features/shared/services/property_offer_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for PropertyOffer

class GetPropertyOfferByIdUseCase {
  final PropertyOfferService _service;
  
  GetPropertyOfferByIdUseCase(this._service);
  
  Future<PropertyOffer> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetPropertyOffersUseCase {
  final PropertyOfferService _service;
  
  GetPropertyOffersUseCase(this._service);
  
  Future<List<PropertyOffer>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreatePropertyOfferUseCase {
  final PropertyOfferService _service;
  
  CreatePropertyOfferUseCase(this._service);
  
  Future<PropertyOffer> execute(PropertyOffer propertyOffer) async {
    // Add validation logic here
    return await _service.create(propertyOffer);
  }
}

class UpdatePropertyOfferUseCase {
  final PropertyOfferService _service;
  
  UpdatePropertyOfferUseCase(this._service);
  
  Future<PropertyOffer> execute(String id, PropertyOffer propertyOffer) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, propertyOffer);
  }
}

class DeletePropertyOfferUseCase {
  final PropertyOfferService _service;
  
  DeletePropertyOfferUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// PropertyOffer Use Case Container
class PropertyOfferUseCases {
  final GetPropertyOfferByIdUseCase getById;
  final GetPropertyOffersUseCase getAll;
  final CreatePropertyOfferUseCase create;
  final UpdatePropertyOfferUseCase update;
  final DeletePropertyOfferUseCase delete;
  
  PropertyOfferUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory PropertyOfferUseCases.create(PropertyOfferService service) {
    return PropertyOfferUseCases(
      getById: GetPropertyOfferByIdUseCase(service),
      getAll: GetPropertyOffersUseCase(service),
      create: CreatePropertyOfferUseCase(service),
      update: UpdatePropertyOfferUseCase(service),
      delete: DeletePropertyOfferUseCase(service),
    );
  }
}
