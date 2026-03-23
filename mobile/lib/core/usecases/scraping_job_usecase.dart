import '../../features/shared/services/scraping_job_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ScrapingJob

class GetScrapingJobByIdUseCase {
  final ScrapingJobService _service;
  
  GetScrapingJobByIdUseCase(this._service);
  
  Future<ScrapingJob> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetScrapingJobsUseCase {
  final ScrapingJobService _service;
  
  GetScrapingJobsUseCase(this._service);
  
  Future<List<ScrapingJob>> execute({
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

class CreateScrapingJobUseCase {
  final ScrapingJobService _service;
  
  CreateScrapingJobUseCase(this._service);
  
  Future<ScrapingJob> execute(ScrapingJob scrapingJob) async {
    // Add validation logic here
    return await _service.create(scrapingJob);
  }
}

class UpdateScrapingJobUseCase {
  final ScrapingJobService _service;
  
  UpdateScrapingJobUseCase(this._service);
  
  Future<ScrapingJob> execute(String id, ScrapingJob scrapingJob) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, scrapingJob);
  }
}

class DeleteScrapingJobUseCase {
  final ScrapingJobService _service;
  
  DeleteScrapingJobUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ScrapingJob Use Case Container
class ScrapingJobUseCases {
  final GetScrapingJobByIdUseCase getById;
  final GetScrapingJobsUseCase getAll;
  final CreateScrapingJobUseCase create;
  final UpdateScrapingJobUseCase update;
  final DeleteScrapingJobUseCase delete;
  
  ScrapingJobUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ScrapingJobUseCases.create(ScrapingJobService service) {
    return ScrapingJobUseCases(
      getById: GetScrapingJobByIdUseCase(service),
      getAll: GetScrapingJobsUseCase(service),
      create: CreateScrapingJobUseCase(service),
      update: UpdateScrapingJobUseCase(service),
      delete: DeleteScrapingJobUseCase(service),
    );
  }
}
