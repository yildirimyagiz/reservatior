import 'package:reservatior/shared/repositories/compliance_record_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetComplianceRecordByIdUseCase {
  final ComplianceRecordRepository _repository;
  GetComplianceRecordByIdUseCase(this._repository);
  Future<ComplianceRecord> execute(String id) => _repository.getById(id);
}

class GetComplianceRecordsUseCase {
  final ComplianceRecordRepository _repository;
  GetComplianceRecordsUseCase(this._repository);
  Future<List<ComplianceRecord>> execute({
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

class CreateComplianceRecordUseCase {
  final ComplianceRecordRepository _repository;
  CreateComplianceRecordUseCase(this._repository);
  Future<ComplianceRecord> execute(ComplianceRecord item) => _repository.create(item);
}

class UpdateComplianceRecordUseCase {
  final ComplianceRecordRepository _repository;
  UpdateComplianceRecordUseCase(this._repository);
  Future<ComplianceRecord> execute(String id, ComplianceRecord item) => _repository.update(id, item);
}

class DeleteComplianceRecordUseCase {
  final ComplianceRecordRepository _repository;
  DeleteComplianceRecordUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
