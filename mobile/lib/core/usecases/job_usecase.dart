import '../../features/shared/services/job_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Job

class GetJobByIdUseCase {
  final JobService _service;
  
  GetJobByIdUseCase(this._service);
  
  Future<Job> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetJobsUseCase {
  final JobService _service;
  
  GetJobsUseCase(this._service);
  
  Future<List<Job>> execute({
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

class CreateJobUseCase {
  final JobService _service;
  
  CreateJobUseCase(this._service);
  
  Future<Job> execute(Job job) async {
    // Add validation logic here
    return await _service.create(job);
  }
}

class UpdateJobUseCase {
  final JobService _service;
  
  UpdateJobUseCase(this._service);
  
  Future<Job> execute(String id, Job job) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, job);
  }
}

class DeleteJobUseCase {
  final JobService _service;
  
  DeleteJobUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Job Use Case Container
class JobUseCases {
  final GetJobByIdUseCase getById;
  final GetJobsUseCase getAll;
  final CreateJobUseCase create;
  final UpdateJobUseCase update;
  final DeleteJobUseCase delete;
  
  JobUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory JobUseCases.create(JobService service) {
    return JobUseCases(
      getById: GetJobByIdUseCase(service),
      getAll: GetJobsUseCase(service),
      create: CreateJobUseCase(service),
      update: UpdateJobUseCase(service),
      delete: DeleteJobUseCase(service),
    );
  }
}
