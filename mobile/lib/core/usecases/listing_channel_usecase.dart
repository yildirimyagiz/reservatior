import 'package:reservatior/shared/repositories/listing_channel_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetListingChannelByIdUseCase {
  final ListingChannelRepository _repository;
  GetListingChannelByIdUseCase(this._repository);
  Future<ListingChannel> execute(String id) => _repository.getById(id);
}

class GetListingChannelsUseCase {
  final ListingChannelRepository _repository;
  GetListingChannelsUseCase(this._repository);
  Future<List<ListingChannel>> execute({
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

class CreateListingChannelUseCase {
  final ListingChannelRepository _repository;
  CreateListingChannelUseCase(this._repository);
  Future<ListingChannel> execute(ListingChannel item) => _repository.create(item);
}

class UpdateListingChannelUseCase {
  final ListingChannelRepository _repository;
  UpdateListingChannelUseCase(this._repository);
  Future<ListingChannel> execute(String id, ListingChannel item) => _repository.update(id, item);
}

class DeleteListingChannelUseCase {
  final ListingChannelRepository _repository;
  DeleteListingChannelUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
