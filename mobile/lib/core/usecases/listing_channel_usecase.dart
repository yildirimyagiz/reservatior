import '../../features/shared/services/listing_channel_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ListingChannel

class GetListingChannelByIdUseCase {
  final ListingChannelService _service;
  
  GetListingChannelByIdUseCase(this._service);
  
  Future<ListingChannel> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetListingChannelsUseCase {
  final ListingChannelService _service;
  
  GetListingChannelsUseCase(this._service);
  
  Future<List<ListingChannel>> execute({
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

class CreateListingChannelUseCase {
  final ListingChannelService _service;
  
  CreateListingChannelUseCase(this._service);
  
  Future<ListingChannel> execute(ListingChannel listingChannel) async {
    // Add validation logic here
    return await _service.create(listingChannel);
  }
}

class UpdateListingChannelUseCase {
  final ListingChannelService _service;
  
  UpdateListingChannelUseCase(this._service);
  
  Future<ListingChannel> execute(String id, ListingChannel listingChannel) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, listingChannel);
  }
}

class DeleteListingChannelUseCase {
  final ListingChannelService _service;
  
  DeleteListingChannelUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ListingChannel Use Case Container
class ListingChannelUseCases {
  final GetListingChannelByIdUseCase getById;
  final GetListingChannelsUseCase getAll;
  final CreateListingChannelUseCase create;
  final UpdateListingChannelUseCase update;
  final DeleteListingChannelUseCase delete;
  
  ListingChannelUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ListingChannelUseCases.create(ListingChannelService service) {
    return ListingChannelUseCases(
      getById: GetListingChannelByIdUseCase(service),
      getAll: GetListingChannelsUseCase(service),
      create: CreateListingChannelUseCase(service),
      update: UpdateListingChannelUseCase(service),
      delete: DeleteListingChannelUseCase(service),
    );
  }
}
