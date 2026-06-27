import 'package:reservatior/shared/repositories/review_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetReviewByIdUseCase {
  final ReviewRepository _repository;
  GetReviewByIdUseCase(this._repository);
  Future<Review> execute(String id) => _repository.getById(id);
}

class GetReviewsUseCase {
  final ReviewRepository _repository;
  GetReviewsUseCase(this._repository);
  Future<List<Review>> execute({
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

class CreateReviewUseCase {
  final ReviewRepository _repository;
  CreateReviewUseCase(this._repository);
  Future<Review> execute(Review item) => _repository.create(item);
}

class UpdateReviewUseCase {
  final ReviewRepository _repository;
  UpdateReviewUseCase(this._repository);
  Future<Review> execute(String id, Review item) => _repository.update(id, item);
}

class DeleteReviewUseCase {
  final ReviewRepository _repository;
  DeleteReviewUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
