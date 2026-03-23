import '../../features/shared/services/listing_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Listing

class GetListingByIdUseCase {
  final ListingService _service;
  
  GetListingByIdUseCase(this._service);
  
  Future<Listing> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetListingsUseCase {
  final ListingService _service;
  
  GetListingsUseCase(this._service);
  
  Future<List<Listing>> execute({
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

class CreateListingUseCase {
  final ListingService _service;
  
  CreateListingUseCase(this._service);
  
  Future<Listing> execute(Listing listing) async {
    // Add validation logic here
    return await _service.create(listing);
  }
}

class UpdateListingUseCase {
  final ListingService _service;
  
  UpdateListingUseCase(this._service);
  
  Future<Listing> execute(String id, Listing listing) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, listing);
  }
}

class DeleteListingUseCase {
  final ListingService _service;
  
  DeleteListingUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Listing Use Case Container
class ListingUseCases {
  final GetListingByIdUseCase getById;
  final GetListingsUseCase getAll;
  final CreateListingUseCase create;
  final UpdateListingUseCase update;
  final DeleteListingUseCase delete;
  
  ListingUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ListingUseCases.create(ListingService service) {
    return ListingUseCases(
      getById: GetListingByIdUseCase(service),
      getAll: GetListingsUseCase(service),
      create: CreateListingUseCase(service),
      update: UpdateListingUseCase(service),
      delete: DeleteListingUseCase(service),
    );
  }
}
