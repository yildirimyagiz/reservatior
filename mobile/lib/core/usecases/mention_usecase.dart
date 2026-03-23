import '../../features/shared/services/mention_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Mention

class GetMentionByIdUseCase {
  final MentionService _service;
  
  GetMentionByIdUseCase(this._service);
  
  Future<Mention> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetMentionsUseCase {
  final MentionService _service;
  
  GetMentionsUseCase(this._service);
  
  Future<List<Mention>> execute({
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

class CreateMentionUseCase {
  final MentionService _service;
  
  CreateMentionUseCase(this._service);
  
  Future<Mention> execute(Mention mention) async {
    // Add validation logic here
    return await _service.create(mention);
  }
}

class UpdateMentionUseCase {
  final MentionService _service;
  
  UpdateMentionUseCase(this._service);
  
  Future<Mention> execute(String id, Mention mention) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, mention);
  }
}

class DeleteMentionUseCase {
  final MentionService _service;
  
  DeleteMentionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Mention Use Case Container
class MentionUseCases {
  final GetMentionByIdUseCase getById;
  final GetMentionsUseCase getAll;
  final CreateMentionUseCase create;
  final UpdateMentionUseCase update;
  final DeleteMentionUseCase delete;
  
  MentionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory MentionUseCases.create(MentionService service) {
    return MentionUseCases(
      getById: GetMentionByIdUseCase(service),
      getAll: GetMentionsUseCase(service),
      create: CreateMentionUseCase(service),
      update: UpdateMentionUseCase(service),
      delete: DeleteMentionUseCase(service),
    );
  }
}
