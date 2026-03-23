import '../../features/shared/services/external_rental_listing_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ExternalRentalListing

class GetExternalRentalListingByIdUseCase {
  final ExternalRentalListingService _service;
  
  GetExternalRentalListingByIdUseCase(this._service);
  
  Future<ExternalRentalListing> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetExternalRentalListingsUseCase {
  final ExternalRentalListingService _service;
  
  GetExternalRentalListingsUseCase(this._service);
  
  Future<List<ExternalRentalListing>> execute({
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

class CreateExternalRentalListingUseCase {
  final ExternalRentalListingService _service;
  
  CreateExternalRentalListingUseCase(this._service);
  
  Future<ExternalRentalListing> execute(ExternalRentalListing externalRentalListing) async {
    // Add validation logic here
    return await _service.create(externalRentalListing);
  }
}

class UpdateExternalRentalListingUseCase {
  final ExternalRentalListingService _service;
  
  UpdateExternalRentalListingUseCase(this._service);
  
  Future<ExternalRentalListing> execute(String id, ExternalRentalListing externalRentalListing) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, externalRentalListing);
  }
}

class DeleteExternalRentalListingUseCase {
  final ExternalRentalListingService _service;
  
  DeleteExternalRentalListingUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ExternalRentalListing Use Case Container
class ExternalRentalListingUseCases {
  final GetExternalRentalListingByIdUseCase getById;
  final GetExternalRentalListingsUseCase getAll;
  final CreateExternalRentalListingUseCase create;
  final UpdateExternalRentalListingUseCase update;
  final DeleteExternalRentalListingUseCase delete;
  
  ExternalRentalListingUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ExternalRentalListingUseCases.create(ExternalRentalListingService service) {
    return ExternalRentalListingUseCases(
      getById: GetExternalRentalListingByIdUseCase(service),
      getAll: GetExternalRentalListingsUseCase(service),
      create: CreateExternalRentalListingUseCase(service),
      update: UpdateExternalRentalListingUseCase(service),
      delete: DeleteExternalRentalListingUseCase(service),
    );
  }
}
