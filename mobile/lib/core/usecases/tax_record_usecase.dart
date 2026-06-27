import 'package:reservatior/shared/repositories/tax_record_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetTaxRecordByIdUseCase {
  final TaxRecordRepository _repository;
  GetTaxRecordByIdUseCase(this._repository);
  Future<TaxRecord> execute(String id) => _repository.getById(id);
}

class GetTaxRecordsUseCase {
  final TaxRecordRepository _repository;
  GetTaxRecordsUseCase(this._repository);
  Future<List<TaxRecord>> execute({
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

class CreateTaxRecordUseCase {
  final TaxRecordRepository _repository;
  CreateTaxRecordUseCase(this._repository);
  Future<TaxRecord> execute(TaxRecord item) => _repository.create(item);
}

class UpdateTaxRecordUseCase {
  final TaxRecordRepository _repository;
  UpdateTaxRecordUseCase(this._repository);
  Future<TaxRecord> execute(String id, TaxRecord item) => _repository.update(id, item);
}

class DeleteTaxRecordUseCase {
  final TaxRecordRepository _repository;
  DeleteTaxRecordUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
