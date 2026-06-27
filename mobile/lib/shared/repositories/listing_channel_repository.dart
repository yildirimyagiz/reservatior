import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/listing_channel_service.dart';

abstract class ListingChannelRepository {
  Future<ListingChannel> getById(String id);
  Future<List<ListingChannel>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ListingChannel> create(ListingChannel item);
  Future<ListingChannel> update(String id, ListingChannel item);
  Future<void> delete(String id);
}

class ListingChannelRepositoryImpl implements ListingChannelRepository {
  final ListingChannelService _service;
  ListingChannelRepositoryImpl(this._service);

  @override
  Future<ListingChannel> getById(String id) => _service.getListingChannelById(id);

  @override
  Future<List<ListingChannel>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getListingChannels(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ListingChannel> create(ListingChannel item) => _service.createListingChannel(item);

  @override
  Future<ListingChannel> update(String id, ListingChannel item) => _service.updateListingChannel(id, item);

  @override
  Future<void> delete(String id) => _service.deleteListingChannel(id);
}
