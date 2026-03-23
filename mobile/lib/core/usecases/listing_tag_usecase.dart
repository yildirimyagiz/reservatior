import '../../features/shared/services/listing_tag_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ListingTag

class GetListingTagByIdUseCase {
  final ListingTagService _service;
  
  GetListingTagByIdUseCase(this._service);
  
  Future<ListingTag> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetListingTagsUseCase {
  final ListingTagService _service;
  
  GetListingTagsUseCase(this._service);
  
  Future<List<ListingTag>> execute({
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

class CreateListingTagUseCase {
  final ListingTagService _service;
  
  CreateListingTagUseCase(this._service);
  
  Future<ListingTag> execute(ListingTag listingTag) async {
    // Add validation logic here
    return await _service.create(listingTag);
  }
}

class UpdateListingTagUseCase {
  final ListingTagService _service;
  
  UpdateListingTagUseCase(this._service);
  
  Future<ListingTag> execute(String id, ListingTag listingTag) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, listingTag);
  }
}

class DeleteListingTagUseCase {
  final ListingTagService _service;
  
  DeleteListingTagUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ListingTag Use Case Container
class ListingTagUseCases {
  final GetListingTagByIdUseCase getById;
  final GetListingTagsUseCase getAll;
  final CreateListingTagUseCase create;
  final UpdateListingTagUseCase update;
  final DeleteListingTagUseCase delete;
  
  ListingTagUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ListingTagUseCases.create(ListingTagService service) {
    return ListingTagUseCases(
      getById: GetListingTagByIdUseCase(service),
      getAll: GetListingTagsUseCase(service),
      create: CreateListingTagUseCase(service),
      update: UpdateListingTagUseCase(service),
      delete: DeleteListingTagUseCase(service),
    );
  }
}
