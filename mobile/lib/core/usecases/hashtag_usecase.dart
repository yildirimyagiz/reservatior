import '../../features/shared/services/hashtag_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Hashtag

class GetHashtagByIdUseCase {
  final HashtagService _service;
  
  GetHashtagByIdUseCase(this._service);
  
  Future<Hashtag> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetHashtagsUseCase {
  final HashtagService _service;
  
  GetHashtagsUseCase(this._service);
  
  Future<List<Hashtag>> execute({
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

class CreateHashtagUseCase {
  final HashtagService _service;
  
  CreateHashtagUseCase(this._service);
  
  Future<Hashtag> execute(Hashtag hashtag) async {
    // Add validation logic here
    return await _service.create(hashtag);
  }
}

class UpdateHashtagUseCase {
  final HashtagService _service;
  
  UpdateHashtagUseCase(this._service);
  
  Future<Hashtag> execute(String id, Hashtag hashtag) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, hashtag);
  }
}

class DeleteHashtagUseCase {
  final HashtagService _service;
  
  DeleteHashtagUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Hashtag Use Case Container
class HashtagUseCases {
  final GetHashtagByIdUseCase getById;
  final GetHashtagsUseCase getAll;
  final CreateHashtagUseCase create;
  final UpdateHashtagUseCase update;
  final DeleteHashtagUseCase delete;
  
  HashtagUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory HashtagUseCases.create(HashtagService service) {
    return HashtagUseCases(
      getById: GetHashtagByIdUseCase(service),
      getAll: GetHashtagsUseCase(service),
      create: CreateHashtagUseCase(service),
      update: UpdateHashtagUseCase(service),
      delete: DeleteHashtagUseCase(service),
    );
  }
}
