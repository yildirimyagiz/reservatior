import 'package:reservatior/shared/repositories/tax1099_form_repository.dart';
import 'package:reservatior/shared/models/models.dart';

class GetTax1099FormByIdUseCase {
  final Tax1099FormRepository _repository;
  GetTax1099FormByIdUseCase(this._repository);
  Future<Tax1099Form> execute(String id) => _repository.getById(id);
}

class GetTax1099FormsUseCase {
  final Tax1099FormRepository _repository;
  GetTax1099FormsUseCase(this._repository);
  Future<List<Tax1099Form>> execute({
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

class CreateTax1099FormUseCase {
  final Tax1099FormRepository _repository;
  CreateTax1099FormUseCase(this._repository);
  Future<Tax1099Form> execute(Tax1099Form item) => _repository.create(item);
}

class UpdateTax1099FormUseCase {
  final Tax1099FormRepository _repository;
  UpdateTax1099FormUseCase(this._repository);
  Future<Tax1099Form> execute(String id, Tax1099Form item) => _repository.update(id, item);
}

class DeleteTax1099FormUseCase {
  final Tax1099FormRepository _repository;
  DeleteTax1099FormUseCase(this._repository);
  Future<void> execute(String id) => _repository.delete(id);
}
