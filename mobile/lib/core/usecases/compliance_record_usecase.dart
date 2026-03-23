import '../../features/shared/services/compliance_record_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for ComplianceRecord

class GetComplianceRecordByIdUseCase {
  final ComplianceRecordService _service;
  
  GetComplianceRecordByIdUseCase(this._service);
  
  Future<ComplianceRecord> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetComplianceRecordsUseCase {
  final ComplianceRecordService _service;
  
  GetComplianceRecordsUseCase(this._service);
  
  Future<List<ComplianceRecord>> execute({
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

class CreateComplianceRecordUseCase {
  final ComplianceRecordService _service;
  
  CreateComplianceRecordUseCase(this._service);
  
  Future<ComplianceRecord> execute(ComplianceRecord complianceRecord) async {
    // Add validation logic here
    return await _service.create(complianceRecord);
  }
}

class UpdateComplianceRecordUseCase {
  final ComplianceRecordService _service;
  
  UpdateComplianceRecordUseCase(this._service);
  
  Future<ComplianceRecord> execute(String id, ComplianceRecord complianceRecord) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, complianceRecord);
  }
}

class DeleteComplianceRecordUseCase {
  final ComplianceRecordService _service;
  
  DeleteComplianceRecordUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// ComplianceRecord Use Case Container
class ComplianceRecordUseCases {
  final GetComplianceRecordByIdUseCase getById;
  final GetComplianceRecordsUseCase getAll;
  final CreateComplianceRecordUseCase create;
  final UpdateComplianceRecordUseCase update;
  final DeleteComplianceRecordUseCase delete;
  
  ComplianceRecordUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory ComplianceRecordUseCases.create(ComplianceRecordService service) {
    return ComplianceRecordUseCases(
      getById: GetComplianceRecordByIdUseCase(service),
      getAll: GetComplianceRecordsUseCase(service),
      create: CreateComplianceRecordUseCase(service),
      update: UpdateComplianceRecordUseCase(service),
      delete: DeleteComplianceRecordUseCase(service),
    );
  }
}
