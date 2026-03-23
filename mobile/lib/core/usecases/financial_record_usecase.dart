import '../../features/shared/services/financial_record_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for FinancialRecord

class GetFinancialRecordByIdUseCase {
  final FinancialRecordService _service;
  
  GetFinancialRecordByIdUseCase(this._service);
  
  Future<FinancialRecord> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetFinancialRecordsUseCase {
  final FinancialRecordService _service;
  
  GetFinancialRecordsUseCase(this._service);
  
  Future<List<FinancialRecord>> execute({
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

class CreateFinancialRecordUseCase {
  final FinancialRecordService _service;
  
  CreateFinancialRecordUseCase(this._service);
  
  Future<FinancialRecord> execute(FinancialRecord financialRecord) async {
    // Add validation logic here
    return await _service.create(financialRecord);
  }
}

class UpdateFinancialRecordUseCase {
  final FinancialRecordService _service;
  
  UpdateFinancialRecordUseCase(this._service);
  
  Future<FinancialRecord> execute(String id, FinancialRecord financialRecord) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, financialRecord);
  }
}

class DeleteFinancialRecordUseCase {
  final FinancialRecordService _service;
  
  DeleteFinancialRecordUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// FinancialRecord Use Case Container
class FinancialRecordUseCases {
  final GetFinancialRecordByIdUseCase getById;
  final GetFinancialRecordsUseCase getAll;
  final CreateFinancialRecordUseCase create;
  final UpdateFinancialRecordUseCase update;
  final DeleteFinancialRecordUseCase delete;
  
  FinancialRecordUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory FinancialRecordUseCases.create(FinancialRecordService service) {
    return FinancialRecordUseCases(
      getById: GetFinancialRecordByIdUseCase(service),
      getAll: GetFinancialRecordsUseCase(service),
      create: CreateFinancialRecordUseCase(service),
      update: UpdateFinancialRecordUseCase(service),
      delete: DeleteFinancialRecordUseCase(service),
    );
  }
}
