import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/guest_review_service.dart';

abstract class GuestReviewRepository {
  Future<GuestReview> getById(String id);
  Future<List<GuestReview>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<GuestReview> create(GuestReview item);
  Future<GuestReview> update(String id, GuestReview item);
  Future<void> delete(String id);
}

class GuestReviewRepositoryImpl implements GuestReviewRepository {
  final GuestReviewService _service;
  GuestReviewRepositoryImpl(this._service);

  @override
  Future<GuestReview> getById(String id) => _service.getGuestReviewById(id);

  @override
  Future<List<GuestReview>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getGuestReviews(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<GuestReview> create(GuestReview item) => _service.createGuestReview(item);

  @override
  Future<GuestReview> update(String id, GuestReview item) => _service.updateGuestReview(id, item);

  @override
  Future<void> delete(String id) => _service.deleteGuestReview(id);
}
