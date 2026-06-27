import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/language_service.dart';

abstract class LanguageRepository {
  Future<Language> getById(String id);
  Future<List<Language>> getAll({int page, int limit, String? orgId, Map<String, dynamic>? filters, String? sortBy, String? sortOrder});
  Future<Language> create(Language item);
  Future<Language> update(String id, Language item);
  Future<void> delete(String id);
}

class LanguageRepositoryImpl implements LanguageRepository {
  final LanguageService _service;
  LanguageRepositoryImpl(this._service);

  @override
  Future<Language> getById(String id) => _service.getLanguageById(id);

  @override
  Future<List<Language>> getAll({
    int page = 1, 
    int limit = 20, 
    String? orgId, 
    Map<String, dynamic>? filters,
    String? sortBy,
    String? sortOrder,
  }) {
    return _service.getLanguages(
      page: page, 
      limit: limit, 
      orgId: orgId, 
      filters: filters,
      sortBy: sortBy,
      sortOrder: sortOrder,
    );
  }

  @override
  Future<Language> create(Language item) => _service.createLanguage(item);

  @override
  Future<Language> update(String id, Language item) => _service.updateLanguage(id, item);

  @override
  Future<void> delete(String id) => _service.deleteLanguage(id);
}
