import '../../features/shared/services/guest_review_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for GuestReview

class GetGuestReviewByIdUseCase {
  final GuestReviewService _service;
  
  GetGuestReviewByIdUseCase(this._service);
  
  Future<GuestReview> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetGuestReviewsUseCase {
  final GuestReviewService _service;
  
  GetGuestReviewsUseCase(this._service);
  
  Future<List<GuestReview>> execute({
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

class CreateGuestReviewUseCase {
  final GuestReviewService _service;
  
  CreateGuestReviewUseCase(this._service);
  
  Future<GuestReview> execute(GuestReview guestReview) async {
    // Add validation logic here
    return await _service.create(guestReview);
  }
}

class UpdateGuestReviewUseCase {
  final GuestReviewService _service;
  
  UpdateGuestReviewUseCase(this._service);
  
  Future<GuestReview> execute(String id, GuestReview guestReview) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, guestReview);
  }
}

class DeleteGuestReviewUseCase {
  final GuestReviewService _service;
  
  DeleteGuestReviewUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// GuestReview Use Case Container
class GuestReviewUseCases {
  final GetGuestReviewByIdUseCase getById;
  final GetGuestReviewsUseCase getAll;
  final CreateGuestReviewUseCase create;
  final UpdateGuestReviewUseCase update;
  final DeleteGuestReviewUseCase delete;
  
  GuestReviewUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory GuestReviewUseCases.create(GuestReviewService service) {
    return GuestReviewUseCases(
      getById: GetGuestReviewByIdUseCase(service),
      getAll: GetGuestReviewsUseCase(service),
      create: CreateGuestReviewUseCase(service),
      update: UpdateGuestReviewUseCase(service),
      delete: DeleteGuestReviewUseCase(service),
    );
  }
}
