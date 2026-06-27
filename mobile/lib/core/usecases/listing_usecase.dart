import 'package:reservatior/shared/repositories/listing_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetListingByIdUseCase {
  final ListingRepository _repository;
  GetListingByIdUseCase(this._repository);
  Future<Listing> execute(String id) => _repository.getById(id);
}

class GetListingsUseCase {
  final ListingRepository _repository;
  GetListingsUseCase(this._repository);
  Future<List<Listing>> execute({
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

class CreateListingUseCase {
  final ListingRepository _repository;
  CreateListingUseCase(this._repository);
  Future<Listing> execute(Listing item) => _repository.create(item);
}

class UpdateListingUseCase {
  final ListingRepository _repository;
  UpdateListingUseCase(this._repository);
  Future<Listing> execute(String id, Listing item) => _repository.update(id, item);
}

class DeleteListingUseCase {
  final ListingRepository _repository;
  DeleteListingUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
