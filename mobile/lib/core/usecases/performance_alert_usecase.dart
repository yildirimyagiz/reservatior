import 'package:reservatior/shared/repositories/performance_alert_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetPerformanceAlertByIdUseCase {
  final PerformanceAlertRepository _repository;
  GetPerformanceAlertByIdUseCase(this._repository);
  Future<PerformanceAlert> execute(String id) => _repository.getById(id);
}

class GetPerformanceAlertsUseCase {
  final PerformanceAlertRepository _repository;
  GetPerformanceAlertsUseCase(this._repository);
  Future<List<PerformanceAlert>> execute({
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

class CreatePerformanceAlertUseCase {
  final PerformanceAlertRepository _repository;
  CreatePerformanceAlertUseCase(this._repository);
  Future<PerformanceAlert> execute(PerformanceAlert item) => _repository.create(item);
}

class UpdatePerformanceAlertUseCase {
  final PerformanceAlertRepository _repository;
  UpdatePerformanceAlertUseCase(this._repository);
  Future<PerformanceAlert> execute(String id, PerformanceAlert item) => _repository.update(id, item);
}

class DeletePerformanceAlertUseCase {
  final PerformanceAlertRepository _repository;
  DeletePerformanceAlertUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
