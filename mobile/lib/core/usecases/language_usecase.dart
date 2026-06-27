import 'package:reservatior/shared/repositories/language_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetLanguageByIdUseCase {
  final LanguageRepository _repository;
  GetLanguageByIdUseCase(this._repository);
  Future<Language> execute(String id) => _repository.getById(id);
}

class GetLanguagesUseCase {
  final LanguageRepository _repository;
  GetLanguagesUseCase(this._repository);
  Future<List<Language>> execute({
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

class CreateLanguageUseCase {
  final LanguageRepository _repository;
  CreateLanguageUseCase(this._repository);
  Future<Language> execute(Language item) => _repository.create(item);
}

class UpdateLanguageUseCase {
  final LanguageRepository _repository;
  UpdateLanguageUseCase(this._repository);
  Future<Language> execute(String id, Language item) => _repository.update(id, item);
}

class DeleteLanguageUseCase {
  final LanguageRepository _repository;
  DeleteLanguageUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
