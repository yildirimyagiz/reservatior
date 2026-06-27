import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/listing_status_history_service.dart';

abstract class ListingStatusHistoryRepository {
  Future<ListingStatusHistory> getById(String id);
  Future<List<ListingStatusHistory>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ListingStatusHistory> create(ListingStatusHistory item);
  Future<ListingStatusHistory> update(String id, ListingStatusHistory item);
  Future<void> delete(String id);
}

class ListingStatusHistoryRepositoryImpl implements ListingStatusHistoryRepository {
  final ListingStatusHistoryService _service;
  ListingStatusHistoryRepositoryImpl(this._service);

  @override
  Future<ListingStatusHistory> getById(String id) => _service.getListingStatusHistoryById(id);

  @override
  Future<List<ListingStatusHistory>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getListingStatusHistories(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ListingStatusHistory> create(ListingStatusHistory item) => _service.createListingStatusHistory(item);

  @override
  Future<ListingStatusHistory> update(String id, ListingStatusHistory item) => _service.updateListingStatusHistory(id, item);

  @override
  Future<void> delete(String id) => _service.deleteListingStatusHistory(id);
}
