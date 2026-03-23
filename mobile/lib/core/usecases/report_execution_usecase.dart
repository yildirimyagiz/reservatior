import '../../features/shared/services/report_execution_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ReportExecution

class GetReportExecutionByIdUseCase {
  final ReportExecutionService _service;
  
  GetReportExecutionByIdUseCase(this._service);
  
  Future<ReportExecution> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetReportExecutionsUseCase {
  final ReportExecutionService _service;
  
  GetReportExecutionsUseCase(this._service);
  
  Future<List<ReportExecution>> execute({
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

class CreateReportExecutionUseCase {
  final ReportExecutionService _service;
  
  CreateReportExecutionUseCase(this._service);
  
  Future<ReportExecution> execute(ReportExecution reportExecution) async {
    // Add validation logic here
    return await _service.create(reportExecution);
  }
}

class UpdateReportExecutionUseCase {
  final ReportExecutionService _service;
  
  UpdateReportExecutionUseCase(this._service);
  
  Future<ReportExecution> execute(String id, ReportExecution reportExecution) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, reportExecution);
  }
}

class DeleteReportExecutionUseCase {
  final ReportExecutionService _service;
  
  DeleteReportExecutionUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ReportExecution Use Case Container
class ReportExecutionUseCases {
  final GetReportExecutionByIdUseCase getById;
  final GetReportExecutionsUseCase getAll;
  final CreateReportExecutionUseCase create;
  final UpdateReportExecutionUseCase update;
  final DeleteReportExecutionUseCase delete;
  
  ReportExecutionUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ReportExecutionUseCases.create(ReportExecutionService service) {
    return ReportExecutionUseCases(
      getById: GetReportExecutionByIdUseCase(service),
      getAll: GetReportExecutionsUseCase(service),
      create: CreateReportExecutionUseCase(service),
      update: UpdateReportExecutionUseCase(service),
      delete: DeleteReportExecutionUseCase(service),
    );
  }
}
