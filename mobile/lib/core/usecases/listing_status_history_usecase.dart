import 'package:reservatior/shared/repositories/listing_status_history_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetListingStatusHistoryByIdUseCase {
  final ListingStatusHistoryRepository _repository;
  GetListingStatusHistoryByIdUseCase(this._repository);
  Future<ListingStatusHistory> execute(String id) => _repository.getById(id);
}

class GetListingStatusHistorysUseCase {
  final ListingStatusHistoryRepository _repository;
  GetListingStatusHistorysUseCase(this._repository);
  Future<List<ListingStatusHistory>> execute({
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

class CreateListingStatusHistoryUseCase {
  final ListingStatusHistoryRepository _repository;
  CreateListingStatusHistoryUseCase(this._repository);
  Future<ListingStatusHistory> execute(ListingStatusHistory item) => _repository.create(item);
}

class UpdateListingStatusHistoryUseCase {
  final ListingStatusHistoryRepository _repository;
  UpdateListingStatusHistoryUseCase(this._repository);
  Future<ListingStatusHistory> execute(String id, ListingStatusHistory item) => _repository.update(id, item);
}

class DeleteListingStatusHistoryUseCase {
  final ListingStatusHistoryRepository _repository;
  DeleteListingStatusHistoryUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
