import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/listing_tag_service.dart';

abstract class ListingTagRepository {
  Future<ListingTag> getById(String id);
  Future<List<ListingTag>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<ListingTag> create(ListingTag item);
  Future<ListingTag> update(String id, ListingTag item);
  Future<void> delete(String id);
}

class ListingTagRepositoryImpl implements ListingTagRepository {
  final ListingTagService _service;
  ListingTagRepositoryImpl(this._service);

  @override
  Future<ListingTag> getById(String id) => _service.getListingTagById(id);

  @override
  Future<List<ListingTag>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getListingTags(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<ListingTag> create(ListingTag item) => _service.createListingTag(item);

  @override
  Future<ListingTag> update(String id, ListingTag item) => _service.updateListingTag(id, item);

  @override
  Future<void> delete(String id) => _service.deleteListingTag(id);
}
