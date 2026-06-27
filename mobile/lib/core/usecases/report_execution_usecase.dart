import 'package:reservatior/shared/repositories/report_execution_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetReportExecutionByIdUseCase {
  final ReportExecutionRepository _repository;
  GetReportExecutionByIdUseCase(this._repository);
  Future<ReportExecution> execute(String id) => _repository.getById(id);
}

class GetReportExecutionsUseCase {
  final ReportExecutionRepository _repository;
  GetReportExecutionsUseCase(this._repository);
  Future<List<ReportExecution>> execute({
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

class CreateReportExecutionUseCase {
  final ReportExecutionRepository _repository;
  CreateReportExecutionUseCase(this._repository);
  Future<ReportExecution> execute(ReportExecution item) => _repository.create(item);
}

class UpdateReportExecutionUseCase {
  final ReportExecutionRepository _repository;
  UpdateReportExecutionUseCase(this._repository);
  Future<ReportExecution> execute(String id, ReportExecution item) => _repository.update(id, item);
}

class DeleteReportExecutionUseCase {
  final ReportExecutionRepository _repository;
  DeleteReportExecutionUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
