import '../../features/shared/services/report_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for Report

class GetReportByIdUseCase {
  final ReportService _service;
  
  GetReportByIdUseCase(this._service);
  
  Future<Report> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetReportsUseCase {
  final ReportService _service;
  
  GetReportsUseCase(this._service);
  
  Future<List<Report>> execute({
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

class CreateReportUseCase {
  final ReportService _service;
  
  CreateReportUseCase(this._service);
  
  Future<Report> execute(Report report) async {
    // Add validation logic here
    return await _service.create(report);
  }
}

class UpdateReportUseCase {
  final ReportService _service;
  
  UpdateReportUseCase(this._service);
  
  Future<Report> execute(String id, Report report) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, report);
  }
}

class DeleteReportUseCase {
  final ReportService _service;
  
  DeleteReportUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// Report Use Case Container
class ReportUseCases {
  final GetReportByIdUseCase getById;
  final GetReportsUseCase getAll;
  final CreateReportUseCase create;
  final UpdateReportUseCase update;
  final DeleteReportUseCase delete;
  
  ReportUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ReportUseCases.create(ReportService service) {
    return ReportUseCases(
      getById: GetReportByIdUseCase(service),
      getAll: GetReportsUseCase(service),
      create: CreateReportUseCase(service),
      update: UpdateReportUseCase(service),
      delete: DeleteReportUseCase(service),
    );
  }
}
