import '../../features/shared/services/listing_status_history_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ListingStatusHistory

class GetListingStatusHistoryByIdUseCase {
  final ListingStatusHistoryService _service;
  
  GetListingStatusHistoryByIdUseCase(this._service);
  
  Future<ListingStatusHistory> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetListingStatusHistorysUseCase {
  final ListingStatusHistoryService _service;
  
  GetListingStatusHistorysUseCase(this._service);
  
  Future<List<ListingStatusHistory>> execute({
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

class CreateListingStatusHistoryUseCase {
  final ListingStatusHistoryService _service;
  
  CreateListingStatusHistoryUseCase(this._service);
  
  Future<ListingStatusHistory> execute(ListingStatusHistory listingStatusHistory) async {
    // Add validation logic here
    return await _service.create(listingStatusHistory);
  }
}

class UpdateListingStatusHistoryUseCase {
  final ListingStatusHistoryService _service;
  
  UpdateListingStatusHistoryUseCase(this._service);
  
  Future<ListingStatusHistory> execute(String id, ListingStatusHistory listingStatusHistory) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, listingStatusHistory);
  }
}

class DeleteListingStatusHistoryUseCase {
  final ListingStatusHistoryService _service;
  
  DeleteListingStatusHistoryUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ListingStatusHistory Use Case Container
class ListingStatusHistoryUseCases {
  final GetListingStatusHistoryByIdUseCase getById;
  final GetListingStatusHistorysUseCase getAll;
  final CreateListingStatusHistoryUseCase create;
  final UpdateListingStatusHistoryUseCase update;
  final DeleteListingStatusHistoryUseCase delete;
  
  ListingStatusHistoryUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ListingStatusHistoryUseCases.create(ListingStatusHistoryService service) {
    return ListingStatusHistoryUseCases(
      getById: GetListingStatusHistoryByIdUseCase(service),
      getAll: GetListingStatusHistorysUseCase(service),
      create: CreateListingStatusHistoryUseCase(service),
      update: UpdateListingStatusHistoryUseCase(service),
      delete: DeleteListingStatusHistoryUseCase(service),
    );
  }
}
