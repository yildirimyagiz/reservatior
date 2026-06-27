import 'package:reservatior/shared/repositories/financial_record_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetFinancialRecordByIdUseCase {
  final FinancialRecordRepository _repository;
  GetFinancialRecordByIdUseCase(this._repository);
  Future<FinancialRecord> execute(String id) => _repository.getById(id);
}

class GetFinancialRecordsUseCase {
  final FinancialRecordRepository _repository;
  GetFinancialRecordsUseCase(this._repository);
  Future<List<FinancialRecord>> execute({
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

class CreateFinancialRecordUseCase {
  final FinancialRecordRepository _repository;
  CreateFinancialRecordUseCase(this._repository);
  Future<FinancialRecord> execute(FinancialRecord item) => _repository.create(item);
}

class UpdateFinancialRecordUseCase {
  final FinancialRecordRepository _repository;
  UpdateFinancialRecordUseCase(this._repository);
  Future<FinancialRecord> execute(String id, FinancialRecord item) => _repository.update(id, item);
}

class DeleteFinancialRecordUseCase {
  final FinancialRecordRepository _repository;
  DeleteFinancialRecordUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
