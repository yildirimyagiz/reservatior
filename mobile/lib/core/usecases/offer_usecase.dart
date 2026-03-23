import '../../features/shared/services/offer_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Offer

class GetOfferByIdUseCase {
  final OfferService _service;
  
  GetOfferByIdUseCase(this._service);
  
  Future<Offer> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetOffersUseCase {
  final OfferService _service;
  
  GetOffersUseCase(this._service);
  
  Future<List<Offer>> execute({
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

class CreateOfferUseCase {
  final OfferService _service;
  
  CreateOfferUseCase(this._service);
  
  Future<Offer> execute(Offer offer) async {
    // Add validation logic here
    return await _service.create(offer);
  }
}

class UpdateOfferUseCase {
  final OfferService _service;
  
  UpdateOfferUseCase(this._service);
  
  Future<Offer> execute(String id, Offer offer) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, offer);
  }
}

class DeleteOfferUseCase {
  final OfferService _service;
  
  DeleteOfferUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Offer Use Case Container
class OfferUseCases {
  final GetOfferByIdUseCase getById;
  final GetOffersUseCase getAll;
  final CreateOfferUseCase create;
  final UpdateOfferUseCase update;
  final DeleteOfferUseCase delete;
  
  OfferUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory OfferUseCases.create(OfferService service) {
    return OfferUseCases(
      getById: GetOfferByIdUseCase(service),
      getAll: GetOffersUseCase(service),
      create: CreateOfferUseCase(service),
      update: UpdateOfferUseCase(service),
      delete: DeleteOfferUseCase(service),
    );
  }
}
