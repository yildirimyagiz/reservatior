import '../../features/shared/services/negotiation_offer_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for NegotiationOffer

class GetNegotiationOfferByIdUseCase {
  final NegotiationOfferService _service;
  
  GetNegotiationOfferByIdUseCase(this._service);
  
  Future<NegotiationOffer> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetNegotiationOffersUseCase {
  final NegotiationOfferService _service;
  
  GetNegotiationOffersUseCase(this._service);
  
  Future<List<NegotiationOffer>> execute({
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

class CreateNegotiationOfferUseCase {
  final NegotiationOfferService _service;
  
  CreateNegotiationOfferUseCase(this._service);
  
  Future<NegotiationOffer> execute(NegotiationOffer negotiationOffer) async {
    // Add validation logic here
    return await _service.create(negotiationOffer);
  }
}

class UpdateNegotiationOfferUseCase {
  final NegotiationOfferService _service;
  
  UpdateNegotiationOfferUseCase(this._service);
  
  Future<NegotiationOffer> execute(String id, NegotiationOffer negotiationOffer) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, negotiationOffer);
  }
}

class DeleteNegotiationOfferUseCase {
  final NegotiationOfferService _service;
  
  DeleteNegotiationOfferUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// NegotiationOffer Use Case Container
class NegotiationOfferUseCases {
  final GetNegotiationOfferByIdUseCase getById;
  final GetNegotiationOffersUseCase getAll;
  final CreateNegotiationOfferUseCase create;
  final UpdateNegotiationOfferUseCase update;
  final DeleteNegotiationOfferUseCase delete;
  
  NegotiationOfferUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory NegotiationOfferUseCases.create(NegotiationOfferService service) {
    return NegotiationOfferUseCases(
      getById: GetNegotiationOfferByIdUseCase(service),
      getAll: GetNegotiationOffersUseCase(service),
      create: CreateNegotiationOfferUseCase(service),
      update: UpdateNegotiationOfferUseCase(service),
      delete: DeleteNegotiationOfferUseCase(service),
    );
  }
}
