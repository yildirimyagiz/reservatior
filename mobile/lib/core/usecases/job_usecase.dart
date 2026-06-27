import 'package:reservatior/shared/repositories/job_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetJobByIdUseCase {
  final JobRepository _repository;
  GetJobByIdUseCase(this._repository);
  Future<Job> execute(String id) => _repository.getById(id);
}

class GetJobsUseCase {
  final JobRepository _repository;
  GetJobsUseCase(this._repository);
  Future<List<Job>> execute({
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

class CreateJobUseCase {
  final JobRepository _repository;
  CreateJobUseCase(this._repository);
  Future<Job> execute(Job item) => _repository.create(item);
}

class UpdateJobUseCase {
  final JobRepository _repository;
  UpdateJobUseCase(this._repository);
  Future<Job> execute(String id, Job item) => _repository.update(id, item);
}

class DeleteJobUseCase {
  final JobRepository _repository;
  DeleteJobUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
