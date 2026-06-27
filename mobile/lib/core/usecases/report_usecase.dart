import 'package:reservatior/shared/repositories/report_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetReportByIdUseCase {
  final ReportRepository _repository;
  GetReportByIdUseCase(this._repository);
  Future<Report> execute(String id) => _repository.getById(id);
}

class GetReportsUseCase {
  final ReportRepository _repository;
  GetReportsUseCase(this._repository);
  Future<List<Report>> execute({
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

class CreateReportUseCase {
  final ReportRepository _repository;
  CreateReportUseCase(this._repository);
  Future<Report> execute(Report item) => _repository.create(item);
}

class UpdateReportUseCase {
  final ReportRepository _repository;
  UpdateReportUseCase(this._repository);
  Future<Report> execute(String id, Report item) => _repository.update(id, item);
}

class DeleteReportUseCase {
  final ReportRepository _repository;
  DeleteReportUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
