import '../../features/shared/services/language_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Language

class GetLanguageByIdUseCase {
  final LanguageService _service;
  
  GetLanguageByIdUseCase(this._service);
  
  Future<Language> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetLanguagesUseCase {
  final LanguageService _service;
  
  GetLanguagesUseCase(this._service);
  
  Future<List<Language>> execute({
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

class CreateLanguageUseCase {
  final LanguageService _service;
  
  CreateLanguageUseCase(this._service);
  
  Future<Language> execute(Language language) async {
    // Add validation logic here
    return await _service.create(language);
  }
}

class UpdateLanguageUseCase {
  final LanguageService _service;
  
  UpdateLanguageUseCase(this._service);
  
  Future<Language> execute(String id, Language language) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, language);
  }
}

class DeleteLanguageUseCase {
  final LanguageService _service;
  
  DeleteLanguageUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Language Use Case Container
class LanguageUseCases {
  final GetLanguageByIdUseCase getById;
  final GetLanguagesUseCase getAll;
  final CreateLanguageUseCase create;
  final UpdateLanguageUseCase update;
  final DeleteLanguageUseCase delete;
  
  LanguageUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory LanguageUseCases.create(LanguageService service) {
    return LanguageUseCases(
      getById: GetLanguageByIdUseCase(service),
      getAll: GetLanguagesUseCase(service),
      create: CreateLanguageUseCase(service),
      update: UpdateLanguageUseCase(service),
      delete: DeleteLanguageUseCase(service),
    );
  }
}
