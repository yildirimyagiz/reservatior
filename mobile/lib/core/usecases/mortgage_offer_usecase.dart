import '../../features/shared/services/mortgage_offer_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for MortgageOffer

class GetMortgageOfferByIdUseCase {
  final MortgageOfferService _service;
  
  GetMortgageOfferByIdUseCase(this._service);
  
  Future<MortgageOffer> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMortgageOffersUseCase {
  final MortgageOfferService _service;
  
  GetMortgageOffersUseCase(this._service);
  
  Future<List<MortgageOffer>> execute({
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

class CreateMortgageOfferUseCase {
  final MortgageOfferService _service;
  
  CreateMortgageOfferUseCase(this._service);
  
  Future<MortgageOffer> execute(MortgageOffer mortgageOffer) async {
    // Add validation logic here
    return await _service.create(mortgageOffer);
  }
}

class UpdateMortgageOfferUseCase {
  final MortgageOfferService _service;
  
  UpdateMortgageOfferUseCase(this._service);
  
  Future<MortgageOffer> execute(String id, MortgageOffer mortgageOffer) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mortgageOffer);
  }
}

class DeleteMortgageOfferUseCase {
  final MortgageOfferService _service;
  
  DeleteMortgageOfferUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// MortgageOffer Use Case Container
class MortgageOfferUseCases {
  final GetMortgageOfferByIdUseCase getById;
  final GetMortgageOffersUseCase getAll;
  final CreateMortgageOfferUseCase create;
  final UpdateMortgageOfferUseCase update;
  final DeleteMortgageOfferUseCase delete;
  
  MortgageOfferUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MortgageOfferUseCases.create(MortgageOfferService service) {
    return MortgageOfferUseCases(
      getById: GetMortgageOfferByIdUseCase(service),
      getAll: GetMortgageOffersUseCase(service),
      create: CreateMortgageOfferUseCase(service),
      update: UpdateMortgageOfferUseCase(service),
      delete: DeleteMortgageOfferUseCase(service),
    );
  }
}
