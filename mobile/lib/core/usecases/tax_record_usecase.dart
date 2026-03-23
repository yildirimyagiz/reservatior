import '../../features/shared/services/tax_record_service.dart';
import '../../gen_models/models_library.dart';

// Use Cases for TaxRecord

class GetTaxRecordByIdUseCase {
  final TaxRecordService _service;
  
  GetTaxRecordByIdUseCase(this._service);
  
  Future<TaxRecord> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.getById(id);
  }
}

class GetTaxRecordsUseCase {
  final TaxRecordService _service;
  
  GetTaxRecordsUseCase(this._service);
  
  Future<List<TaxRecord>> execute({
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

class CreateTaxRecordUseCase {
  final TaxRecordService _service;
  
  CreateTaxRecordUseCase(this._service);
  
  Future<TaxRecord> execute(TaxRecord taxRecord) async {
    // Add validation logic here
    return await _service.create(taxRecord);
  }
}

class UpdateTaxRecordUseCase {
  final TaxRecordService _service;
  
  UpdateTaxRecordUseCase(this._service);
  
  Future<TaxRecord> execute(String id, TaxRecord taxRecord) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    // Add validation logic here
    return await _service.update(id, taxRecord);
  }
}

class DeleteTaxRecordUseCase {
  final TaxRecordService _service;
  
  DeleteTaxRecordUseCase(this._service);
  
  Future<void> execute(String id) async {
    if (id.isEmpty) {
      throw ArgumentError('ID cannot be empty');
    }
    return await _service.delete(id);
  }
}

// TaxRecord Use Case Container
class TaxRecordUseCases {
  final GetTaxRecordByIdUseCase getById;
  final GetTaxRecordsUseCase getAll;
  final CreateTaxRecordUseCase create;
  final UpdateTaxRecordUseCase update;
  final DeleteTaxRecordUseCase delete;
  
  TaxRecordUseCases({
    required this.getById,
    required this.getAll,
    required this.create,
    required this.update,
    required this.delete,
  });
  
  factory TaxRecordUseCases.create(TaxRecordService service) {
    return TaxRecordUseCases(
      getById: GetTaxRecordByIdUseCase(service),
      getAll: GetTaxRecordsUseCase(service),
      create: CreateTaxRecordUseCase(service),
      update: UpdateTaxRecordUseCase(service),
      delete: DeleteTaxRecordUseCase(service),
    );
  }
}
