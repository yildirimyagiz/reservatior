import 'package:reservatior/shared/repositories/guest_review_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetGuestReviewByIdUseCase {
  final GuestReviewRepository _repository;
  GetGuestReviewByIdUseCase(this._repository);
  Future<GuestReview> execute(String id) => _repository.getById(id);
}

class GetGuestReviewsUseCase {
  final GuestReviewRepository _repository;
  GetGuestReviewsUseCase(this._repository);
  Future<List<GuestReview>> execute({
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

class CreateGuestReviewUseCase {
  final GuestReviewRepository _repository;
  CreateGuestReviewUseCase(this._repository);
  Future<GuestReview> execute(GuestReview item) => _repository.create(item);
}

class UpdateGuestReviewUseCase {
  final GuestReviewRepository _repository;
  UpdateGuestReviewUseCase(this._repository);
  Future<GuestReview> execute(String id, GuestReview item) => _repository.update(id, item);
}

class DeleteGuestReviewUseCase {
  final GuestReviewRepository _repository;
  DeleteGuestReviewUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
