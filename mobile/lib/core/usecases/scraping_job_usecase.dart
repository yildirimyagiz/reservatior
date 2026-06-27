import 'package:reservatior/shared/repositories/scraping_job_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetScrapingJobByIdUseCase {
  final ScrapingJobRepository _repository;
  GetScrapingJobByIdUseCase(this._repository);
  Future<ScrapingJob> execute(String id) => _repository.getById(id);
}

class GetScrapingJobsUseCase {
  final ScrapingJobRepository _repository;
  GetScrapingJobsUseCase(this._repository);
  Future<List<ScrapingJob>> execute({
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

class CreateScrapingJobUseCase {
  final ScrapingJobRepository _repository;
  CreateScrapingJobUseCase(this._repository);
  Future<ScrapingJob> execute(ScrapingJob item) => _repository.create(item);
}

class UpdateScrapingJobUseCase {
  final ScrapingJobRepository _repository;
  UpdateScrapingJobUseCase(this._repository);
  Future<ScrapingJob> execute(String id, ScrapingJob item) => _repository.update(id, item);
}

class DeleteScrapingJobUseCase {
  final ScrapingJobRepository _repository;
  DeleteScrapingJobUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
