import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/review_service.dart';

abstract class ReviewRepository {
  Future<Review> getById(String id);
  Future<List<Review>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Review> create(Review item);
  Future<Review> update(String id, Review item);
  Future<void> delete(String id);
}

class ReviewRepositoryImpl implements ReviewRepository {
  final ReviewService _service;
  ReviewRepositoryImpl(this._service);

  @override
  Future<Review> getById(String id) => _service.getReviewById(id);

  @override
  Future<List<Review>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getReviews(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Review> create(Review item) => _service.createReview(item);

  @override
  Future<Review> update(String id, Review item) => _service.updateReview(id, item);

  @override
  Future<void> delete(String id) => _service.deleteReview(id);
}
