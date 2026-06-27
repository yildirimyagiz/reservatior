import 'package:reservatior/shared/repositories/listing_tag_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetListingTagByIdUseCase {
  final ListingTagRepository _repository;
  GetListingTagByIdUseCase(this._repository);
  Future<ListingTag> execute(String id) => _repository.getById(id);
}

class GetListingTagsUseCase {
  final ListingTagRepository _repository;
  GetListingTagsUseCase(this._repository);
  Future<List<ListingTag>> execute({
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

class CreateListingTagUseCase {
  final ListingTagRepository _repository;
  CreateListingTagUseCase(this._repository);
  Future<ListingTag> execute(ListingTag item) => _repository.create(item);
}

class UpdateListingTagUseCase {
  final ListingTagRepository _repository;
  UpdateListingTagUseCase(this._repository);
  Future<ListingTag> execute(String id, ListingTag item) => _repository.update(id, item);
}

class DeleteListingTagUseCase {
  final ListingTagRepository _repository;
  DeleteListingTagUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
