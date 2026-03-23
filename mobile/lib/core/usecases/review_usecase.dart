import '../../features/shared/services/review_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Review

class GetReviewByIdUseCase {
  final ReviewService _service;
  
  GetReviewByIdUseCase(this._service);
  
  Future<Review> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetReviewsUseCase {
  final ReviewService _service;
  
  GetReviewsUseCase(this._service);
  
  Future<List<Review>> execute({
    int page = 1,
    int limit = 20,
    Map<String, dynamic>? filters,
  }) async {
    if (page <= 0) {
      throw ArgumentError('Page must be greater than 0');
    }
    if (limit <= 0 || limit > 100) {
      throw ArgumentError('Limit must be between 1 and 100');
    }
    return await _service.getAll(
      page: page,
      limit: limit,
      filters: filters,
    );
  }
}

class CreateReviewUseCase {
  final ReviewService _service;
  
  CreateReviewUseCase(this._service);
  
  Future<Review> execute(Review review) async {
    // Add validation logic here
    return await _service.create(review);
  }
}

class UpdateReviewUseCase {
  final ReviewService _service;
  
  UpdateReviewUseCase(this._service);
  
  Future<Review> execute(String id, Review review) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, review);
  }
}

class DeleteReviewUseCase {
  final ReviewService _service;
  
  DeleteReviewUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Review Use Case Container
class ReviewUseCases {
  final GetReviewByIdUseCase getById;
  final GetReviewsUseCase getAll;
  final CreateReviewUseCase create;
  final UpdateReviewUseCase update;
  final DeleteReviewUseCase delete;
  
  ReviewUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ReviewUseCases.create(ReviewService service) {
    return ReviewUseCases(
      getById: GetReviewByIdUseCase(service),
      getAll: GetReviewsUseCase(service),
      create: CreateReviewUseCase(service),
      update: UpdateReviewUseCase(service),
      delete: DeleteReviewUseCase(service),
    );
  }
}
