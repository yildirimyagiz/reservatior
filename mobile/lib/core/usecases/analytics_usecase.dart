import 'package:reservatior/shared/repositories/analytics_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetAnalyticsByIdUseCase {
  final AnalyticsRepository _repository;
  GetAnalyticsByIdUseCase(this._repository);
  Future<Analytics> execute(String id) => _repository.getById(id);
}

class GetAnalyticssUseCase {
  final AnalyticsRepository _repository;
  GetAnalyticssUseCase(this._repository);
  Future<List<Analytics>> execute({
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

class CreateAnalyticsUseCase {
  final AnalyticsRepository _repository;
  CreateAnalyticsUseCase(this._repository);
  Future<Analytics> execute(Analytics item) => _repository.create(item);
}

class UpdateAnalyticsUseCase {
  final AnalyticsRepository _repository;
  UpdateAnalyticsUseCase(this._repository);
  Future<Analytics> execute(String id, Analytics item) => _repository.update(id, item);
}

class DeleteAnalyticsUseCase {
  final AnalyticsRepository _repository;
  DeleteAnalyticsUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
